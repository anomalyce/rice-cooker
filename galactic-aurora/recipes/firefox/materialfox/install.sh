#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading git repository"
git clone git@github.com:muckSponge/MaterialFox.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Attempting to switch to the beta branch"
cd ${RECIPE_CACHE_DIR} && git checkout beta

if [ -d "${RECIPE_DIST_DIR}/materialfox" ]; then
    rm -r ${RECIPE_DIST_DIR}/materialfox
fi

if [ -d "${RECIPE_DIST_DIR}/materialfox-twitter" ]; then
    rm -r ${RECIPE_DIST_DIR}/materialfox-twitter
fi

mkdir ${RECIPE_DIST_DIR}

rice_cooker_debug "Migrating out of cache"
cp -r ${RECIPE_CACHE_DIR}/chrome ${RECIPE_DIST_DIR}/materialfox

rice_cooker_debug "Importing the new content CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/materialfox/content/newtab.css"
echo "${RICE_COOKER_OUTPUT}" >> "${RECIPE_DIST_DIR}/materialfox/userContent.css"

rice_cooker_debug "Replacing darkmode variables"
rice_cooker_substitute_env "${RECIPE_DIR}/materialfox/chrome/variables.css"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/materialfox/global/rice-cooker.css

rice_cooker_debug "Appending the stop-white-flash CSS"
cat "${RECIPE_DIR}/materialfox/chrome/whiteflash.css" >> ${RECIPE_DIST_DIR}/materialfox/global/rice-cooker.css

rice_cooker_debug "Appending the indicators CSS"
cat "${RECIPE_DIR}/stubs/indicators.css" >> ${RECIPE_DIST_DIR}/materialfox/global/rice-cooker.css



rice_cooker_debug "Duplicating materialfox for twitter"
cp -r ${RECIPE_DIST_DIR}/materialfox ${RECIPE_DIST_DIR}/materialfox-twitter

rice_cooker_debug "Appending the tab-bar CSS to twitter"
cat "${RECIPE_DIR}/materialfox/chrome/tabbar.css" >> ${RECIPE_DIST_DIR}/materialfox-twitter/global/rice-cooker.css



declare -a userChromes=(
    "${RECIPE_DIST_DIR}/materialfox/userChrome.css"
    "${RECIPE_DIST_DIR}/materialfox-twitter/userChrome.css"
)

rice_cooker_debug "Importing the new chrome CSS"
for userChrome in "${userChromes[@]}"
do
    if ! grep -q "rice-cooker" "${userChrome}"; then
        sed -i 's/@import "global\/variables.css";/@import "global\/variables.css";\n@import "global\/rice-cooker.css";/' "${userChrome}"
    fi
done

exit 0
