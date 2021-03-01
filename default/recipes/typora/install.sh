#!/usr/bin/env bash

if ! [ -x "$(command -v typora)" ]; then
    rice_cooker_skip "Typora is not installed, skipping recipe..."
fi

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_debug "Publishing the ricecooker typora theme"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/ricecooker.css"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/ricecooker.css"

rice_cooker_debug "Activating the ricecooker theme"
rm "${RECIPE_THEMES_DIR}/ricecooker.css"
ln -s "${RECIPE_DIST_DIR}/ricecooker.css" "${RECIPE_THEMES_DIR}/ricecooker.css"

exit 0
