#!/usr/bin/env bash

if ! [ -x "$(command -v i3-msg)" ]; then
    rice_cooker_skip "i3wm is not installed, skipping recipe..."
fi

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_debug "Publishing the scripts"
cp -r "${RECIPE_DIR}/scripts" "${RECIPE_DIST_DIR}/scripts"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/scripts/screenlayout.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/scripts/screenlayout.sh"

rice_cooker_debug "Publishing the workspaces"
cp -r "${RECIPE_DIR}/workspaces" "${RECIPE_DIST_DIR}/workspaces"

rice_cooker_debug "Publishing the config file"
cp "${RECIPE_DIR}/stubs/config" "${RECIPE_DIST_DIR}/config"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/config"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/config"

exit 0
