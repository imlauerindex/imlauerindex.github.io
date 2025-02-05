---
title: "El mejor navegador de consola con visor de imágenes"
date: 2024-08-05T05:36:57-03:00
tags: ['navegadores','w3m']
---
El mejor navegador de consola con soporte JavaScript hasta la fecha es **Carbonyl**, pero es demasiado pesado a comparación de w3m que todavía puede mostrar muchas páginas. Hubo un intento por implementar javascript en w3m pero se abandonó el proyecto (w3m-js).

Se navega usando flechas, tab, y las keybinding de vim.
Si querés buscar algo en la página se hace con `/` seguido de la palabra, n para la siguiente ocurrencia.   
Shift+t para abrir nueva pestaña.     
Shift+b para volver atrás.    
Shift+[ para moverse entre las pestañas.   
Shift+u para cambiar de url.  
Control+h para ver el historial.  
H mayúscula para ver el menú de ayuda.   

Tenés tabs, podés googlear imágenes.
```
sudo apt install -y w3m w3m-img
w3m https://imlauera.github.io
```

##### Como cambiar el tamaño de letra en xterm:
En .Xdefaults agregá:

```
xterm*faceName: Monospace
xterm*faceSize: 14
```

Ejecutá: `xrdb .Xdefaults`
