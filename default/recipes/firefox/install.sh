#!/usr/bin/env bash

if ! [ -x "$(command -v firefox)" ]; then
    rice_cooker_skip "Firefox is not installed, skipping recipe..."
fi

# ( source ${RECIPE_DIR}/nord/install.sh )
# ( source ${RECIPE_DIR}/materialfox/install.sh )
( source ${RECIPE_DIR}/review/install.sh )

exit 0
