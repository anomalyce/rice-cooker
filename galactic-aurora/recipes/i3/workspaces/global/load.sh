#!/usr/bin/env bash

export CONFIGPATH="${HOME}/.config"

# Dunst
i3-msg --quiet "exec --no-startup-id nohup dunst >/dev/null 2>&1 &"

# Compton
i3-msg --quiet "exec --no-startup-id nohup dbus-launch picom --config=${CONFIGPATH}/picom/picom.conf >/dev/null 2>&1 &"
