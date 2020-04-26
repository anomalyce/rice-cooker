#!/bin/bash

if ! [ -x "$(command -v beautifuldiscord)" ]; then
    rice_cooker_skip "beautifuldiscord is not installed, skipping recipe..."
fi

rice_cooker_substitute_env "${RECIPE_DIR}/stubs/styles.css"

rice_cooker_debug "Applying custom CSS from styles.css"
mkdir -p ${RECIPE_DIST_DIR}
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/discord.css

rice_cooker_debug "Removing all previously added CSS"
beautifuldiscord --revert

rice_cooker_debug "Applying CSS through BeautifulDiscord"
beautifuldiscord --css ${RECIPE_DIST_DIR}/discord.css

exit 0
