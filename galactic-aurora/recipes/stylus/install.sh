#!/usr/bin/env bash

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_substitute_env "${RECIPE_DIR}/stubs/twitter.css"
rice_cooker_debug "Compiling Twitter userstyle"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/twitter.css

rice_cooker_substitute_env "${RECIPE_DIR}/stubs/youtube.css"
rice_cooker_debug "Compiling YouTube userstyle"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/youtube.css

exit 0
