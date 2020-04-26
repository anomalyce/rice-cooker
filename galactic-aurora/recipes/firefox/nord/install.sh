#!/bin/bash

# Download manually and unzip into src directory
# https://www.deviantart.com/dpcdpc11/art/Nord-for-Firefox-837860916

rice_cooker_recipe_cache_dir

if [ -d "${RECIPE_DIST_DIR}/nord" ]; then
    rm -r ${RECIPE_DIST_DIR}/nord
fi

mkdir -p ${RECIPE_DIST_DIR}/nord

rice_cooker_debug "Publishing the stylesheets"
cp "${RECIPE_DIR}/nord/src/userChrome.css" ${RECIPE_DIST_DIR}/nord/userChrome.css
cp "${RECIPE_DIR}/nord/src/userContent.css" ${RECIPE_DIST_DIR}/nord/userContent.css

rice_cooker_debug "Replacing darkmode variables"
rice_cooker_substitute_env "${RECIPE_DIR}/nord/stubs/variables.css"
echo "${RICE_COOKER_OUTPUT}" > ${RECIPE_DIST_DIR}/nord/rice-cooker.css

rice_cooker_debug "Appending the indicators CSS"
cat "${RECIPE_DIR}/stubs/indicators.css" >> ${RECIPE_DIST_DIR}/nord/rice-cooker.css

if ! grep -q "rice-cooker" "${RECIPE_DIST_DIR}/nord/userChrome.css"; then
    rice_cooker_debug "Importing the new CSS"

    echo -e "@import \"rice-cooker.css\";\n\n\n$(cat ${RECIPE_DIST_DIR}/nord/userChrome.css)" > ${RECIPE_DIST_DIR}/nord/userChrome.css
fi

exit 0
