---
title: "Ejecutar qutebrowser en framebuffer"
date: 2024-12-08T18:39:44-03:00
tags: ['framebuffer']
---
```bash
export QT_QPA_PLATFORM=linuxfb
export QT_QPA_PLATFORM=linuxfb:offset=900x130:size=768x600
qutebrowser
```
O usando también: `export QT_QPA_PLATFORM=eglfs`

**Cambiar el keymap:**

```bash
sudo pacman -S ckbcomp  
ckbcomp -layout xx > xx.kmap
O tomá un keymap desde acá: /usr/share/kbd/keymaps/i386/qwertz
kmap2qmap xx.kmap xx.qmap
QWS_KEYBOARD="TTY:keymap=xx.qmap"
```
**Compilá kmap2qmap desde acá:**:
```bash
git clone https://github.com/qt/qttools
cd qttools
mkdir build
cmake ..
```
 
Y agregá en `.bashrc` o en `.config/fish/config.fish`:
```bash
export QT_QPA_PLATFORM=linuxfb:offset=900x130:size=768x600:keymap=es.qmap
```
### OJOO!!!

Asegurarte de bajar el qttools para la versión de tu QT.
Ejemplo de error:
```bash
Version 6.8.2 of package Qt6 was requested but an incompatible version was found: 6.8.1.  You can pass -DQT_NO_PACKAGE_VERSION_CHECK=TRUE to disable
```
Tenés que entrar a la página de qttools bajo Release encontrarás TAGS. Ahí buscá la vresión indicada para vos: en mi caso 6.8.1

**ESO NO ES TODO!!!** Ahora cuando clones 6.8.1 y lo compiles te va a putear porque te falta src/assistant/qlitehtml porque es un submodulo que no lo baja. Tenés que clonar este repo en `/tmp` ejecutá: 

```bash
git clone --recurse-submodules -j8 "https://github.com/PyQt5/QLiteHtml"`
cd QLiteHtml
cp -R qlitehtml /home/usuario/Downloads/qttools-6.8.1/src/assistant
cd /home/usuario/Downloads/qttools-6.8.1/build
cmake ..
make
sudo make install
```
Y ahora sí compila! Todo esto para tener la utilidad `kmap2qmap` y poder tener el teclado en español XDD, amo el framebuffer.

Fuente: https://stackoverflow.com/questions/2669464/qt-embedded-for-linux-keyboard-layout-switching

Cambiar de TTY (Virtual Terminal):

### 1. **Use `chvt` with `fbcon` (Framebuffer Console) Locking**

You can lock the framebuffer so that the Qt app doesn't redraw when you switch between VTs. Here's how to do this:

1. **Disable the framebuffer updates when switching VTs:**
   You can use `fbcon` to disable the updates for the virtual terminal console. This
can be done by switching to a virtual terminal and executing the following command:

   ```bash
   echo "1" > /sys/class/vtconsole/vtcon0/bind
   ```

   This command will bind the virtual terminal (VT) console to the framebuffer and prevent it from redrawing when switching.

