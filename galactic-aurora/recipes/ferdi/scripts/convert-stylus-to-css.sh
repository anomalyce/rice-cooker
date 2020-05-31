#!/usr/bin/env bash

RECIPE_CACHE_DIR="${1}"

cp "${RECIPE_CACHE_DIR}/wa.user.styl" "${RECIPE_CACHE_DIR}/wa.user.styl.tmp"

USERSTYLE_START="/* ==UserStyle=="
USERSTYLE_END="==/UserStyle== */"

stylus "${RECIPE_CACHE_DIR}/wa.user.styl.tmp" -o "${RECIPE_CACHE_DIR}/wa.user.css"
