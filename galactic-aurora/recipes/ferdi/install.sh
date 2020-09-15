#!/usr/bin/env bash

if ! [ -x "$(command -v ferdi)" ]; then
    rice_cooker_skip "Ferdi is not installed, skipping recipe..."
fi

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading git repository"
git clone git@github.com:vednoc/dark-whatsapp.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Attempting to switch to the develop branch"
cd ${RECIPE_CACHE_DIR} && git checkout develop

rice_cooker_debug "Converting theme userstyle"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/userstyle.styl"
echo "${RICE_COOKER_OUTPUT}" >> "${RECIPE_CACHE_DIR}/rice-cooker.styl"

rice_cooker_debug "Converting stylus to regular CSS"
${RECIPE_DIR}/scripts/convert-stylus-to-css.sh "${RECIPE_CACHE_DIR}"

rice_cooker_debug "Granting execute permission to shell script"
chmod +x ${RECIPE_CACHE_DIR}/whatsapp.sh

cd ${RECIPE_CACHE_DIR}

rice_cooker_debug "Running shell script"
${RECIPE_CACHE_DIR}/whatsapp.sh -f

rice_cooker_debug "Applying custom CSS from styles.css"
cat ${RECIPE_DIR}/stubs/styles.css >> ${RECIPE_CACHE_DIR}/darkmode.css

rice_cooker_debug "Applying custom variables"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/variables.css"
perl -pi -e "s/html \> body \{/${RICE_COOKER_OUTPUT}\nhtml \> body \{/s" "${RECIPE_CACHE_DIR}/darkmode.css"

rice_cooker_debug "Migrating out of cache"
mkdir -p ${RECIPE_DIST_DIR}
cp ${RECIPE_CACHE_DIR}/darkmode.css ${RECIPE_DIST_DIR}/darkmode.css

rice_cooker_debug "Creating symlinks for Ferdi"
mkdir -p ${RECIPE_CONFIG_DIR}
ln -sf ${RECIPE_DIST_DIR}/darkmode.css ${RECIPE_CONFIG_DIR}/darkmode.css

exit 0
