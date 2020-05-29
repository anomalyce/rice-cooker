#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-font 'Fira Code 16' \
-show calc \
-modi calc \
-no-show-match \
-no-sort \
-terse \
-calc-command \"echo '{result}' | xclip -selection clipboard\" \
-i \
-bw 15 \
-lines 0 \
-padding 40 \
-line-padding 18 \
-width 25 \
-xoffset 0 \
-yoffset -50 \
-location 0 \
-monitor primary \
-hide-scrollbar true \
-color-enabled true ${COLOURS}\
"

COMMAND="rofi ${OPTIONS}"
$(echo ${COMMAND} | sh)
