#!/usr/bin/env bash

# EasyEffects
i3-msg --quiet "exec --no-startup-id nohup easyeffects >/dev/null 2>&1 &"

# PavuControl
i3-msg --quiet "exec --no-startup-id nohup pavucontrol >/dev/null 2>&1 &"
