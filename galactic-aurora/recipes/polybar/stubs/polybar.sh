#!/usr/bin/env sh

killall -q polybar

while pgrep -u @{UID} -x polybar >/dev/null; do sleep 1; done

polybar main -c ${RECIPE_DIST_DIR}/config.ini &
