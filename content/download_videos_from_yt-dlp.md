---
title: "Descargar videos con yt-dlp usando Tor"
date: 2025-05-04T23:07:07-03:00
tags: ['linux']
---

Descargar la descripción y el thumbnail de un video sin descargarlo:

```bash
$ yt-dlp --ignore-config --write-description --write-thumbnail --skip-download YOUTUBE_URL
```


Me bajé el binario de `yt-dlp` con night builds del repo de GitHub y no podía descargar el video a través de Tor, así que instalé yt-dlp desde el repo oficial de Arch.
```bash
$ torsocks yt-dlp -F "https://www.youtube.com/embed/ID"
Error relocating /usr/lib/torsocks/libtorsocks.so: __snprintf_chk: symbol not found
Error relocating /usr/lib/torsocks/libtorsocks.so: __fdelt_chk: symbol not found
Error relocating /usr/lib/torsocks/libtorsocks.so: __memcpy_chk: symbol not found
Error relocating /usr/lib/torsocks/libtorsocks.so: __vsnprintf_chk: symbol not found
Error relocating /usr/lib/torsocks/libtorsocks.so: __fprintf_chk: symbol not found
$ sudo rm -rf /usr/bin/yt-dlp
$ sudo pacman -Syu yt-dlp
$ torsocks yt-dlp -F "https://www.youtube.com/embed/ID" ### Funcionó
```
