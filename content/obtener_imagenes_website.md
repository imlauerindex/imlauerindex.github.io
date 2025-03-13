---
title: "Obtener todas las URLs de las imagenes de un sitio"
date: 2025-03-13T08:08:36-03:00
tags: ['cli']
---
#### Con Wget:
```bash
wget -qO- example.com | grep -oP 'img[^>]*src="\K[^"]+'
```
#### Con headless chromium:
```bash
chromium --headless=new example.com  --disable-gpu --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | grep -oP 'img[^>]*src="\K[^"]+'
```
