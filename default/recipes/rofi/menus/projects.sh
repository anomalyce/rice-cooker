#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-p 'Projects :' \
-font 'Fira Code 16' \
-sep '|' \
-dmenu \
-i \
-bw 2 \
-lines 10 \
-padding 25 \
-line-padding 18 \
-width 30 \
-xoffset 0 \
-yoffset 0 \
-location 0 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-color-enabled true ${COLOURS} \
-theme-str 'element-icon { size: 1.2em; } element-text, element-icon { background-color: inherit; text-color: inherit; }' \
"

COMMAND="rofi ${OPTIONS} <<< '$1'"
echo $(echo ${COMMAND} | sh)
