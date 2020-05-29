#!/usr/bin/env bash

xrandr \
    --output DVI-D-0 --off \
    --output HDMI-A-0 --off \
    --output DisplayPort-1 --off \
    --output DisplayPort-0 \
        --primary \
        --mode 3840x2160 \
        --pos 0x0 \
        --rotate normal \
    --output DisplayPort-2 \
        --mode 3840x2160 \
        --pos 3840x0 \
        --rotate normal

i3-msg "restart"

sleep 3

${RICE_COOKER_DIST}/polybar/polybar.sh &

i3-msg "gaps bottom all set 15;"

pkill conky 2> /dev/null

cd ${RICE_COOKER_DIST}/conky && conky -c ${RICE_COOKER_DIST}/conky/conky.conf --quiet &

i3-msg "workspace 2; focus parent; workspace 10; focus parent;"
