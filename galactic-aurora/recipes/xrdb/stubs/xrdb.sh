#!/usr/bin/env bash

source ${HOME}/.setup

xrdb \
    -DUSER_AVATAR="${USER_AVATAR}" \
    -DUSER_WALLPAPER="${USER_WALLPAPER}" \
    -DSETTINGS_BORDERRADIUS="${SETTINGS_BORDERRADIUS}" \
    -DSETTINGS_BORDERSIZE="${SETTINGS_BORDERSIZE}" \
    -DSETTINGS_GAPSIZE="${SETTINGS_GAPSIZE}" \
    -DHW_MOUSE="${HW_MOUSE}" \
    -DHW_SOUNDCARD="${HW_SOUNDCARD}" \
    -DHW_SOUNDCARD_MIC="${HW_SOUNDCARD_MIC}" \
    -DCOLOR_BLACK="${COLOR_BLACK}" \
    -DCOLOR_RED="${COLOR_RED}" \
    -DCOLOR_GREEN="${COLOR_GREEN}" \
    -DCOLOR_YELLOW="${COLOR_YELLOW}" \
    -DCOLOR_BLUE="${COLOR_BLUE}" \
    -DCOLOR_MAGENTA="${COLOR_MAGENTA}" \
    -DCOLOR_CYAN="${COLOR_CYAN}" \
    -DCOLOR_WHITE="${COLOR_WHITE}" \
    -DCOLOR_BRIGHT_BLACK="${COLOR_BRIGHT_BLACK}" \
    -DCOLOR_BRIGHT_RED="${COLOR_BRIGHT_RED}" \
    -DCOLOR_BRIGHT_GREEN="${COLOR_BRIGHT_GREEN}" \
    -DCOLOR_BRIGHT_YELLOW="${COLOR_BRIGHT_YELLOW}" \
    -DCOLOR_BRIGHT_BLUE="${COLOR_BRIGHT_BLUE}" \
    -DCOLOR_BRIGHT_MAGENTA="${COLOR_BRIGHT_MAGENTA}" \
    -DCOLOR_BRIGHT_CYAN="${COLOR_BRIGHT_CYAN}" \
    -DCOLOR_BRIGHT_WHITE="${COLOR_BRIGHT_WHITE}" \
    -DCOLOR_TRANSPARENT="${COLOR_TRANSPARENT}" \
    -DCOLOR_BACKGROUND="${THEME_BACKGROUND}" \
    -DCOLOR_BACKGROUND_ALT="${THEME_BACKGROUND_DARK}" \
    -DCOLOR_BACKGROUND_TRANSPARENT="${COLOR_BACKGROUND_TRANSPARENT}" \
    -DCOLOR_FOREGROUND="${COLOR_FOREGROUND}" \
    -DCOLOR_FOREGROUND_ALT="${COLOR_FOREGROUND_ALT}" \
    -DCOLOR_HIGHLIGHT="${COLOR_HIGHLIGHT}" \
    -DCOLOR_HIGHLIGHT_ALT="${COLOR_HIGHLIGHT_ALT}" \
    -DCOLOR_INDICATOR="${COLOR_INDICATOR}" \
    -DCOLOR_URGENT="${COLOR_URGENT}" \
    -DCOLOR_BORDER="${COLOR_BORDER}" \
    -merge ${HOME}/.Xresources