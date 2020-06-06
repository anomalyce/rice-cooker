#!/usr/bin/env bash

xrandr \
    --output "${MONITOR_PRIMARY}" --primary --mode 3840x2160 --pos 3840x0 --rotate normal \
    --output DisplayPort-1 --off \
    --output "${MONITOR_SECONDARY}" --mode 3840x2160 --pos 0x0 --rotate normal \
    --output HDMI-A-0 --off \
    --output DVI-D-0 --off
