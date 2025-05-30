---
title: "Rclone Google Drive"
date: 2025-05-29T20:24:15-03:00
tags: ['rclone']
---
Una forma mucho más fácil y rápida de acceder a tu Google Drive es usando rclone, para Windows está disponible la aplicación de escritorio.

https://rclone.org/drive/#making-your-own-client-id

https://www.youtube.com/watch?v=f8K-V3HHDA0

```bash
mkdir gdrive
rclone mount --daemon gdrive: /home/esotericwarfare/gdrive/
```

Si creas archivos locales en esa carpeta los creas en Google Drive también, permite lectura y escritura.
