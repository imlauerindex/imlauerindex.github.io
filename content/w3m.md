---
title: "W3m uno de los mejores navegadores basados en texto con soporte de imágenes"
date: 2024-11-15T10:10:07-03:00
tags: ['w3m']
---

No tiene soporte de JavaScript, se puede usar con las vim keys.
Si tenés instalado elinks, y w3m podés navegar a través de varias páginas sin problemas.

Las páginas que requieran javascript podés crear un script en python mirando los endpoints con el devtools (F12) al enviar las peticiones y pedile a la AI para que te genere un script usando esos endpoints.

Reddit nuevo no lo soporta, pero sí el viejo (old.reddit.com) tenés que cambiar la URL cada vez que visitás Reddit.

Yo no dejo la TTY, y las páginas que w3m no soporta por completo como Linkedin o Upwork las uso usando Falkon y QuteBrowser con la variable `export QT_QPA_PLATFORM=linuxfb:offset=0x0:size=1038x700` en tu `.bashrc`, `.zshrc` o en `.config/fish/config.fish`

Y uso MPV con yt-dlp como mi "navegador externo": `/etc/mpv/mpv.conf`:
```bash
--ytdl-raw-options="format=bestvideo[height<=?360]+bestaudio/best[height<=?360]/bestvideo[height<=?480]+bestaudio/best[height<=?480],write-auto-sub=,sub-lang=[en,ru],write-sub="
--vo=drm # Para la TTY
mute=yes
volume-max=600
```
Para abrir un link en donde está el cursor: Escape+M


https://wiki.archlinux.org/title/W3m

