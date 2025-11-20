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

