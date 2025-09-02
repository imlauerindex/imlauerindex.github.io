---
title: "Instalar shell fish con VIM keybindings, iniciar dvtm en el login."
date: 2024-11-03T21:29:15-03:00
tags: ['fish']
---
```bash
pacman -S fish
fish_vi_key_bindings
set -U fish_greeting # deshabilita mensaje de bienvenida

```

Si querés modificar más tu fish podés ejecutar `fish_TAB`


En `.config/fish/config.fish` agregá:

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec dvtm
  end
end


Mis alias actuales:

```bash
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
#export QT_QPA_PLATFORM=wayland
#alias dgg 'w3m -sixel dgg.gg'
#alias f1 'bash scripts/f1exposure.sh'
#alias google 'cha -V google.com'
#alias wgoogle 'w3m -sixel google.com'
#alias tdgg 'w3m -sixel dgg.gg'
#alias imlauera 'w3m -sixel imlauera.github.io'
#alias cimlauera 'cha -V imlauera.github.io'
#alias invidious 'w3m -sixel https://inv.nadeko.net/feed/subscriptions'
#alias cinvidious 'cha -V https://inv.nadeko.net/feed/subscriptions'
#alias upwork="falkon upwork.com"
#alias linkedin="falkon linkedin.com"
#alias freelancer="falkon freelancer.com"
#alias rcommandline="w3m old.reddit.com/r/commandline"
#alias buenosaires="w3m old.reddit.com/r/BuenosAires"
#alias duolingo="falkon https://duolingo.com/learn"
#alias f1="echo 'Los tiempos están en UTC. Coordinated Universal Time está 3 horas adelantado a Buenos Aires'; bash $HOME/scripts/f1exposure.sh | jq ."
#alias chatgpt="falkon chatgpt.com"
#alias telegram="falkon web.telegram.org"

alias wiby="netsurf-fb -f sdl -w 1366 -h 768 http://wiby.org/surprise"
alias ce="netsurf-fb -f sdl -w 1366 -h 768 http://cursoelectricidad.github.io"
alias imlauer="netsurf-fb -f sdl -w 1366 -h 768 http://imlauera.github.io"
alias hp="netsurf-fb -f sdl -w 1366 -h 768 http://hyperphysics.phy-astr.gsu.edu/hbasees/hframe.html"
alias 3dgames="netsurf-fb -f sdl -w 1366 -h 768 https://foros.3dgames.com.ar"
alias news="netsurf-fb -f sdl -w 1366 -h 768 news.ycombinator.com"
alias argentina="netsurf-fb -f sdl -w 1366 -h 768 old.reddit.com/r/argentina"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..="cd .."
#export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM=eglfs
#export QTWEBENGINE_CHROMIUM_FLAGS="--ignore-gpu-blacklist --disable-gpu"
export QTWEBENGINE_CHROMIUM_FLAGS="--ignore-gpu-blacklist"


export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
export QT_QPA_FONTDIR=/lib/Fonts
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/plugins/platforms
export QT_QPA_EGLFS_PHYSICAL_WIDTH=155
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=86
export QT_QPA_EGLFS_WIDTH=1024
export QT_QPA_EGLFS_HEIGHT=614
export QT_QPA_EGLFS_NO_LIBINPUT=0

#export QT_QPA_EGLFS_KEYBOARD_LAYOUT='es'
#export QT_QPA_EGLFS_KBD_MAP='es'

#export QT_QPA_EGLFS_FULLSCREEN=1
export XKB_DEFAULT_LAYOUT=es

alias drudgereport="netsurf-fb -f sdl -w 1366 -h 768 drudgereport.com"
alias dgg='w3m  dgg.gg'
alias google='cha -V google.com'
alias wgoogle='w3m  google.com'
alias blog='w3m imlauer.blogspot.com'
alias tdgg='w3m  dgg.gg'
alias imlauera='cha -V imlauera.github.io'
alias analisismatematico2='netsurf-fb -f sdl -w 1366 -h 768 analisismatematico2.github.io'
alias wimlauera='w3m imlauera.github.io'
alias invidious='w3m  https://inv.nadeko.net/feed/subscriptions'
alias cinvidious='cha -V https://inv.nadeko.net/feed/subscriptions'
alias upwork="falkon upwork.com"
alias linkedin="falkon linkedin.com"
alias freelancer="falkon freelancer.com"
alias rcommandline="w3m old.reddit.com/r/commandline"
alias buenosaires="w3m old.reddit.com/r/BuenosAires"
alias duolingo="falkon https://duolingo.com/learn"
alias f1="bash $HOME/scripts/f1exposure.sh"
alias chatgpt="falkon chatgpt.com"
alias telegram="falkon web.telegram.org"


```
