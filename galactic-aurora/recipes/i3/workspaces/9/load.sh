#!/usr/bin/env bash

# Todoist
# i3-msg --quiet "exec --no-startup-id nohup todoist --high-dpi-support=1 --force-device-scale-factor=1.5 >/dev/null 2>&1 &"

# Notion
i3-msg --quiet "exec --no-startup-id nohup notion-app >/dev/null 2>&1 &"

# Toggl Desktop
#i3-msg --quiet "exec --no-startup-id QT_SCALE_FACTOR=1.5 nohup TogglDesktop >/dev/null 2>&1 &"

# Bitwarden
i3-msg --quiet "exec --no-startup-id nohup bitwarden --high-dpi-support=1 --force-device-scale-factor=1.05 >/dev/null 2>&1 &"

# ProtonMail
i3-msg --quiet "exec --no-startup-id nohup electron-mail --high-dpi-support=1 --force-device-scale-factor=1.5 >/dev/null 2>&1 &"
