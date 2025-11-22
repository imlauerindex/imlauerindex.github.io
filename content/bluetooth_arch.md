---
title: "Conectar a dispositivo bluetooth en ArchLinux y transferir archivos."
date: 2025-03-22T14:27:39-03:00
tags: ['linux']
---
Bluetooth is a standard for the short-range wireless interconnection of cellular
phones, computers, and other electronic devices. In Linux, the canonical
implementation of the Bluetooth protocol stack is BlueZ.

#### Installation

1. Install the `bluez` package, providing the Bluetooth protocol stack.
2. Install the `bluez-utils` package, providing the bluetoothctl utility. Additionally install `bluez-deprecated-tools` to have the deprecated BlueZ tools as well.
3. The generic Bluetooth driver is the btusb kernel module. Check whether that module is loaded. If it is not, then load the module.
4. Start/enable `bluetooth.service`.

```bash
sudo pacman -S bluez bluez-utils
sudo systemctl start bluetooth
bluetoothctl
> power on
> agent on
> scan on
> devices
> pair MAC_ADDRESS
> connect MAC_ADDRESS
```

En caso de una mala conexión usar `disconnect MAC_ADDRESS`

https://old.reddit.com/r/archlinux/comments/13cr6mj/how_to_setup_bluetooth_service_on_arch_linux/

## Transferir archivos

To receive **Bluetooth files from your phone to your Arch Linux PC using ONLY the command line**, the correct tool is **obexd / obexctl**, not bluetoothctl.
`bluetoothctl` handles pairing and connection, **not file transfers**.

Here is the full working setup **100% CLI only**:

---

# ✅ 1. Install needed packages

```bash
sudo pacman -S bluez bluez-utils bluez-obexd
yay -S obexftp
```

---

# ✅ 2. Enable the OBEX file-receive service

This is what actually receives files.

```bash
sudo systemctl enable --now obex.service
```

Check status:

```bash
systemctl status obex.service
```

If it fails, try the user service instead:

```bash
systemctl --user enable --now obex
```

---

# ✅ 3. Pair your phone with bluetoothctl

Enter bluetoothctl:

```bash
bluetoothctl
```

Inside:

```
power on
agent on
discoverable on
pairable on
scan on
```

Find your phone’s MAC, then:

```
pair XX:XX:XX:XX:XX:XX
trust XX:XX:XX:XX:XX:XX
```

You do **not** need to “connect” for file transfer.

---

# ✅ 4. Start OBEX file receiver manually (if needed)

Depending on your setup, you may need:

```bash
obexctl
```

Then inside obexctl:

```
power on
agent on
```

Then exit (`quit`).
Often just having `obex.service` running is enough.

---

# ✅ 5. Send a file **from your phone**

Go into your phone → “Bluetooth → Share file”.

It should show your PC as *“OBEX file transfer”*.

Send it.

---

# ✅ 6. Where do the files go?

Default directory:

```
~/Downloads/
```

Sometimes:

```
~/.cache/obexd/
```

Check both.

---

# ⭐ Full Example Setup

```bash
sudo pacman -S bluez bluez-utils obexd
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now obex.service
bluetoothctl <<EOF
power on
agent on
discoverable on
pairable on
scan on
EOF
```

On your phone: **send file → choose PC → confirm on PC if asked**.

---

# ❗ If your phone says “device doesn’t support file transfer”

Run this:

```bash
sudo sdptool add OPUSH
```

And restart Bluetooth:

```bash
sudo systemctl restart bluetooth
```

---

# If you want, I can also show:

✓ how to send files *from PC to phone* using `obexftp`
✓ how to make your PC auto-accept files without prompts
✓ how to log OBEX transfers


##### Para recibir un archivo

```bash
obexftp -b <mac_address_of_your_phone> -B 25 -l
obexftp -b <mac_address_of_your_phone> -g <filename>
```

##### Enviar un archivo desde Linux a Android:

```bash
obexftp -b <mac_address_of_your_phone> -p /path/to/your/file
```


### Para transferir archivos no necesitas obexftp solo con bluez-obex

Your log means:

**Android → Arch Linux OBEX connection succeeds,
BUT Arch Linux immediately cancels the transfer.**

This is ALWAYS caused by ONE of these four issues.

Let’s fix them one by one — the solution is short.

---

# ✅ 1) Your OBEX server has no writable download folder

MOST COMMON REASON on Arch.

Create the default directory manually:

```bash
mkdir -p ~/Downloads
chmod 700 ~/Downloads
systemctl --user restart obex.service
```

Try sending again.

If `~/Downloads` doesn’t exist, BlueZ aborts transfers exactly like your log:

```
[DEL] Transfer ...
[DEL] Session ...
```

---

# ✅ 2) Your Android device is **not trusted**

OBEX sessions get deleted instantly when the device isn’t trusted.

Run:

```bash
bluetoothctl
[bluetooth]# trust XX:XX:XX:XX:XX:XX
[bluetooth]# info XX:XX:XX:XX:XX:XX
```

Ensure it shows:

```
Trusted: yes
```

Otherwise the server drops the transfer instantly.

---

# ✅ 3) Run agent + default-agent

This is required if you're in TTY or a WM without a Bluetooth GUI.

```
bluetoothctl
[bluetooth]# agent on
[bluetooth]# default-agent
```

Without this, transfers get rejected silently.

---

# ✅ 4) Your obex.service is running as user (not root)

Verify:

```
systemctl --user status obex.service
```

Must show **active (running)**.

If not:

```
systemctl --user restart obex.service
```

---

# 🔥 QUICK FIX CHECKLIST (works for 90% of cases)

Run ALL of this exactly:

```bash
mkdir -p ~/Downloads
chmod 700 ~/Downloads

systemctl --user restart obex.service

bluetoothctl
agent on
default-agent
pairable on
discoverable on
trust XX:XX:XX:XX:XX:XX (TAB)
```

Then try sending from Android again.

---

# ❗ If it still fails

Run this and send me the error output:

```bash
journalctl --user -u obex --follow
```

Send a file from Android while this log runs.
The error message there will tell the exact cause.


---


**Perfect — now we know the problem.**
Your Android is connected using an **A2DP audio endpoint**:

```
/org/bluez/hci0/dev_CC_61_E5_D1_3A_C9/sep2/fd0
```

That is **NOT OBEX**, it’s the **Bluetooth audio (A2DP) profile**.

OBEX file transfer CANNOT use A2DP transport.
That’s why you get:

```
Transport ... not acquired
transport endpoint not found
```

You are trying to “send a file” inside a device *audio* connection, which BlueZ does not support.

---

# 🔥 REAL SOLUTION

To receive files from Android, you **must use OBEX**, not bluetoothctl *send*.

**You should NOT run send inside bluetoothctl.
Android sends the file directly to obexd.**

To fix:

---

# ✅ STEP 1 — Enable OBEX server (correct service)

```bash
systemctl --user enable --now obex.service
```

Verify:

```bash
systemctl --user status obex.service
```

Must be **active (running)**.

---

# ✅ STEP 2 — Pair + Trust the Android

```bash
bluetoothctl
power on
agent on
default-agent
pair XX:XX:XX:XX:XX:XX
trust XX:XX:XX:XX:XX:XX
exit
```

---

# ✅ STEP 3 — Android: use **“Send via Bluetooth”** (Share → Bluetooth → Your PC)

DO NOT TRY TO USE:

```
send ...
```

inside bluetoothctl.
That’s not how file transfers work.

Instead:
**Android must initiate the transfer.**

---

# ⚠ WHY YOUR TRANSFER FAILS

Android does not automatically use OBEX unless your Arch Linux machine advertises the OBEX service.
If obex.service is not running, Android will fall back to A2DP/HFP (audio roles), and then file transfer fails.

---

# 🚀 TEST OBEX is announced correctly

Run:

```
sdptool browse local | grep -i OBEX -A5
```

You MUST see:

* OBEX Object Push
* OBEX File Transfer

If you do **not**, then Arch Linux isn’t publishing OBEX and Android will refuse to send.

---

# 🧨 MOST IMPORTANT CHECK

Run this:

```
journalctl --user -u obex --follow
```

Now from Android → Share → Bluetooth → Your PC.

You should see:

```
NEW Session ...
NEW Transfer ...
```

If you see it getting deleted again, copy the exact error and I will fix it.

---

If you want, I can also show how to manually test OBEX with:

```
obexctl
```

but **bluetoothctl send** will *never* work because that uses audio transport, not OBEX.

Send me:

```
sdptool browse local | grep -i OBEX -A5
```

and I’ll tell you exactly what’s missing.



---


### Recibir archivos 


Receiving files via Bluetooth OBEX on the command line using BlueZ involves setting up an OBEX push server and ensuring proper Bluetooth configuration.
1. Install OBEX Push Server:
Code

sudo apt-get install obexpushd
2. Configure Bluetooth Daemon:
Edit the Bluetooth daemon service file to enable compatibility mode.
Code

sudo nano /etc/systemd/system/dbus-org.bluez.service
Locate the ExecStart= line and add the -C flag at the end. For example:
Code

ExecStart=/usr/lib/bluez/bluetoothd -C
Save the file and reboot your system.
3. Start OBEX Push Server:
Create a directory for received files and start obexpushd.
Code

sudo mkdir /bluetooth
sudo obexpushd -B -o /bluetooth -n
-B: Runs obexpushd in the background.
-o /bluetooth: Specifies /bluetooth as the directory for received files.
-n: Disables notification of received files.
4. Verify OBEX Service:
Confirm that the OBEX service is registered with the Bluetooth Service Discovery Protocol (SDP).
Code

sudo sdptool browse local
Look for an OBEX service entry in the output.
5. Pair and Receive Files:
Make your device discoverable.
Code

bluetoothctl
discoverable on
Initiate pairing from the sending device (e.g., phone): Pair with your Linux system.
Send the file from the sending device: The file will be received and saved in the /bluetooth directory (or the directory you specified with -o).
Important Notes:
Permissions: Files received will be owned by root. You may need sudo to access them or change directory permissions (e.g., sudo chmod 0777 /bluetooth) for easier access.
Re-pairing: If you previously paired your devices before setting up obexpushd, you might need to remove the pairing on both devices and re-pair them for the OBEX service to be recognized.
obexd service: In some newer BlueZ setups, you might need to ensure the obexd service is running. You can check its status and enable it if necessary:
Code

systemctl --user status obex
systemctl --user enable --now obex

---

#### Enviar archivos:

Sending files via Bluetooth using the command-line interface (CLI) with BlueZ and OBEX involves several steps, primarily using the obexctl tool.
Prerequisites:
BlueZ and OBEX Tools: Ensure that BlueZ and the necessary OBEX tools (like obexctl) are installed. On many Linux distributions, this might involve installing packages like bluez and bluez-tools.
Bluetooth Service: Verify that the Bluetooth service is running on your system.
Device Pairing: The devices involved in the file transfer must be paired successfully. You can use bluetoothctl for pairing.
Steps to Send Files:
Start obexctl: Open a terminal and run sudo obexctl. This will open the obexctl interactive prompt.
Connect to the OBEX Object Push Profile:
First, ensure the target device is discoverable and accepting incoming connections.
In the obexctl prompt, use the connect command followed by the MAC address of the target device. For example:
Code

        [bluetooth]# connect 00:11:22:33:44:55
Replace 00:11:22:33:44:55 with the actual MAC address of your target device.
Send the File: Once connected, use the send command followed by the absolute path to the file you want to transfer. For example:
Code

    [00:11:22:33:44:55]# send /home/user/documents/my_file.txt
Ensure the file is in a location accessible to the obexctl process (especially if running as root or within a restricted environment like a snap).
Quit obexctl: After the transfer is complete, you can type quit to exit the obexctl prompt.
Important Notes:
Permissions: You might need sudo to run obexctl or ensure that the user running the command has the necessary permissions to access Bluetooth devices.
Receiving Device: The receiving device must be configured to accept incoming OBEX push requests. This often involves an agent or service running on the receiving end to handle the transfer and potentially prompt for acceptance.
Error Handling: If you encounter issues like "Client proxy not available" when scripting obexctl, it might be related to how the D-Bus session is managed or environmental variables like DISPLAY are set, especially in headless environments. Consider using expect scripts carefully or exploring alternatives for automated transfers.

# ChatGPT

Below is a clear, practical guide for **sending and receiving files via Bluetooth on Arch Linux**, using the standard BlueZ stack and Blueman (recommended), plus CLI options.

---

# ✅ **1. Install Bluetooth Packages**

```bash
sudo pacman -S bluez bluez-utils blueman
```

Enable and start the Bluetooth service:

```bash
sudo systemctl enable --now bluetooth.service
```

---

# ✅ **2. Start the Bluetooth Manager (GUI Method – Easiest)**

If you're running a desktop environment, open **Blueman**:

```bash
blueman-manager
```

### **Pair your device**

1. Turn on Bluetooth on your phone/laptop.
2. In Blueman → search → pair with the device.
3. For Android phones, accept the pairing code.

---

# ✅ **3. Receive Files via Bluetooth**

### **Enable the Blueman File Receiver plugin**

Blueman ships with a file-receiver service using `obexd`.

Check that it’s enabled:

```bash
blueman-services
```

Make sure **"Transfer files"** and **"Receive files (OBEX)"** are enabled.

Files usually arrive in:

```
~/Downloads/
```

### If OBEX agent is not running automatically

Start it manually:

```bash
/usr/lib/bluetooth/obexd
```

Or enable the `obex` systemd user service:

```bash
systemctl --user enable --now obex.service
```

Now you can send a file from your phone → Arch machine.

---

# ✅ **4. Send Files from Arch Linux**

Blueman includes a GUI sender:

**Right-click a paired device → “Send File”**
Or from the terminal:

```bash
blueman-sendto
```

This opens a file picker and transfers via OBEX.

---

# ✅ **5. CLI Method (No GUI)**

### **Pair with the device**

Enter the Bluetooth shell:

```bash
bluetoothctl
```

Then:

```
power on
agent on
default-agent
scan on
```

Find your device’s MAC address, then:

```
pair XX:XX:XX:XX:XX:XX
trust XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
```

---

### **Send a file using `obexctl`**

Start obexctl:

```bash
obexctl
```

Then:

```
connect XX:XX:XX:XX:XX:XX
send /path/to/file.jpg
```

---

### **Receive files with obexd**

Start the OBEX server:

```bash
obexd --nopath --root=/home/$USER/Downloads
```

(Or use the built-in service as described earlier.)

---

# ✨ Summary

| Task             | Easiest Method                                              |
| ---------------- | ----------------------------------------------------------- |
| **Send file**    | `blueman-sendto` or right-click → “Send File”               |
| **Receive file** | Ensure OBEX file receiving is enabled in `blueman-services` |
| **CLI only**     | `bluetoothctl` + `obexctl`                                  |

---

If you want, I can help you:

✔ troubleshoot if a device doesn’t show up
✔ configure KDE/GNOME Bluetooth specifically
✔ use only terminal (no GUI)
✔ fix OBEX errors like "Not Authorized" or "No such file or directory"

Just tell me!

