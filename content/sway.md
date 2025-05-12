---
title: "Sway"
date: 2025-04-08T22:28:35-03:00
tags: ['linux']
---
Agregar a sway en `/etc/sway/config` para moverse al último workspace

# Toggle workspaces
### Para grabar la pantalla en OBS.
```bash
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-wlr 
```

```bash
# PARA OBS
# Set XDG_CURRENT_DESKTOP for proper Wayland support
# No me sirvió
exec --no-startup-id dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway


# Start xdg-desktop-portal services (ensure wlr starts first)
# No me sirvió
# exec --no-startup-id /usr/lib/xdg-desktop-portal-wlr &
# exec --no-startup-id /usr/lib/xdg-desktop-portal -r

#### Me sirvió
exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DISPLAY
exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway 


bindsym --locked XF86HomePage exec firefox
bindsym --locked XF86AudioPlay exec smtube
bindsym --locked XF86Mail exec thunderbird



#### Para cambiar workspaces TAB.
bindsym $mod+Tab workspace back_and_forth

input * {
    xkb_layout "es"
}
```

https://wiki.linuxquestions.org/wiki/XF86_keyboard_symbols

###### Actions                                                                                                                                     
* Mod + Enter New terminal                                                                                                             
* Mod + F Make current window fullscreen                                       
* Mod + Shift + Q Quit program                                                                                                         
* Mod + Shift + E Exit Sway                                                                                                            
* Mod + Shift + C Reload Sway configuration                                          
* Mod + Shift + - Move window to scratchpad                                                                                            
* Mod + - Show scratchpad                                                           
###### Workspaces keys                                                                      
* Mod + 0..9 Change current workspace                                         
* Mod + Shift + 0..9 Move current window to designated workspace             
* Mod + B Horizontal layout                                                 
* Mod + V Vertical layout                                                  
* Mod + S Stacking layout                                                 
* Mod + E Toggle split layout                                            
* Mod + W Tabbed layout                                                 
* Mod + A Focus on parent container                                    
* Mod + Space Swap focus between tiling and floating                  
* Mod + Shift + Space Toggle floating mode                                                                                             
* Mod + Tab Next workspace                                           
* Mod + Shift + Tab Previous workspace                              
* Mod + Left/Right/Up/Down Move focus of the window                
* Mod + Shift + Left/Right/Up/Down Move the focused window in the workspace              

###### Resize mode
To resize windows, you must enter resize mode, with the Mod + R keybinding. After you enter resize mode you can resize windows with Left/Right/Up/Down keys, and press enter or escape to return to default mode.                                                                                            
