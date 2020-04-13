#!/bin/bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-display-drun 'Applications :' \
-font 'Fira Code 16' \
-show drun \
-drun-display-format \" {name}\" \
-bw 5 \
-lines 10 \
-padding 80 \
-line-padding 18 \
-width 40 \
-xoffset 0 \
-yoffset -50 \
-location 7 \
-columns 2 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-show-icons \
-icon-theme \"Papirus\" \
-color-enabled true \
-color-enabled true ${COLOURS}\
"

COMMAND="rofi ${OPTIONS}"
$(echo ${COMMAND} | sh)
