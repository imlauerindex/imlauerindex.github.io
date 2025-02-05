---
title: "Mostrar temperatura tmux"
date: 2024-11-19T16:07:44-03:00
tags: ['tmux']
---

[https://medium.com/@cristianduguet/track-cpu-and-gpu-temperature-in-tmux-52d3e18457e2](https://medium.com/@cristianduguet/track-cpu-and-gpu-temperature-in-tmux-52d3e18457e2)


Tenés que instalarlos usando el tmux plugin manager.


[https://github.com/tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)


```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
```

