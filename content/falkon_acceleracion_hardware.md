---
title: "Falkon acceleración Hardware"
date: 2025-03-06T10:41:23-03:00
tags: ['falkon']
---
#### Con eglfs
```bash
export XKB_DEFAULT_LAYOUT=es # para la ñññ, no funcionan con los acentos
#export QT_QPA_PLATFORM=linuxfb:size=1000x1000 # Esta no soporta acceleración por hardware
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
export QT_QPA_EGLFS_WIDTH=1000
export QT_QPA_EGLFS_HEIGHT=1000
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=109.62
export QT_QPA_EGLFS_PHYSICAL_WIDTH=292.32
export QT_QPA_EGLFS_NO_LIBINPUT=1
export QT_QPA_FONTDIR=/lib/Fonts
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/plugins/platforms
export XDG_RUNTIME_DIR=/tmp
export QTWEBENGINE_CHROMIUM_FLAGS="--ignore-gpu-blacklist --enable-gpu-rasterization --enable-native-gpu-buffers"

```

Esto sirve para tomar el mouse y el teclado en vez de que escriba en la consola, pero es una mala idea porque si se te traba la aplicación no se puede cerrar y tenés que apagar la computadora.
##### NO lo uses
```bash
#export QT_QPA_EVDEV_KEYBOARD_PARAMETERS=grab=1
#export QT_QPA_EVDEV_MOUSE_PARAMETERS=grab=1
```
