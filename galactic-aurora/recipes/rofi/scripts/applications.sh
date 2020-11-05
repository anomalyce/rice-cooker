#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-display-drun 'Applications :' \
-font 'Fira Code 16' \
-show drun \
-drun-display-format \" {name}\" \
-bw 15 \
-lines 15 \
-padding 25 \
-line-padding 15 \
-width 30 \
-xoffset 0 \
-yoffset 65 \
-location 1 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-show-icons \
-icon-theme \"Papirus\" \
-color-enabled true ${COLOURS} \
-theme-str 'element-icon { size: 1.2em; }' \
"

COMMAND="rofi ${OPTIONS}"
$(echo ${COMMAND} | sh)
