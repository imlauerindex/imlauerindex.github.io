---
title: "Srt to txt"
date: 2025-08-02T09:39:33-03:00
tags: ['subtitles']
---

```bash
yt-dlp --write-sub --sub-lang es --skip-download https://www.youtube.com/watch?v=VIDEO\_ID
```
---

### **✅ 3\. Convert `.vtt` or `.srt` to plain text**

You can convert subtitle files to plain text using simple scripts.

#### **🔧 Example for `.vtt` (WebVTT format):**

grep \-vE "^\[0-9\]+$|^$|^--\>" subtitle.vtt | sed 's/\<\[^\>\]\*\>//g' \> subtitles.txt

#### **🔧 Example for `.srt`:**

grep \-vE "^\[0-9\]+$|^$|^\[0-9\]{2}:\[0-9\]{2}:\[0-9\]{2}," subtitle.srt \> subtitles.txt

