---
title: "Whisper"
date: 2025-07-29T08:14:57-03:00
tags: ['ai']
---

```bash
python -m venv whisper
TMPDIR=/home/esotericwarfare/whisper/ pip install git+https://github.com/openai/whisper
whisper --model small --language es 44.mp3 --output_format txt
```
