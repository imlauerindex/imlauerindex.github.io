---
title: "Conectar a dispositivo bluetooth en ArchLinux"
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
> pair MAC_ADDRESS
> connect MAC_ADDRESS
```

https://old.reddit.com/r/archlinux/comments/13cr6mj/how_to_setup_bluetooth_service_on_arch_linux/
