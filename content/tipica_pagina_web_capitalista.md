---
title: "Humor: Típica página web consumista. Espeak y piper para leer textos."
date: 2025-11-09T18:03:14-03:00
tags: ['www']
---


Crean contenido clickbaitero para atraer a la gente estúpida para que compre publicidad. Toda la publicidad es falsa.

```console
 ________________________________________________________________________
|                                  |   |       |  |                   [X]|
| ~!ENLARGE PENIS WITH SNAKE OIL!~ |   |  CSS  |  | Video AD             |
|__________________________________|   |       |  |  CONSOOOOOOOOOOOOO   |
| U.S. PRESIDENT ASSASINATED           |  BUG  |  |   OOOOOOOOOOOM BICH  |
|                                      |       |  |______________________|
| Article unavailable in your country. |  LOL  | [make account or suffer]|
| [log in to enable mouse scrolling]   |       |                         |
|   ___________________________________|       |___     Prove you're a   |
|  |                                   |_______|   |    human, click all |
|  |       We masturbate over your privacy <3      |    images of type 2 |
|  |                                               |    quasars.         |
|  |             Consent with spying?              |    [*] [*] [*] [*]  |
|  |         _____               ______            |    [*] [*] [*] [*]  |
|  |        | YES |             |  OK  |           |   _________________ |
|  |         """""               """"""            |_ | FUCK MATURE MOMS||
|  |_______________________________________________| || IN 127.0.0.1    ||
|     |                                              || CHAT NOW !!!1!  ||
|     | Your browser is 2 seconds old, please update ||                 ||
|     | to newest version to view this site.         ||8000 NEW MESSAGES||
|     |                                              || hi dear, I NEED ||
|     | PLEASE DISABLE ADBLOCK OR DIE                || your cock       ||
|_____|______________________________________________||_________________||

```

Créditos: https://web.archive.org/web/20251027161132/https://www.tastyfish.cz/lrs/www.html

https://edramatica.com/Internet (Se lo robaron a TastyFish no le dieron el crédito).


Esto me genero Grok:


![](https://ia601407.us.archive.org/26/items/modern_web/subilo.jpg)

![](https://ia801501.us.archive.org/1/items/modern_web_2025/website_2025.jpg)


```bash
links -dump -width 512 https://web.archive.org/web/20251002094157/https://www.tastyfish.cz/lrs/woman.html | tr "\n\r" " " | sed "s/^.*, consoomer version//g" | espeak -s 120 -p 30
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

#### Si queres generar un archivo:

```
mkdir prueba && cd prueba 

links -dump -width 512 https://web.archive.org/web/20251002094157/https://www.tastyfish.cz/lrs/woman.html | tr "\n\r" " " | sed "s/^.*, consoomer version//g" | piper-tts --model /usr/share/piper-voices/en/en_US/joe/medium/en_US-joe-medium.onnx --output .
```


```bash
aplay -f S16_LE -r 22050 file.wav
```

### Significado: 

```
Option	Meaning
-f S16_LE	Format = Signed 16-bit, Little-Endian samples (what Piper outputs)
-r 22050	Sample rate = 22050 Hz (Piper default)
```
