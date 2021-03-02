#!/usr/bin/env bash

# xrandr \
#     --output "${MONITOR_PRIMARY}" --primary --mode 3840x2160 --pos 3840x0 --rotate normal \
#     --output DisplayPort-1 --off \
#     --output "${MONITOR_SECONDARY}" --mode 3840x2160 --pos 0x0 --rotate normal \
#     --output HDMI-A-0 --off \
#     --output DVI-D-0 --off

<<<<<<< HEAD
SCREENLAYOUT="${RECIPE_DIST_DIR}/../qemu-windows/screenlayouts/dual-4k.sh"

if [[ -f "${LAYOUT/dual-4k.json/dual-4k-vertical.json}" ]]; then
    SCREENLAYOUT="${SCREENLAYOUT/dual-4k.json/dual-4k-vertical.json}"
=======
if [[ "${MONITOR_LAYOUT_VERTICAL}" != "1" ]]; then
    ${RECIPE_DIST_DIR}/../qemu-windows/dual-4k.sh
else
    ${RECIPE_DIST_DIR}/../qemu-windows/dual-4k-vertical.sh
>>>>>>> f9bc326 (Update)
fi

source "${SCREENLAYOUT}"
