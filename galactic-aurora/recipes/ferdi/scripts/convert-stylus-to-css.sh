#!/usr/bin/env bash

RECIPE_CACHE_DIR="${1}"

cp "${RECIPE_CACHE_DIR}/wa.user.styl" "${RECIPE_CACHE_DIR}/wa.user.styl.tmp"

USERSTYLE_START="\/\* ==UserStyle=="
USERSTYLE_END="==\/UserStyle== \*\/"
USERSTYLE=$(cat "${RECIPE_CACHE_DIR}/rice-cooker.styl")

perl -0777 -pi -e "s/${USERSTYLE_START}(.*)${USERSTYLE_END}//s" "${RECIPE_CACHE_DIR}/wa.user.styl.tmp"
echo -e "${USERSTYLE} $(cat "${RECIPE_CACHE_DIR}/wa.user.styl.tmp")" > "${RECIPE_CACHE_DIR}/wa.user.styl.tmp"

stylus "${RECIPE_CACHE_DIR}/wa.user.styl.tmp" -o "${RECIPE_CACHE_DIR}/wa.user.css"
