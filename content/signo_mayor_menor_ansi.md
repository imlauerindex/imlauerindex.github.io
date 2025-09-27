---
title: "ChatGPT mejoró mi vida: Signo mayor menor en teclado ANSI bajo distribución en español."
date: 2025-09-27T13:28:35-03:00
tags: ['linux']
---
Mi prompt:

> Tengo un teclado ANSI y uso distribución español con Ñ así que no puedo hacre el signo mayor ni menor (\< \>) y encima es un teclado 75% o sea no tengo teclado numérico y estoy desde la TTY linux la única solución que encontré es ejecutando `sudo loadkeys us` y luego `sudo loadkeys es` para hacer el signo mayor y menor, ¿existe hay alguna otra forma para que no tenga que hacer eso?

Le pregunté a ChatGPT como resolverlo y me dijo que haga lo siguiente

```bash
dumpkeys > mi_mapa.kmap
```

Y después me dijo que agregue lo siguiente en `mi_mapa.kmap`.

`vim mi_mapa.kmap`

```console
keycode 51 = period greater
    altgr keycode 51 = greater

keycode 52 = comma less
    altgr keycode 52 = less
```
Y finalmente: `sudo loadkeys mi_mapa.kmap` y listo ahora puedo hacer el signo mayor y menor!

\> \<

Gracias ChatGPT!
