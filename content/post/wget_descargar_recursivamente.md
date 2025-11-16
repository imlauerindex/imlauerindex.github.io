---
title: "Wget descargar recursivamente"
date: 2025-01-13T05:41:07-03:00
tags: ['tools']
---
```bash
wget --recursive --no-parent http://example.com/configs/.vim/
```

Para evitar que se descargue el `index.html`:

```bash
wget -r -np -R "index.html*" http://example.com/configs/.vim/
``` 

Descargar todos los archivos de un `index of /`:

```bash
wget -e robots=off -r -np -R "index.html*" "http://ricardonarvaja.info/WEB/EXPLOITING%20Y%20REVERSING%20USANDO%20HERRAMIENTAS%20FREE/ESPANIOL/"
```

```bash
wget -r -l1 -np -nH --cut-dirs=2 -A mp3 -R "index.html*" -e robots=off -c URL
```

#### Descargar sin imágenes

```bash
wget --reject jpg,jpeg,png,gif,svg,webp,ico -r
```
