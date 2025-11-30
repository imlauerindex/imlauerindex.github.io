---
title: "CLI video editing"
date: 2025-11-30T19:27:39-03:00
---
**Yes — there *are* existing command-line video editors**, but none of them do *everything* in one place like the script I made.
Here’s what already exists on Linux, especially Arch:

---

# ✅ **1. `ffmpeg` (the core tool)**

This is the main foundation.
It can edit videos, add text, filters, audio, etc.

But **ffmpeg alone is not a full editor** — it's a huge toolbox, not a workflow.

---

# ✅ **2. `melt` (MLT framework)**

Arch package: `mlt`
CLI video editing engine behind **Shotcut, Kdenlive**.

CLI example:

```bash
melt input.mp4 -filter greyscale -consumer avformat:out.mp4
```

Pros:

* Very powerful
* Can build full timelines
* Multi-track editing

Cons:

* Harder syntax
* Not aimed at quick meme or TTS videos
* No voice/TTS, no music mixing shortcuts

---

# ✅ **3. `mpv` + scripting**

`mpv` can apply filters, speed changes, etc.
But doesn't export/edit video (only plays).

---

# ✅ **4. `avconv` / `libav-tools`**

Old alternative to `ffmpeg`, mostly deprecated.

---

# ✅ **5. `kdenlive-render` (CLI rendering from Kdenlive project files)**

If you use Kdenlive, you can render from terminal.
But not for live editing.

---

# ❌ What *does NOT* exist:

There is **no single, simple, all-in-one CLI video editor** that:

* cuts
* trims
* speeds up
* reverses
* adds text
* adds watermarks
* adds TTS
* changes voice
* mixes background music
* adds filters
* repairs audio
* exports final video

**all in one command-line tool**, with short, easy commands.

That's why people usually:

* use **ffmpeg** manually
* or build their own wrapper scripts
* or use a UI editor

---

# ⭐ What your script does differently (and why it’s useful)

Your script is a **wrapper toolkit**, similar to:

* `ytfzf` (wrapper around `yt-dlp`)
* `mediabackup` scripts
* `imagemagick` helper scripts

It’s meant to simplify:

```
./cli_video_editor.sh add_text video.mp4 "HELLO" 50 50 60 out.mp4
```

instead of:

```
ffmpeg -i video.mp4 -vf "drawtext=fontfile=/usr/share/fonts/TTF/DejaVuSans.ttf:text='HELLO':...
```

AND

It adds features **no CLI editor includes** by default:

* TTS generation
* funny voice effects
* meme text
* pixel filters
* glitch effects
* watermarking
* narration overlay
* background music mixing

Unless you install **10 separate tools** and run **10 different commands**, nothing does this out of the box.

---

# If you want…

I can turn this into:

### **Option A — AUR package**

`cli-video-editor-git`

### **Option B — Single archlinux script in /usr/local/bin**

One command: `editvid`

### **Option C — Add interactive menu**

TUI like:

```
1) Cut video
2) Add text
3) Add music
4) Generate meme
5) Voice effects
6) TTS narration
```

Just tell me **A, B, or C**.

