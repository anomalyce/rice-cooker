#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

COLOURS="$(cat ${SELF_DIR}/colours.sh)"
OPTIONS="\
-p 'Windows :' \
-font 'Fira Code 16' \
-sep '|' \
-dmenu \
-i \
-bw 15 \
-lines 3 \
-padding 25 \
-line-padding 18 \
-width 20 \
-xoffset 0 \
-yoffset 65 \
-location 3 \
-columns 2 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-color-enabled true ${COLOURS}\
"

COMMAND="rofi ${OPTIONS} <<< 'boot/monitor|boot/lookingglass|shutdown|process/scream|process/barrier|process/lookingglass'"
SELECTION=$(echo ${COMMAND} | sh)

case "${SELECTION}" in
    "boot/monitor")
        $USERSCRIPTS/qemu-control windows boot monitor
        ;;

    "boot/lookingglass")
        $USERSCRIPTS/qemu-control windows boot lookingglass
        ;;

    "shutdown")
        $USERSCRIPTS/qemu-control windows shutdown
        ;;

    "process/scream")
        $USERSCRIPTS/qemu-control windows run scream
        ;;

    "process/barrier")
        $USERSCRIPTS/qemu-control windows run barrier
        ;;

    "process/lookingglass")
        $USERSCRIPTS/qemu-control windows run lookingglass
        ;;
esac
