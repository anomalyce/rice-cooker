#!/usr/bin/env bash

if ! [ -x "$(command -v subl)" ]; then
    rice_cooker_skip "Sublime Text is not installed, skipping recipe..."
fi

( source ${RECIPE_DIR}/nord/install.sh )
( source ${RECIPE_DIR}/material-theme/install.sh )

rice_cooker_instruction "Run the following and click on Sublime Text in order to prevent Sublime Text from becoming invisible due to the use of a compositor (e.g. picom/compton)"
rice_cooker_manual_code 'xprop -f _NET_WM_STATE 32a -set _NET_WM_STATE ""'

exit 0
