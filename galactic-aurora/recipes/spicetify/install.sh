#!/bin/bash

if ! [ -x "$(command -v spicetify)" ]; then
    rice_cooker_skip "spicetify is not installed, skipping recipe..."
fi

rice_cooker_substitute_env "${RECIPE_DIR}/stubs/color.ini"

rice_cooker_debug "Substituting environment variables"
mkdir -p ${RECIPE_DIST_DIR}
cat "${RECIPE_DIR}/stubs/user.css" > ${RECIPE_DIST_DIR}/user.css
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/color.ini

rice_cooker_debug "Stripping hashtags from HEX colour codes"
sed -i -e 's/\#//g' ${RECIPE_DIST_DIR}/color.ini

rice_cooker_debug "Creating symlinks for Spicetify"
ln -sf ${RECIPE_DIST_DIR} "${SPICETIFY_RECIPE_DIR}/Themes/rice-cooker"

rice_cooker_debug "Updating active Spicetify theme"
sed -i 's/current_theme.*= .*/current_theme = "rice-cooker"/' ${SPICETIFY_RECIPE_DIR}/config.ini

rice_cooker_debug "Applying CSS through Spicetify"
spicetify apply

exit 0
