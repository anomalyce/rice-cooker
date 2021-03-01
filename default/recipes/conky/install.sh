#!/usr/bin/env bash

if ! [ -x "$(command -v conky)" ]; then
    rice_cooker_skip "conky is not installed, skipping recipe..."
fi

rice_cooker_debug "Migrating out of cache"
cp -r "${RECIPE_DIR}/stubs" "${RECIPE_DIST_DIR}"

rice_cooker_debug "Compiling conky configuration"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/conky.conf"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/conky.conf"

rice_cooker_debug "Compiling conky draw configuration"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/conky_draw_config.lua"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/conky_draw_config.lua"

rice_cooker_debug "Creating a duplicate conky installation for bottom alignment"
cp "${RECIPE_DIST_DIR}/conky.conf" "${RECIPE_DIST_DIR}/conky-bottom.conf"
sed -i 's/top_middle/bottom_middle/' "${RECIPE_DIST_DIR}/conky-bottom.conf"

rice_cooker_debug "Creating symlinks for Conky"
rm -r "${RECIPE_CONFIG_DIR}"
ln -sf "${RECIPE_DIST_DIR}" "${RECIPE_CONFIG_DIR}"

rice_cooker_debug "Reloading conky"
pkill conky 2> /dev/null
cd "${RECIPE_CONFIG_DIR}"
conky -c "${RECIPE_CONFIG_DIR}/conky.conf" --quiet &

exit 0
