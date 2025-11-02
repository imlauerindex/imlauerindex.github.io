---
title: "Buscar todos los mp4 y reproducirlos con mp4"
date: 2025-11-02T15:36:49-03:00
---

```bash
find . -type f -name "*.mp4" -exec mpv {} \;
```

