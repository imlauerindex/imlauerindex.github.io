---
title: "Accept Lynx cookies always y espeak para leer texto y piper"
date: 2025-11-01T10:53:19-03:00
---

https://old.reddit.com/r/commandline/comments/1c0qgm3/using_lynx_browser_drop_your_tips_here/


Lynx tiene una configuración retrasada.

Estoy usando w3m, lynx, links, elinks, chawan, simultaneamente, y a veces Falkon cuando necesito preguntar algo a ChatGPT. Es molesto cuando me pregunta si quiero o no aceptar cookies y para poder ver los acentos cambiar `Display character set` a UNICODE debes marcar la opción SAVE TO DISK.

Y también podes habilitar las VIM keybindings, habilitar el HTML5 charset, underline links, y show images as links así se puede abrir las imágenes y poné a w3m como navegador por defecto o mpv para ver la imagen (acordate que tenes que marcar Save options to disk y guardar), sino no se guarda cuando reinicias el navegador.

```bash
EXTERNAL:http:w3m %s:TRUE
EXTERNAL:http:mpv %s:TRUE

KEYMAP:,:EXTERN_PAGE            # Run external program with current page
KEYMAP:.:EXTERN_LINK            # Run external program with current link
```

`TEXTFIELDS_NEED_ACTIVATION` así no se traba cuando usas vi mode

Con el punto (.) abrira la pagina en w3m.

### Lo ideal es editar /etc/lynx.conf porque a veces no te toma la configuración por más que marques SAVE TO DISK.

Por ejemplo esta opción no me la tomaba tuve que como root descomentarla y asignarle TRUE.

```bash
MAKE_LINKS_FOR_ALL_IMAGES:TRUE
```

Aún así hay una configuración que no la pude guardar que es la de SHOW TRANSFER RATE: quería cambiarlo de Show KiB/sec rate a Show progressbar y no pude



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


Controles para editar texto en lynx Control+G:
```bash
Control+p va para atraso
Control+o cancela
Control+g cancela
Control+´ cancela
control+u borra
control+t mayúscula
control+a comienzo
control+d borra letra adelante
control+h borra letra atras
control+f borra palabra adelante
control+j te lleva a pages.github.com
control+x salta adonde estaba el cursor antes.
control+b borra palabra hacia atras. (Si estas en TMUX tenes que ejecutar control+b+control+b)
control+n mueve cursor palabra hacia adelante
control+- borra hacia atras
control+- borra hacia atras
alt+k borra todo
alt+d borra palabra hacia adelante
alt+a va al inicio
alt+t mueve cursor hacia atras
alt+r va a la url

alt+q top
alt+w al fondo
```

---

```bash
EXTERNAL:http:w3m %s:TRUE
EXTERNAL:http:cha %s:TRUE
EXTERNAL:http:mpv %s:TRUE
EXTERNAL:http:netsurf-fb -f sdl -w 1366 -h 768 %s:TRUE
EXTERNAL:http:falkon %s:TRUE
EXTERNAL:http:angelfish %s:TRUE
```




---



Yes — there *are* definitely better alternatives to eSpeak NG on Arch Linux (or any Linux) if you’re looking for **more natural-sounding** text-to-speech. Below are some good options + what you need to know to pick/install them.

---

## ✅ Better TTS engines for Arch Linux

Here are some of the more polished options:

### 1. RHVoice

* Multilingual speech synthesiser. ([ArchWiki][1])
* On Arch: install `rhvoice` plus the appropriate language/voice packs. ([ArchWiki][1])
* Sound quality is generally better than the formant-only voices of eSpeak.
* Good choice if you want *offline*, open-source, reasonably natural TTS.

### 2. Piper TTS

* A more recent engine that uses neural voices (rather than only formant/diphone). For example: “Install Piper TTS … if you’re on Arch, you can install … via AUR.” ([Dom DeLorenzo][2])
* On Arch: there is `piper-tts-bin` in AUR and voice packages like `piper-voices-en-us`. ([ArchWiki][3])
* If you want the most natural voice (offline) this is one of the best open-source routes.

### 3. Festival

* Older but still better than basic eSpeak in some respects. ([ArchWiki][4])
* Less “robotic” than eSpeak out of the box but fewer voice options/less modern than neural-based engines.

---

## 🎯 My recommendation for you

Since you’re on Arch Linux and want something better than eSpeak for “sounding like a human”, I’d suggest:

* Try Piper TTS + a good voice (via AUR).
* Or RHVoice if you prefer something more mature and simpler.
* Keep eSpeak NG as fallback for compatibility, scripting or very lightweight use.

---

## 🛠 Basic installation steps (for Piper TTS, example)

1. Enable or install AUR helper (e.g., `yay`, `paru`).
2. `yay -S piper-tts-bin`
3. `yay -S piper-voices-en-us` (or your language) (3 GB)
4. Configure Speech Dispatcher (if you’re using that) to use Piper instead of eSpeak. E.g., add module for Piper in `~/.config/speech-dispatcher/speechd.conf`. ([Dom DeLorenzo][2])
5. Test: e.g., `spd-say "Hello world"` or use `piper` command.

```bash
echo "Hello!" | piper-tts --model /usr/share/piper-voices/en/en_US/joe/medium/en_US-joe-medium.onnx --output_raw | aplay -f S16_LE -r 22050

links -dump -width 512 https://web.archive.org/web/20251002094157/https://www.tastyfish.cz/lrs/woman.html | tr "\n\r" " " | sed "s/^.*, consoomer version//g" | piper-tts --model /usr/share/piper-voices/en/en_US/john/medium/en_US-john-medium.onnx --output_raw | aplay -f S16_LE -r 22050
```

```bash
aplay -f S16_LE -r 22050
```

### Significado: 

```
Option	Meaning
-f S16_LE	Format = Signed 16-bit, Little-Endian samples (what Piper outputs)
-r 22050	Sample rate = 22050 Hz (Piper default)
```
