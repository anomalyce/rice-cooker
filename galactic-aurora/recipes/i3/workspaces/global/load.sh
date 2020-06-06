#!/usr/bin/env bash

# Dunst
i3-msg --quiet "exec --no-startup-id nohup dunst >/dev/null 2>&1 &"

# Compton
i3-msg --quiet "exec --no-startup-id nohup dbus-launch picom >/dev/null 2>&1 &"
