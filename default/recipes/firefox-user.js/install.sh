#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading user.js"
# wget -O ${RECIPE_CACHE_DIR}/user.js https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js
wget -O ${RECIPE_CACHE_DIR}/user.js https://raw.githubusercontent.com/arkenfox/user.js/master/user.js

mkdir -p ${RECIPE_DIST_DIR}

rice_cooker_debug "Compiling Twitter user.js"
cp ${RECIPE_CACHE_DIR}/user.js ${RECIPE_DIST_DIR}/twitter.js
cat ${RECIPE_DIR}/stubs/twitter.js >> ${RECIPE_DIST_DIR}/twitter.js

rice_cooker_debug "Compiling YouTube user.js"
cp ${RECIPE_CACHE_DIR}/user.js ${RECIPE_DIST_DIR}/youtube.js
cat ${RECIPE_DIR}/stubs/youtube.js >> ${RECIPE_DIST_DIR}/youtube.js

exit 0
