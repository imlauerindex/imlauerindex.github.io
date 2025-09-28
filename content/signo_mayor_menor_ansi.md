---
title: "Signo mayor menor en teclado ANSI bajo distribución en español en la linux TTY."
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

Luego agregamos `loadkeys ~/mi_mapa.kmap` a `.bashrc` o `.config/fish/config.fish`.


O copiá `mi_mapa.kmap` a `/usr/share/kbd/keymaps/i386/qwerty/` luego en `/etc/vconsole.conf` (archivo usado en distros con systemd) agregá: `KEYMAP=mi_mapa` o se puede hacer usando también un servicio de systemd.


In **X11**, layouts are defined in `/usr/share/X11/xkb/symbols/`.
The file `es` is the **Spanish layout definition**. You can add your custom `<` and `>` mapping there — or better, in a **custom variant** so you don’t break updates.

---

### 🔹 Example: Add `<` and `>` to AltGr + comma/period

Open the file:

```bash
sudo nano /usr/share/X11/xkb/symbols/es
```

At the bottom, you can add a **variant** like this:

```xkb
partial alphanumeric_keys
xkb_symbols "ansi75" {
    include "es(basic)"  // base Spanish layout

    // Redefine comma (key <AB08>) and period (key <AB09>)
    key <AB08> { [ comma, semicolon, less,   less   ] };
    key <AB09> { [ period, colon,  greater, greater ] };
};
```

Explanation:

* `<AB08>` is the **comma key**
* `<AB09>` is the **period key**
* `[normal, Shift, AltGr, Shift+AltGr]`

So this means:

* `,` → comma
* `Shift + ,` → semicolon
* `AltGr + ,` → `<`
* `AltGr + Shift + ,` → `<`

And the same for period → `>`.

---

### 🔹 Test the new variant


En mi caso yo uso EGLFS así que agregué a `.config/fish/config.fish`:

```bash
export XKB_DEFAULT_LAYOUT=es
export XKB_DEFAULT_VARIANT=ansi75
```


Run:

```bash
setxkbmap -layout es -variant ansi75
```

Now try typing with `AltGr + ,` and `AltGr + .` → you should get `<` and `>`.

---

### 🔹 Make it permanent

Edit `/etc/X11/xorg.conf.d/00-keyboard.conf` (create if missing):

```bash
sudo nano /etc/X11/xorg.conf.d/00-keyboard.conf
```

Add:

```conf
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "es"
    Option "XkbVariant" "ansi75"
EndSection
```

Reboot (or just replug keyboard / restart X11).

---

✅ This way, you don’t lose Spanish support — you just add your **ansi75** variant for your keyboard.

---

👉 Do you want me to also give you the **equivalent patch for Wayland (xkbcomp)**, so it works the same outside pure X11?






Gracias ChatGPT!

