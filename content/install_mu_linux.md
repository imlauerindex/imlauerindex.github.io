---
title: "Jugar a MU Bless Online en ArchLinux"
date: 2025-05-17T10:56:37-03:00
tags: ['games']
---

Descargá el juego acá: https://mu.bless.gs/es/index.php?page=files

Habilitá `multilib` libs e instalá `wine` luego

```bash
sudo pacman -S wine mesa lib32-mesa
wine Bless Arkania Episode 5 (27.03.2025).exe
wine .wine/drive_c/Games/Launcher.exe
```
