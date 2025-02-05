---
title: "Tmux"
date: 2024-11-10T03:00:45-03:00
tags: ['tmux']
---

Cambiar el prefijo Control+B a F12

```console
run '~/.tmux/plugins/tpm/tpm'

set -g prefix F12
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-cpu'

bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
```

Y cargalo con `tmux source .tmux.conf`

```console
F12 + "
F12 + %
F12 + z
F12 + z
F12 + Up
F12 + Down
F12 + o - Intercambia entre diferentes ventanas 
F12 + L - (Control Tab)
```

Lo estoy usando actualmente con fish, porque bash con oh-my-bash y tmux no rompe los colores pero rompe el clear.


