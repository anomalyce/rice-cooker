#!/usr/bin/env bash

i3-msg "exec --no-startup-id xrandr \
    --output "${MONITOR_LEFT}" --mode 3840x2160 --dpi 96 --pos 0x0 --scale 1x1 --rotate right --rate 60.00 \
    --output "${MONITOR_PRIMARY}" --mode 2560x1440 --dpi 124 --pos 2160x1200 --scale 1x1 --rotate normal --rate 144.00 --primary \
    --output "${MONITOR_RIGHT}" --mode 3840x2160 --dpi 96 --pos 4720x0 --scale 1x1 --rotate left --rate 60.00 \
    --output HDMI-A-0 --off \
    --output DVI-D-0 --off"

i3-msg "gaps bottom all set 0"

i3-msg "exec --no-startup-id /home/anomalyce/.local/share/rice-cooker/polybar/polybar.sh &"

#i3-msg "exec --no-startup-id pkill conky"
#i3-msg "exec --no-startup-id sleep 1 && cd /home/anomalyce/.local/share/rice-cooker/conky && conky --quiet --config=/home/anomalyce/.local/share/rice-cooker/conky/conky.conf &"

i3-msg "workspace 10; workspace 2"
