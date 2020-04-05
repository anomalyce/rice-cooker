#!/bin/bash

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_debug "Installing XRDB script"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/xrdb.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/xrdb.sh"

rice_cooker_debug "Creating symlinks for XRDB"
ln -sf "${RECIPE_DIST_DIR}/xrdb.sh" "${X11_RECIPE_DIR}/xrdb.sh"

exit 0
