---
title: "Bash autosuggestions: FZF"
date: 2025-06-21T16:21:54-03:00
tags: ['linux']
---
Usando `Control+R` y fzf se puede lograr. 

On Arch, after installing fzf with `pacman -S fzf`, you just need to add this line to your `~/.bashrc` for `autosuggestions and keybindings`:

```bash
eval "$(fzf --bash)"
```


Alternatively, you can source the scripts directly:

```bash
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
```


Then restart your terminal or run source `~/.bashrc`. Now you'll have fuzzy completion and handy shortcuts like `Ctrl+T`, `Ctrl+R`, and Alt+C in Bash! 🎉


