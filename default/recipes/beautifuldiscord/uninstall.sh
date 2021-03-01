#!/usr/bin/env bash

if [ -d ${RECIPE_DIST_DIR} ]; then
    rice_cooker_debug "Removing dist directory"
    rm -r ${RECIPE_DIST_DIR}
fi

rice_cooker_debug "Removing CSS through BeautifulDiscord"
beautifuldiscord --revert

exit 0
