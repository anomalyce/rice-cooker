#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading GitHub-Dark repository"
git clone git@github.com:StylishThemes/GitHub-Dark.git ${RECIPE_CACHE_DIR}

if [ -d "${RECIPE_DIST_DIR}/github-dark" ]; then
    rm -r ${RECIPE_DIST_DIR}/github-dark
fi

mkdir ${RECIPE_DIST_DIR}/github-dark

rice_cooker_debug "Installing dependencies"
cd ${RECIPE_CACHE_DIR}
make deps

rice_cooker_debug "Compiling"
cd ${RECIPE_CACHE_DIR}
make build

rice_cooker_debug "Appending custom CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/github-dark/stubs/style.css"
echo "${RICE_COOKER_OUTPUT}" >> ${RECIPE_CACHE_DIR}/github-dark.user.css

rice_cooker_debug "Installing userstyle"
cd ${RECIPE_CACHE_DIR}
make install

rice_cooker_debug "Migrating out of cache"
cp -r ${RECIPE_CACHE_DIR}/github-dark.user.css ${RECIPE_DIST_DIR}/github-dark.user.css
