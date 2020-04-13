#!/bin/bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-p 'System :' \
-font 'Fira Code 16' \
-sep '|' \
-dmenu \
-i \
-bw 5 \
-lines 3 \
-padding 80 \
-line-padding 18 \
-width 20 \
-xoffset 0 \
-yoffset \
-50 \
-location 5 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-color-enabled true ${COLOURS}\
"

COMMAND="rofi ${OPTIONS} <<< 'Log Out|Reboot|Shutdown'"
SELECTION=$(echo ${COMMAND} | sh)

case "${SELECTION}" in
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
