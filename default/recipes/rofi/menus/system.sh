#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-p 'System :' \
-font 'Fira Code 16' \
-sep '|' \
-dmenu \
-i \
-bw 2 \
-lines 4 \
-padding 25 \
-line-padding 18 \
-width 20 \
-xoffset 0 \
-yoffset 0 \
-location 0 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-color-enabled true ${COLOURS} \
-theme-str 'element-icon { size: 1.2em; } element-text, element-icon { background-color: inherit; text-color: inherit; }' \
"

COMMAND="rofi ${OPTIONS} <<< 'Lock|Log Out|Reboot|Shutdown'"
SELECTION=$(echo ${COMMAND} | sh)

case "${SELECTION}" in
    "Lock")
        ${SELF_DIR}/lockscreen/lock.sh
        ;;

    "Log Out")
        i3-msg exit
        ;;

    "Reboot")
        systemctl reboot
        ;;

    "Shutdown")
        systemctl -i poweroff
        ;;
esac
