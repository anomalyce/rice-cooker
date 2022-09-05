#!/usr/bin/env bash

# Discord
# i3-msg --quiet "exec --no-startup-id nohup discord --disable-seccomp-filter-sandbox >/dev/null 2>&1 &"
i3-msg --quiet "exec --no-startup-id nohup discord --no-sandbox >/dev/null 2>&1 &"

# Signal
i3-msg --quiet "exec --no-startup-id nohup signal-desktop >/dev/null 2>&1 &"

# Ferdi
# i3-msg --quiet "exec --no-startup-id nohup ferdi >/dev/null 2>&1 &"

# WhatsDesk
i3-msg --quiet "exec --no-startup-id nohup whatsdesk >/dev/null 2>&1 &"

# Slack
# i3-msg --quiet "exec --no-startup-id nohup slack >/dev/null 2>&1 &"

# Element/Riot
# i3-msg --quiet "exec --no-startup-id nohup element-desktop >/dev/null 2>&1 &"

# YouTube Firefox
i3-msg --quiet "exec --no-startup-id nohup firefoxyoutube >/dev/null 2>&1 &"

# Spotify
i3-msg --quiet "exec --no-startup-id LD_PRELOAD=/usr/lib/libcurl-gnutls.so.3:/usr/lib/spotifywm.so nohup spotify >/dev/null 2>&1 &"

# Startup Shell
i3-msg --quiet "exec --no-startup-id nohup WINIT_X11_SCALE_FACTOR=randr alacritty --config-file ~/.config/alacritty/alacritty.yml --title AlacrittyStartup --class AlacrittyStartup -e zsh >/dev/null 2>&1 &"

# Taskbook
# i3-msg --quiet "exec --no-startup-id nohup WINIT_X11_SCALE_FACTOR=randr alacritty --config-file ~/.config/alacritty/alacritty.yml --title AlacrittyTodolist --class AlacrittyTodolist -e zsh -i -c 'tb && $SHELL' >/dev/null 2>&1 &"
