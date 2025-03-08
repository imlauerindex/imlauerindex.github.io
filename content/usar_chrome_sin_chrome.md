---
title: "Usar chrome sin chrome: Chrome headless"
date: 2025-03-08T08:02:01-03:00
tags: ['chrome']
---
```bash
chromium --headless https://youtube.com --run-all-compositor-stages-before-draw --screenshot --virtual-time-budget=10000
```

O también se puede usar el parámetro `--print-to-pdf=/tmp/tmp.pdf`

```bash
chromium --headless --dump-dom youtube.com
```

```bash
chromium --headless https://bilibili.com --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | w3m -
```
