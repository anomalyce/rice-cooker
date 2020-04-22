#!/bin/bash

if ! [ -x "$(command -v subl)" && -x "$(command -v subl3)" && -x "$(command -v subl4)" ]; then
    rice_cooker_skip "Sublime Text is not installed, skipping Sublime Text's theme compilation..."
fi

if [ ! -f "${RECIPE_CONFIG_DIR}/Installed Packages/PackageDev.sublime-package" ]; then
    rice_cooker_skip "PackageDev is not installed, skipping Sublime Text's theme compilation..."
fi

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading Material Theme git repository"
git clone git@github.com:equinusocio/material-theme.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Replacing the Material Theme variables"
rice_cooker_substitute_env "${RECIPE_DIR}/material-theme/stubs/scheme.json"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_CACHE_DIR}/sources/settings/specific/Material-Theme-${THEME_TITLE}.json"
cp "${RECIPE_DIR}/material-theme/stubs/theme.json" "${RECIPE_CACHE_DIR}/sources/themes/Material-Theme-${THEME_TITLE}.json"

cd ${RECIPE_CACHE_DIR}

if [ -f "${HOME}/.aliases" ]; then
    rice_cooker_debug "Loading global aliases from ~/.aliases"
    source ${HOME}/.aliases
fi

rice_cooker_debug "Installing NPM modules for Material Theme"
cat "${RECIPE_DIR}/material-theme/stubs/npm-shrinkwrap.json" > "${RECIPE_CACHE_DIR}/npm-shrinkwrap.json"
npm install

rice_cooker_debug "Compiling Material Theme"
${RECIPE_CACHE_DIR}/node_modules/.bin/gulp

rice_cooker_debug "Compiling Material Theme Scheme"
subl3 "${RECIPE_CACHE_DIR}/schemes/Material-Theme-${THEME_TITLE}.yml" && \
subl3 --command "packagedev_convert" && \
subl3 --command "hide_panel"

rice_cooker_debug "Sleeping for 5 seconds to allow the compilation to finish"
sleep 5

rice_cooker_debug "Migrating Material Theme out of cache"
mkdir -p ${RECIPE_DIST_DIR}
cat "${RECIPE_CACHE_DIR}/Material-Theme-${THEME_TITLE}.sublime-theme" > "${RECIPE_DIST_DIR}/Material-Theme-${THEME_TITLE}.sublime-theme"
cat "${RECIPE_CACHE_DIR}/schemes/Material-Theme-${THEME_TITLE}.tmTheme" > "${RECIPE_DIST_DIR}/Material-Theme-${THEME_TITLE}.tmTheme"

rice_cooker_debug "Creating symlinks for Material Theme"
ln -sf "${RECIPE_DIST_DIR}/Material-Theme-${THEME_TITLE}.sublime-theme" "${RECIPE_CONFIG_DIR}/Packages/User/Material-Theme-${THEME_TITLE}.sublime-theme"
ln -sf "${RECIPE_DIST_DIR}/Material-Theme-${THEME_TITLE}.tmTheme" "${RECIPE_CONFIG_DIR}/Packages/User/Material-Theme-${THEME_TITLE}.tmTheme"

exit 0
