#!/usr/bin/env bash

export CONFIGPATH="${HOME}/.config"

# Dunst
i3-msg --quiet "exec --no-startup-id nohup dunst >/dev/null 2>&1 &"

# Compton
i3-msg --quiet "exec --no-startup-id nohup dbus-launch picom --experimental-backends --config=${CONFIGPATH}/picom/picom.conf >/dev/null 2>&1 &"

# KeeWeb (Scratchpad)
#i3-msg --quiet "exec --no-startup-id nohup keeweb --force-device-scale-factor=2 >/dev/null 2>&1 &"
