#!/usr/bin/env bash
# Depends on: imagemagick, xdpyinfo, dunst & i3lock

notify-send DUNST_COMMAND_PAUSE

SELF_DIR=`realpath $(dirname "$0")`
LOCKSCREEN="@[[SELF_DIR]]/lockscreen.png"

if [ ! -f "${THEME_WALLPAPER}" ]; then
    echo "Cannot found image '${THEME_WALLPAPER}'"
    exit 1
fi

WIDTH="$(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx  -f1)"
HEIGHT="$(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx  -f2)"
HALF_WIDTH="$(( WIDTH / 2 ))"

if [ ! -f "@[[LOCKSCREEN]]" ]; then
    convert \
        -gravity Center \
        -resize "@[[HALF_WIDTH]]x@[[HEIGHT]]" \
        -extent "@[[HALF_WIDTH]]x@[[HEIGHT]]" \
        -gravity West \
        -splice "@[[HALF_WIDTH]]x0" \
        -background Black \
        -blur 0x5 \
        "${THEME_WALLPAPER}" "@[[LOCKSCREEN]]"
        
        # -colorspace Gray \
fi

INDICATOR_X="$(( HALF_WIDTH + $(( HALF_WIDTH / 2 )) ))"
INDICATOR_Y="$(( HEIGHT - 180 ))"
INDICATOR_Y_DATE="$(( HEIGHT - 130 ))"

i3lock -i "@[[LOCKSCREEN]]" \
    --screen 1 \
    --indicator \
    --ring-width 10 \
    --radius 200 \
    --no-unlock-indicator \
    --ignore-empty-password \
    --pointer="win" \
    --indpos="@[[INDICATOR_X]]:@[[INDICATOR_Y]]" \
    --clock \
    --timesize=70 \
    --timecolor="#cdd5dfFF" \
    --timestr="%H:%M:%S" \
    --datesize=24 \
    --datecolor="#afbbc9BB" \
    --datestr="%A, %B %d %Y" \
    --datepos="@[[INDICATOR_X]]:@[[INDICATOR_Y_DATE]]"

notify-send DUNST_COMMAND_RESUME
