---
title: "Cambiar letra TTY"
date: 2024-11-03T22:55:16-03:00
tags: ['tty']
---
```bash
cd /usr/share/kbd/consolefonts
setfont latarcyrheb-sun32

o

sudo setfont ter-p20b.psf.gz
```

En `/etc/vconsole.conf` tenés que agregar:

```bash
FONT=latarcyrheb-sun32
```
