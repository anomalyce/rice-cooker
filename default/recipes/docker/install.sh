#!/usr/bin/env bash

if ! [ -x "$(command -v docker)" ]; then
    rice_cooker_skip "Docker is not installed, skipping recipe..."
fi

rice_cooker_debug "Publishing the docker scripts"
cp -r "${RECIPE_DIR}/scripts" "${RECIPE_DIST_DIR}"

rice_cooker_debug "Making sure the docker scripts are executable"
for FILENAME in "${RECIPE_DIST_DIR}"/*; do
    if [ -f "${FILENAME}" ]; then
        chmod +x "${FILENAME}"
    fi
done

rice_cooker_instruction "Add the following snippet to your shell profile file"
rice_cooker_manual_code 'export PATH="${RECIPE_DIST_DIR}:${PATH}"'
