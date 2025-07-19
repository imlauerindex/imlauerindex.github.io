---
title: "Grabar desde TTY"
date: 2025-07-18T21:32:33-03:00
tags: ['linux']
---
```
ffmpeg -f alsa -i pipewire -f fbdev -r 30 -i /dev/fb0 mamita.mp4
```

Para streamear a YouTube:
```bash
ffmpeg -f alsa -i pipewire -f fbdev -r 30 -i /dev/fb0 \
-c:v libx264 -preset veryfast -pix_fmt yuv420p -c:a aac -b:a 128k \
-f flv rtmp://a.rtmp.youtube.com/live2/TU_STREAM_KEY
```
