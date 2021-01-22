#!/usr/bin/env bash

# Twitter Firefox
i3-msg --quiet "exec --no-startup-id nohup firefoxtwitter >/dev/null 2>&1 &"

# Discord
# i3-msg --quiet "exec --no-startup-id nohup discord --disable-seccomp-filter-sandbox >/dev/null 2>&1 &"
i3-msg --quiet "exec --no-startup-id nohup discord --no-sandbox >/dev/null 2>&1 &"

# Signal
i3-msg --quiet "exec --no-startup-id nohup signal-desktop >/dev/null 2>&1 &"

# Ferdi
i3-msg --quiet "exec --no-startup-id nohup ferdi >/dev/null 2>&1 &"

# Slack
#i3-msg --quiet "exec --no-startup-id nohup slack >/dev/null 2>&1 &"

# Element/Riot
# i3-msg --quiet "exec --no-startup-id nohup element-desktop >/dev/null 2>&1 &"

# YouTube Firefox
i3-msg --quiet "exec --no-startup-id nohup firefoxyoutube >/dev/null 2>&1 &"

# Spotify
i3-msg --quiet "exec --no-startup-id LD_PRELOAD=/usr/lib/libcurl-gnutls.so.3:/usr/lib/spotifywm.so nohup spotify >/dev/null 2>&1 &"

# TodoList
i3-msg --quiet "exec --no-startup-id nohup alacritty --config-file ~/.config/alacritty/todolist.yml --title AlacrittyTodoList --class AlacrittyTodoList -e zsh -i -c 'tb && $SHELL' >/dev/null 2>&1 &"
