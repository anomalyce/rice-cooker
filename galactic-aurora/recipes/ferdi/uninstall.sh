#!/usr/bin/env bash

if [ -f "${FERDI_RECIPE_DIR}/darkmode.css" ]; then
    rice_cooker_debug "Removing symlinks"
    rm ${FERDI_RECIPE_DIR}/darkmode.css
fi

if [ -d ${RECIPE_DIST_DIR} ]; then
    rice_cooker_debug "Removing dist directory"
    rm -r ${RECIPE_DIST_DIR}
fi

exit 0
