#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-display-drun 'Applications :' \
-font 'Fira Code 16' \
-show drun \
-drun-display-format \" {name}\" \
-bw 2 \
-lines 10 \
-padding 25 \
-line-padding 15 \
-width 30 \
-xoffset 0 \
-yoffset 0 \
-location 0 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-show-icons \
-icon-theme \"Papirus\" \
-color-enabled true ${COLOURS} \
-theme-str 'element-icon { size: 1.2em; } element-text, element-icon { background-color: inherit; text-color: inherit; }' \
"

COMMAND="rofi ${OPTIONS}"
$(echo ${COMMAND} | sh)
