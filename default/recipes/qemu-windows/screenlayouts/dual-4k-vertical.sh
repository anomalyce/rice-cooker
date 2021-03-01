#!/usr/bin/env bash

i3-msg "exec --no-startup-id xrandr \
    --output "${MONITOR_PRIMARY}" --primary --mode 3840x2160 --pos 2160x840 --rotate normal \
    --output DisplayPort-1 --off \
    --output "${MONITOR_SECONDARY}" --mode 3840x2160 --pos 0x0 --rotate right \
    --output HDMI-A-0 --off \
    --output DVI-D-0 --off"

i3-msg "gaps bottom all set 0"

i3-msg "exec --no-startup-id ${HOME}/.local/share/rice-cooker/polybar/polybar.sh &"

i3-msg "exec --no-startup-id pkill conky"
i3-msg "exec --no-startup-id sleep 1 && cd ${HOME}/.local/share/rice-cooker/conky && conky --quiet --config=${HOME}/.local/share/rice-cooker/conky/conky.conf &"

i3-msg "workspace 10; workspace 2"
