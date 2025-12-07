---
title: "Grabar y streamear desde TTY (con la cámara)"
date: 2025-07-18T21:32:33-03:00
tags: ['linux']
---
Grabar archivo de video (al grabar de esta forma solo estás usando el procesador sin la tarjeta gráfica):


```bash
ffmpeg -f fbdev -framerate 60 -i /dev/fb0 -f v4l2 -i /dev/video0 -f alsa -i pipewire -filter_complex "[1:v]scale=320:-1[cam];[0:v][cam]overlay=main_w-overlay_w-20:20" -c:v libx264 -preset ultrafast -pix_fmt yuv420p -c:a aac -b:a 128k -async 1 -ar 48000 -latency 100 prueba.mp4

```

---


```bash
ffmpeg -f alsa -i pipewire -f fbdev -r 60 -i /dev/fb0 mamita.mp4
```


```bash
ffmpeg -f fbdev -framerate 30 -i /dev/fb0 \
       -f v4l2 -i /dev/video0 \
       -f alsa -i pipewire \
       -filter_complex "[1:v]scale=320:-1[cam];[0:v][cam]overlay=main_w-overlay_w-20:20" \
       -c:v libx264 -c:a aac output.mp4
```


Este es el comando que uso para grabar y tiene menos lag.
```bash
ffmpeg \
 -f fbdev -framerate 60 -i /dev/fb0 \
 -f v4l2 -i /dev/video0 \
 -f alsa -i pipewire \
 -filter_complex "[1:v]scale=320:-1[cam];[0:v][cam]overlay=main_w-overlay_w-20:20" \
 -c:v libx264 -preset ultrafast -pix_fmt yuv420p \
 -c:a aac -b:a 128k \
 -async 1 -ar 48000 -latency 100 \
 prueba.mp4
```
**peg-this (ffmpeg TUI)**:
```bash
python -m venv peg_this
source peg_this/bin/activate or source peg_this/bin/activate.fish (si usas fish)
pip install peg-this
peg_this
```


#### Amplify sound with ffmpeg.
```bash
# Lento
ffmpeg -i input.mp4 -af "volume=4.0" output.mp4
# Rapido pero no anda (es rapido porque copia)
ffmpeg -i input.m4a -c:a copy -af "volume=4.0" output.m4a
```


```bash
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -f v4l2 -framerate 60 -video_size 320x240 -i /dev/video0 -filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" -map "[outv]" -map 0:a -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/stream
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


##### Grabar video usando DRM (con kmscon), lo uso para capturar un navegador o un juego.
Para poder grabar kmscon sin sudo y grabar el audio:
```bash
sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg
[esotericwarfare@arch ~]$ getcap /usr/bin/ffmpeg
/usr/bin/ffmpeg cap_sys_admin=ep
```

Y agrega sudo systemctl edit kmscon para arreglar colores de tmux 

Para iniciar kmscon : sudo systemctl start kmscon

```bash
# no deberias usar sudo porque no vas a poder grabar el audio si te putea ejecuta lo que está mas arriba.

ffmpeg -f alsa -i pipewire -f kmsgrab -device /dev/dri/card1 -i - -vf 'hwdownload,format=bgr0' -c:v libx264 -preset ultrafast out.mkv

# Si queres usar sudo acá tenés.

sudo ffmpeg -f kmsgrab -device /dev/dri/card1 -i - -vf 'hwdownload,format=bgr0' -c:v libx264 -preset ultrafast out.mkv

ffmpeg -device /dev/dri/card1 -f kmsgrab -framerate 30 -i - -vf 'hwdownload,format=bgr0' -c:v libx264 output.mkv

ffmpeg -device /dev/dri/card1 -f kmsgrab -framerate 30 -i - -vf 'hwmap=derive_device=vaapi,format=nv12,hwdownload,format=bgr0' -c:v libx264 output.mkv
ffmpeg -device /dev/dri/card1 -f kmsgrab -framerate 30 -i - -vf 'hwmap=derive_device=vaapi,format=nv12,hwdownload,format=bgr0' -c:v libx264 output.mkv

Si tu hardware soporta VAAPI, podés ganar rendimiento cambiando -c:v libx264 por -c:v h264_vaapi.

sudo setcap cap_sys_admin+ep $(which ffmpeg)



```

Para bajar el volumen del micrófono: bajá el volumen `Internal Mic B` en `alsamixer` y `Mic Boost` y `Mic`.

##### Capturar pantalla desde Wayland y streamerlo a YouTube
```bash
ffmpeg -f pipewire -framerate 30 -video_size 1920x1080 -i @DEFAULT_VIDEOSOURCE@ \
-f pulse -i default \
-c:v libx264 -preset veryfast -b:v 4500k -c:a aac -b:a 128k -f flv \
"rtmp://a.rtmp.youtube.com/live2/YOUR_STREAM_KEY"

```

#### Capturar pantalla con cámara.
```bash
ffmpeg -f pipewire -framerate 30 -video_size 1920x1080 -i @DEFAULT_VIDEOSOURCE@ \
-f pulse -i default \
-f v4l2 -framerate 60 -video_size 640x480 -i /dev/video0 
-filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" -map "[outv]" -map 0:a 
-c:v libx264 -preset veryfast -b:v 4500k -c:a aac -b:a 128k -f flv \
"rtmp://a.rtmp.youtube.com/live2/YOUR_STREAM_KEY"
``` 

###### Cuando arranco stream siempre tengo que bajar el Internal Mic desde alsamixer porque sino el micrófono se satura.


#### Este es el script que uso para streamear desde la TTY.
```bash
#!/bin/bash
sudo chmod 666 /dev/input/event*
amixer set 'Internal Mic Boost' 50%-


falkon "https://www.youtube.com/live_dashboard"
### Solo tty
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/STREAM_KEY 2> /dev/null

```


#### Este es el script que uso:
```bash
#!/bin/bash
sudo chmod 666 /dev/input/event*
amixer set 'Internal Mic Boost' 50%-


#falkon "https://www.youtube.com/live_dashboard"
### Solo tty
#ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -async 1 -ar 48000 -latency 100 -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/KEY 2> /dev/null


#### Camara con tty
ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f fbdev -framerate 60 -i /dev/fb0 -f v4l2 -framerate 60 -video_size 320x240 -i /dev/video0 -filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" -map "[outv]" -map 0:a -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/KEY 2> /dev/null

### Solo camara
#ffmpeg -f alsa -i pipewire -thread_queue_size 1024 -f v4l2 -framerate 60 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -c:a aac -b:a 128k -f flv -bufsize 1000k rtmp://a.rtmp.youtube.com/live2/KEY 2> /dev/null
```


Para poder streamear falkon, angelfish o qutebrowser desde la TTY usa:

```bash
export QT_QPA_PLATFORM=linuxfb
export QTWEBENGINE_CHROMIUM_FLAGS="--ignore-gpu-blacklist --disable-gpu"
```

Para verificar si está transmitiendo: 

```bash
mpv "https://www.youtube.com/channel/CHANNEL\_ID/live"
```



#### Wayland (stream)

``` 
ffmpeg \
    -f alsa -i pipewire \
    -thread_queue_size 1024 \
    -f pipewire -i pipewire \
    -f v4l2 -framerate 60 -video_size 320x240 -i /dev/video0 \
    -filter_complex "[2:v]scale=320:240[cam];[1:v][cam]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv]" \
    -map "[outv]" -map 0:a \
    -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p \
    -c:a aac -b:a 128k \
    -f flv -bufsize 1000k <TU_URL_RTMP>

``` 

#### Wayland (record)

```bash
ffmpeg \
    -f pipewire -i pipewire \        # captura de pantalla
    -f v4l2 -framerate 30 -video_size 1280x720 -i /dev/video0 \  # cámara
    -f alsa -i pipewire \            # audio del sistema (opcional)
    -filter_complex "[1:v]scale=320:240[cam];[0:v][cam]overlay=W-w-20:H-h-20[out]" \
    -map "[out]" -map 2:a \
    -c:v libx264 -preset veryfast -pix_fmt yuv420p \
    -c:a aac -b:a 128k \
    output.mp4

```
