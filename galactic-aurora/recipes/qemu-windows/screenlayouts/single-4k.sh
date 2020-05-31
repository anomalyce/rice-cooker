#!/usr/bin/env bash

i3-msg "exec --no-startup-id xrandr --output DVI-D-0 --off --output HDMI-A-0 --off --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --primary --mode 3840x2160 --pos 3840x0 --rotate normal"

i3-msg "gaps bottom all set 65"

i3-msg "exec --no-startup-id ${HOME}/.local/share/rice-cooker/polybar/polybar.sh &"

i3-msg "exec --no-startup-id pkill conky"
i3-msg "exec --no-startup-id sleep 2 && cd ${HOME}/.local/share/rice-cooker/conky && conky --quiet --config=${HOME}/.local/share/rice-cooker/conky/conky-bottom.conf &"

i3-msg "workspace 10; focus parent;"
