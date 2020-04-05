#!/bin/bash

if ! [ -x "$(command -v subl3)" ]; then
    rice_cooker_skip "Sublime Text 3 is not installed, skipping recipe..."
fi

( source ${RECIPE_DIR}/nord/install.sh )
( source ${RECIPE_DIR}/material-theme/install.sh )

exit 0
