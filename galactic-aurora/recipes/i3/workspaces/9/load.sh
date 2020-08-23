#!/usr/bin/env bash

# ProtonMail
i3-msg --quiet "exec --no-startup-id nohup electron-mail --high-dpi-support=1 --force-device-scale-factor=1.5 >/dev/null 2>&1 &"

# Todoist
i3-msg --quiet "exec --no-startup-id nohup todoist --high-dpi-support=1 --force-device-scale-factor=1.5 >/dev/null 2>&1 &"

# Bitwarden
i3-msg --quiet "exec --no-startup-id nohup bitwarden --high-dpi-support=1 --force-device-scale-factor=1.5 >/dev/null 2>&1 &"
