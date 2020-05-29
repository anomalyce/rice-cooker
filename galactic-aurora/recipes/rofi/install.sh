#!/usr/bin/env bash

if ! [ -x "$(command -v rofi)" ]; then
    rice_cooker_skip "rofi is not installed, skipping recipe..."
fi

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_debug "Substituting environment variables for colours"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/colours.sh"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/colours.sh

rice_cooker_debug "Publishing projects.sh"
cat "${RECIPE_DIR}/scripts/projects.sh" > ${RECIPE_DIST_DIR}/projects.sh
chmod +x ${RECIPE_DIST_DIR}/projects.sh

rice_cooker_debug "Publishing system.sh"
cat "${RECIPE_DIR}/scripts/system.sh" > ${RECIPE_DIST_DIR}/system.sh
chmod +x ${RECIPE_DIST_DIR}/system.sh

rice_cooker_debug "Publishing windows.sh"
cat "${RECIPE_DIR}/scripts/windows.sh" > ${RECIPE_DIST_DIR}/windows.sh
chmod +x ${RECIPE_DIST_DIR}/windows.sh

rice_cooker_debug "Publishing applications.sh"
cat "${RECIPE_DIR}/scripts/applications.sh" > ${RECIPE_DIST_DIR}/applications.sh
chmod +x ${RECIPE_DIST_DIR}/applications.sh

rice_cooker_debug "Publishing calculator.sh"
cat "${RECIPE_DIR}/scripts/calculator.sh" > ${RECIPE_DIST_DIR}/calculator.sh
chmod +x ${RECIPE_DIST_DIR}/calculator.sh

exit 0
