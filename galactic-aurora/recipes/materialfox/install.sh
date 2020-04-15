#!/bin/bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading git repository"
git clone git@github.com:muckSponge/MaterialFox.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Attempting to switch to the beta branch"
cd ${RECIPE_CACHE_DIR} && git checkout beta

if [ -d "${RECIPE_DIST_DIR}" ]; then
    rm -r ${RECIPE_DIST_DIR}
fi

rice_cooker_debug "Migrating out of cache"
cp -r ${RECIPE_CACHE_DIR}/chrome ${RECIPE_DIST_DIR}

rice_cooker_debug "Replacing darkmode variables"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/variables.css"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/global/rice-cooker.css

if ! grep -q "rice-cooker" "${RECIPE_DIST_DIR}/userChrome.css"; then
    rice_cooker_debug "Importing the new variables"
    sed -i 's/@import "global\/variables.css";/@import "global\/variables.css";\n@import "global\/rice-cooker.css";/' "${RECIPE_DIST_DIR}/userChrome.css"
fi

exit 0
