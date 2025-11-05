---
title: "Accept Lynx cookies always"
date: 2025-11-01T10:53:19-03:00
---

Lynx tiene una configuración retrasada.

Estoy usando w3m, lynx, links, elinks, chawan, simultaneamente, y a veces Falkon cuando necesito preguntar algo a ChatGPT. Es molesto cuando me pregunta si quiero o no aceptar cookies y para poder ver los acentos cambiar `Display character set` a UNICODE debes marcar la opción SAVE TO DISK.

Y también podes habilitar las VIM keybindings, habilitar el HTML5 charset, underline links, y show images as links así se puede abrir las imágenes y poné a w3m como navegador por defecto o mpv para ver la imagen (acordate que tenes que marcar Save options to disk y guardar), sino no se guarda cuando reinicias el navegador.

### Lo ideal es editar /etc/lynx.conf porque a veces no te toma la configuración por más que marques SAVE TO DISK.

Por ejemplo esta opción no me la tomaba tuve que como root descomentarla y asignarle TRUE.

```bash
MAKE_LINKS_FOR_ALL_IMAGES:TRUE
```



### Como aceptar cookies

#### Option 1: Through interactive menu

1. Run Lynx:

   ```bash
   lynx
   ```
2. Press `O` (capital letter O) to open **Options**.
3. Scroll down to **Cookies** settings.
4. Set:

   * `Save options to disk: [X]`
   * `accept all cookies` → **Yes**
   * `ask user about cookies` → **No**
5. Press `→` (right arrow key) on **Accept Changes** to save.

---

#### Option 2: Modify config file

Edit your Lynx configuration file, usually at:

```
~/.lynxrc
```

or globally in `/etc/lynx.cfg`.

Add or modify these lines:

```
accept_all_cookies=TRUE
ask_user_about_cookies=FALSE
```

You can also check `COOKIE_ACCEPT_PROMPT` in `/etc/lynx.cfg`:

```
COOKIE_ACCEPT_PROMPT:FALSE
SET_COOKIES:TRUE
ACCEPT_ALL_COOKIES:TRUE
```

