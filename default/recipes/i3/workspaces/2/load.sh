#!/usr/bin/env bash

# Firefox
i3-msg --quiet "exec --no-startup-id nohup firefox -P default --new-instance --class='firefox' >/dev/null 2>&1 &"

# Twitter Firefox
i3-msg --quiet "exec --no-startup-id nohup firefoxtwitter >/dev/null 2>&1 &"
