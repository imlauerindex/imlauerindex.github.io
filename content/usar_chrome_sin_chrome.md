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

Usarlo con w3m como navegador externo: Creá un archivo llamado `w3m_chromium.sh` con el siguiente contenido y agregalo como navegador externo en w3m.
```bash
chromium --headless $1 --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | w3m -
```

#### La que actualmente estoy usando 
```bash
chromium --headless $1 --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | monolith - -I -b $1 | w3m -
```
