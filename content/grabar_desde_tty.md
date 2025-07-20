---
title: "Grabar y streamear desde TTY (con la cámara)"
date: 2025-07-18T21:32:33-03:00
tags: ['linux']
---
Grabar archivo de video:
```bash
ffmpeg -f alsa -i pipewire -f fbdev -r 30 -i /dev/fb0 mamita.mp4
```

```bash
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -f v4l2 -framerate 60 -video_size 320x240 -i /dev/video0 -filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" -map
"[outv]" -map 0:a -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/354p-cjwx-h1se-5xvg-b88c
```

### Para transmitir a YouTube:
#### Este funcionó bastante bien (sin cámara y con audio no se puede streamear sin audio en YouTube)
```bash
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k 
```

#### Transmitir solo la cámara a resolución HD podes ver la lista de resoluciones disponibles con el comando `v4l2-ctl --list-formats-ext`.
```bash
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f v4l2 -framerate 60 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/stream_key
```


##### Leer el chat en vivo: 
```bash
python -m venv chat-downloader
source chat-downloader/bin/active
pip install chat-downloader
chat_downloader "https://www.youtube.com/watch?v=TU_ID_DEL_VIDEO"
```

---

#### Camara y tty:
```bash
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -f v4l2 -framerate 60 -video_size 320x240 -i /dev/video0 -filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" -map
"[outv]" -map 0:a -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/stream_key
```


##### Grabar video usando DRM (con kmscon), no lo uso.
```bash
ffmpeg -device /dev/dri/card0 -f kmsgrab -framerate 30 -i - -vf 'hwdownload,format=bgr0' -c:v libx264 output.mkv

```

