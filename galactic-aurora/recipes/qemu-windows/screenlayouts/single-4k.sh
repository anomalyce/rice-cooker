#!/usr/bin/env bash

xrandr \
    --output DVI-D-0 --off \
    --output HDMI-A-0 --off \
    --output DisplayPort-0 --off \
    --output DisplayPort-1 --off \
    --output DisplayPort-2 \
        --primary \
        --mode 3840x2160 \
        --pos 3840x0 \
        --rotate normal 

i3-msg "restart"

sleep 3

${RICE_COOKER_DIST}/polybar/polybar.sh &

i3-msg "gaps bottom all set 65"

pkill conky 2> /dev/null

cd ${RICE_COOKER_DIST}/conky && conky -c ${RICE_COOKER_DIST}/conky/conky-bottom.conf --quiet &

i3-msg "workspace 10; focus parent;"
