---
title: "Accept Lynx cookies always"
date: 2025-11-01T10:53:19-03:00
---

Estoy usando w3m, lynx, links, elinks, chawan, simultaneamente, y a veces Falkon cuando necesito preguntar algo a ChatGPT. Es molesto cuando me pregunta si quiero o no aceptar cookies.


### Como aceptar cookies

#### Option 1: Through interactive menu

1. Run Lynx:

   ```bash
   lynx
   ```
2. Press `O` (capital letter O) to open **Options**.
3. Scroll down to **Cookies** settings.
4. Set:

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

