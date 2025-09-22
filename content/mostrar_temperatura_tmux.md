---
title: "Mostrar temperatura tmux, batería, fecha y hora en TMUX"
date: 2024-11-19T16:07:44-03:00
tags: ['tmux']
---

```bash
set -g status-right 'temp: #(cat /sys/class/thermal/thermal_zone4/temp) | battery: #(cat /sys/class/power_supply/BAT1/capacity)% | #(date "+%Y-%m-%d %H:%M:%S")'
```

