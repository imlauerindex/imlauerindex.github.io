---
title: "Xterm: Configuración inicial (color de fondo, color de letra, tipo de letra y tamaño)"
date: 2024-11-07T11:51:39-03:00
tags: ['xterm']
---

Poné en tu `.Xdefaults` y cargalo con `xrdb -a .Xdefaults`

```bash
xterm*background:black
xterm*foreground:white
xterm*cursorColor:white
xterm*pointerShape:normal
xterm*pointerColor:white

XTerm.vt100.scrollBar:false
XTerm.vt100.bellIsUrgent:true

XTerm.vt100.faceName:Liberation Mono
XTerm.vt100.faceSize:12

XTerm.vt100.translations: #override \
    Ctrl Shift <Key>Prior: larger-vt-font() \n\
    Ctrl Shift <Key>Next: smaller-vt-font()

```
--- 
Intenté copiarlo usando lo siguiente:

```bash
XTerm*vt100.translations: #override \
    Shift Ctrl <Key> C: copy-selection(CLIPBOARD) \n\
    Shift Ctrl <Key> V: insert-selection(CLIPBOARD)
```

Pero no funcionó al final terminé aprendiendo a copiar y pegar con xterm seleccionás el texto y lo pegás con Shift+Insert en vim lo pegás con `"+gp`.
