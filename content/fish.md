---
title: "Instalar shell fish con VIM keybindings, iniciar dvtm en el login."
date: 2024-11-03T21:29:15-03:00
tags: ['fish']
---
```bash
pacman -S fish
fish_vi_key_bindings
```

Si querés modificar más tu fish podés ejecutar `fish_TAB`


En `.config/fish/config.fish` agregá:

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec dvtm
  end
end


