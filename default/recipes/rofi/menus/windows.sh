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
-lines 5 \
-padding 25 \
-line-padding 18 \
-width 30 \
-xoffset 0 \
-yoffset 65 \
-location 3 \
-columns 2 \
-no-lazy-grab \
-monitor primary \
-hide-scrollbar true \
-color-enabled true ${COLOURS} \
-theme-str 'element-icon { size: 1.2em; }' \
"

COMMAND="rofi ${OPTIONS} <<< '1) Start Windows (w/ Monitor)|2) Start Windows (w/ Video Stream)|3) Start Audio Stream|4) Start Mouse Stream|5) Start Video Stream|Shutdown 1|Shutdown 2|Quit 3|Quit 4|Quit 5'"
SELECTION=$(echo ${COMMAND} | sh)

case "${SELECTION}" in
    "1) Start Windows (w/ Monitor)")
        $USERSCRIPTS/qemu-control windows boot monitor
        ;;

    "2) Start Windows (w/ Video Stream)")
        $USERSCRIPTS/qemu-control windows boot lookingglass
        ;;

    "3) Start Audio Stream")
        $USERSCRIPTS/qemu-control windows run scream
        ;;

    "4) Start Mouse Stream")
        $USERSCRIPTS/qemu-control windows run barrier
        ;;

    "5) Start Video Stream")
        $USERSCRIPTS/qemu-control windows run lookingglass
        ;;

    "Shutdown 1")
        $USERSCRIPTS/qemu-control windows shutdown monitor
        ;;

    "Shutdown 2")
        $USERSCRIPTS/qemu-control windows shutdown lookingglass
        ;;

    "Quit 3")
        $USERSCRIPTS/qemu-control windows kill scream
        ;;

    "Quit 4")
        $USERSCRIPTS/qemu-control windows kill barrier
        ;;

    "Quit 5")
        $USERSCRIPTS/qemu-control windows kill lookingglass
        ;;
esac

# COMMAND="rofi ${OPTIONS} <<< 'boot/monitor|boot/lookingglass|shutdown|process/scream|process/barrier|process/lookingglass'"
# SELECTION=$(echo ${COMMAND} | sh)

# case "${SELECTION}" in
#     "boot/monitor")
#         $USERSCRIPTS/qemu-control windows boot monitor
#         ;;

#     "boot/lookingglass")
#         $USERSCRIPTS/qemu-control windows boot lookingglass
#         ;;

#     "shutdown")
#         $USERSCRIPTS/qemu-control windows shutdown
#         ;;

#     "process/scream")
#         $USERSCRIPTS/qemu-control windows run scream
#         ;;

#     "process/barrier")
#         $USERSCRIPTS/qemu-control windows run barrier
#         ;;

#     "process/lookingglass")
#         $USERSCRIPTS/qemu-control windows run lookingglass
#         ;;
# esac
