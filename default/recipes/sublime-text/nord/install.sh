#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading Nord colour scheme git repository"
git clone git@github.com:arcticicestudio/nord-sublime-text.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Migrating Nord colour scheme out of cache"
mkdir -p ${RECIPE_DIST_DIR}
cp ${RECIPE_CACHE_DIR}/Nord.sublime-color-scheme ${RECIPE_DIST_DIR}/Nord.sublime-color-scheme

rice_cooker_debug "Replacing the Nord colour scheme's background colour"
sed -i -r "s/\"nord0\": \"#.{3,6}\"/\"nord0\": \"${THEME_BACKGROUND}\"/g" ${RECIPE_DIST_DIR}/Nord.sublime-color-scheme

rice_cooker_debug "Creating symlinks for the Nord colour scheme"
ln -sf ${RECIPE_DIST_DIR}/Nord.sublime-color-scheme ${HOME}/.config/sublime-text-3/Packages/User/Nord.sublime-color-scheme

exit 0
