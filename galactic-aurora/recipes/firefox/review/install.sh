#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading git repository"
git clone git@github.com:fellowish/firefox-review.git ${RECIPE_CACHE_DIR}

if [ -d "${RECIPE_DIST_DIR}/review" ]; then
    rm -r ${RECIPE_DIST_DIR}/review
fi

if [ -d "${RECIPE_DIST_DIR}/review-twitter" ]; then
    rm -r ${RECIPE_DIST_DIR}/review-twitter
fi

mkdir ${RECIPE_DIST_DIR}

rice_cooker_debug "Migrating out of cache"
cp -r ${RECIPE_CACHE_DIR} ${RECIPE_DIST_DIR}/review

rice_cooker_debug "Importing the new content CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/global/content/newtab.css"
echo "${RICE_COOKER_OUTPUT}" >> "${RECIPE_DIST_DIR}/review/userContent.css"

rice_cooker_debug "Replacing darkmode variables"
rice_cooker_substitute_env "${RECIPE_DIR}/review/variables.css"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/review/rice-cooker.css

rice_cooker_debug "Appending the stop-white-flash CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/global/chrome/whiteflash.css"
echo "${RICE_COOKER_OUTPUT}" >> ${RECIPE_DIST_DIR}/review/userChrome.css

rice_cooker_debug "Appending the indicators CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/global/chrome/indicators.css"
echo "${RICE_COOKER_OUTPUT}" >> ${RECIPE_DIST_DIR}/review/userChrome.css

rice_cooker_debug "Appending the bookmarks bar CSS"
rice_cooker_substitute_env "${RECIPE_DIR}/global/chrome/bookmarksbar.css"
echo "${RICE_COOKER_OUTPUT}" >> ${RECIPE_DIST_DIR}/review/userChrome.css



rice_cooker_debug "Duplicating review for twitter"
cp -r ${RECIPE_DIST_DIR}/review ${RECIPE_DIST_DIR}/review-twitter

rice_cooker_debug "Appending the tab-bar CSS to twitter"
rice_cooker_substitute_env "${RECIPE_DIR}/global/chrome/tabbar.css"
echo "${RICE_COOKER_OUTPUT}" >> ${RECIPE_DIST_DIR}/review-twitter/userChrome.css



declare -a userChromes=(
    "${RECIPE_DIST_DIR}/review/userChrome.css"
    "${RECIPE_DIST_DIR}/review/userContent.css"
    "${RECIPE_DIST_DIR}/review-twitter/userChrome.css"
    "${RECIPE_DIST_DIR}/review-twitter/userContent.css"
)

rice_cooker_debug "Importing the new chrome CSS"
for userChrome in "${userChromes[@]}"
do
    if ! grep -q "rice-cooker" "${userChrome}"; then
        sed -i 's/@import "userColors.css";/@import "userColors.css";\n@import "rice-cooker.css";/' "${userChrome}"
    fi

    # Remove the custom firefox background colour stuff
    perl -0777 -pi -e 's/FIREFOX BG COLOR(.*)SEARCH BAR/SEARCH BAR/s' "${userChrome}"
done

exit 0
