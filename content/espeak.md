---
title: "Espeak habla cada tecla presionada TTY"
date: 2025-11-11T01:13:14-03:00
---

https://wiki.archlinux.org/title/Speech_dispatcher

https://bbs.archlinux.org/viewtopic.php?id=280161

Creo que era algo así no recuerdo bien.

```bash
lsmod | grep speakup
sudo /sbin/espeakup --default-voice=en

sudo pacman --noconfirm -S espeakup 
sudo systemctl stop espeakup
sudo systemctl enable espeakup
```

Y luego hay que reiniciar el sistema.


---

`espeakup` + `speakup` *can* echo keys as you type in a Linux TTY, but you must enable Speakup’s **key echo** function — espeakup alone doesn’t speak keystrokes.

### ✅ Steps (TTY, no GUI)

#### **1. Load the speakup soft-speech driver**

```bash
sudo modprobe speakup_soft
```

#### **2. Start espeakup**

Arch:

```bash
sudo espeakup
```

Debian/Ubuntu:

```bash
sudo service espeakup start
```

#### **3. Enable key echo**

Speakup has 3 echo modes:
`0 = off`, `1 = characters`, `2 = words`, `3 = both`

To echo **characters** as you type:

```bash
sudo bash -c 'echo 1 > /sys/accessibility/speakup/key_echo'
```

To echo **characters + words**:

```bash
sudo bash -c 'echo 3 > /sys/accessibility/speakup/key_echo'
```

#### **4. (Optional) Turn on keyboard speech toggle**

You can toggle speaking using:
`Insert` + `F9` = toggle keyboard echo
`Insert` + `F10` = speak punctuation mode

(Some laptops use `CapsLock` instead of `Insert`)

---

### ✅ Make it persistent (load Speakup at boot)

Arch:

```bash
sudo systemctl enable espeakup
```

Debian:

```bash
sudo systemctl enable espeakup.service
```

---

### 🎧 Test it

Type in a TTY (`Ctrl+Alt+F2`).
You should hear Espeak say each key or word.

---

### Troubleshooting

| Issue                           | Fix                                                      |
| ------------------------------- | -------------------------------------------------------- |
| No sound                        | install & unmute ALSA (`alsamixer`)                      |
| Espeakup not installed          | `sudo pacman -S espeakup` or `sudo apt install espeakup` |
| No `/sys/accessibility/speakup` | kernel missing speakup modules                           |

---

### Extra Useful Parameters

Slow speech:

```bash
sudo bash -c 'echo 200 > /sys/accessibility/speakup/rate'
```

Speak punctuation:

```bash
sudo bash -c 'echo 1 > /sys/accessibility/speakup/punct'
```

---

If you want, I can also give you:

* Script to toggle key-echo quickly
* A systemd service to auto-enable it
* Commands for Void / Gentoo / Fedora

Want me to generate those?


---


On Arch, **eSpeak NG only ships the basic voices by default**. To install extra voices (including MBROLA):

---

## ✅ Install eSpeak NG + MBROLA voices (AUR)

### 1) Install eSpeak NG

```bash
sudo pacman -S espeak-ng
```

### 2) Install MBROLA voices (AUR)

You need an AUR helper (`yay`, `paru`, etc.).

With `yay`:

```bash
yay -S mbrola-voices
```

This package includes many voices (us, uk, es, etc.).

---

## ✅ Test installed voices

### Test normal espeak voices

```bash
espeak-ng -v en-us "Hello from eSpeak NG"
```

### Test MBROLA voices

```bash
espeak-ng -v mb-us1 "This is a MBROLA voice"
```

If it talks → ✅ working
If you see:

```
Cannot find mb-us1
```

then run:

```bash
yay -S mbrola-voices-us1
```

(each MBROLA voice also exists as its own package, e.g. `mbrola-voices-es1`, `mbrola-voice-us2`, etc.)

---

## 👉 Common MBROLA packages in Arch AUR

| Voice     | Command                    |
| --------- | -------------------------- |
| US male   | `yay -S mbrola-voices-us1` |
| US female | `yay -S mbrola-voices-us2` |
| UK        | `yay -S mbrola-voices-en1` |
| Spanish   | `yay -S mbrola-voices-es1` |
| French    | `yay -S mbrola-voices-fr1` |

Install only what you want to save space.

---

## ✅ Use MBROLA with `espeakup` (if using speakup in TTY)

Edit config:

```bash
sudo nano /etc/default/espeakup
```

Set:

```
VOICE="mb-us1"
```

Restart:

```bash
sudo systemctl restart espeakup
```

---

## 📂 Where voices go on Arch

| Type             | Location                            |
| ---------------- | ----------------------------------- |
| eSpeak NG voices | `/usr/share/espeak-ng-data/voices/` |
| MBROLA voices    | `/usr/share/mbrola/`                |

---

## 🎤 Tip: Slow down & make it smoother

```bash
espeak-ng -s 150 -v mb-us2 "This sounds more natural"
```

---

If you tell me which style you want (male/female/Spanish/robotic/natural), I can tell you **the exact package + voice name**.

Want faster install commands for `paru` instead of `yay`?


---

#### systemctl edit espeakup

```bash
Environment="default_voice=mb-us1"
ExecStart=
ExecStart=/usr/bin/espeakup --default-voice=mb-us1
```

