#!/bin/bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-p 'Windows :' \
-font 'Fira Code 16' \
-sep '|' \
-dmenu \
-i \
-bw 5 \
-lines 4 \
-padding 80 \
-line-padding 18 \
-width 20 \
-xoffset 0 \
-yoffset -50 \
-location 7 \
-columns 1 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-color-enabled true \
-color-enabled true ${COLOURS}\
"

COMMAND="rofi ${OPTIONS} <<< 'Boot (Monitor)|Boot (Looking Glass)|Shutdown|Looking Glass Client'"
SELECTION=$(echo ${COMMAND} | sh)

case "${SELECTION}" in
    "Boot (Monitor)")
        $USERSCRIPTS/win10/start-monitor.sh
        ;;

    "Boot (Looking Glass)")
        $USERSCRIPTS/win10/start-lookingglass.sh
        ;;

    "Shutdown")
        $USERSCRIPTS/win10/shutdown.sh
        ;;

    "Barrier Client")
        $USERSCRIPTS/win10/barrier.sh
        ;;

    "Looking Glass Client")
        $USERSCRIPTS/win10/looking-glass.sh
        ;;
esac
