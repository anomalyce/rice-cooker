#!/usr/bin/env bash

if ! [ -x "$(command -v ferdi)" ]; then
    rice_cooker_skip "Ferdi is not installed, skipping recipe..."
fi

rice_cooker_recipe_cache_dir

rice_cooker_debug "Downloading git repository"
git clone git@github.com:vednoc/dark-whatsapp.git ${RECIPE_CACHE_DIR}

rice_cooker_debug "Replacing :root variables"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/variables.css"
SELECTOR="  @supports (-moz-user-select: none) {
    :root * {
      scrollbar-width: thin;
    }
  }"
# gawk -i inplace \
#     -v old="${SELECTOR}" \
#     -v new="\n${RICE_COOKER_OUTPUT}\n\n${SELECTOR}" \
#     'p=index($0, old) { print substr($0, 1, p-1) new substr($0, p+length(old)) }' \
#     ${RECIPE_CACHE_DIR}/wa.user.css

# gawk -i inplace \
gawk \
    -v old="${SELECTOR}" \
    -v new="\n${RICE_COOKER_OUTPUT}\n\n${SELECTOR}" \
    '{ gsub(old, new) }; { print }' \
    ${RECIPE_CACHE_DIR}/wa.user.css



rice_cooker_debug "Granting execute permission to shell script"
chmod +x ${RECIPE_CACHE_DIR}/whatsapp.sh

cd ${RECIPE_CACHE_DIR}

rice_cooker_debug "Running shell script"
${RECIPE_CACHE_DIR}/whatsapp.sh

rice_cooker_debug "Applying custom CSS from styles.css"
cat ${RECIPE_DIR}/stubs/styles.css >> ${RECIPE_CACHE_DIR}/darkmode.css

rice_cooker_debug "Migrating out of cache"
mkdir -p ${RECIPE_DIST_DIR}
cp ${RECIPE_CACHE_DIR}/darkmode.css ${RECIPE_DIST_DIR}/darkmode.css

rice_cooker_debug "Creating symlinks for Ferdi"
mkdir -p ${RECIPE_CONFIG_DIR}
ln -sf ${RECIPE_DIST_DIR}/darkmode.css ${RECIPE_CONFIG_DIR}/darkmode.css

exit 0
