#/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

RICE_COOKER_DEBUG=1
export RICE_COOKER_DIR="${PWD}"

if [ ! -z "${XDG_DATA_HOME}" ]; then
    export RICE_COOKER_DIST="${XDG_DATA_HOME}/rice-cooker"
else
    export RICE_COOKER_DIST="${HOME}/.local/share/rice-cooker"
fi

mkdir -p "${RICE_COOKER_DIST}"

if [ ! -z "${XDG_CACHE_HOME}" ]; then
    export RICE_COOKER_CACHE="${XDG_CACHE_HOME}/rice-cooker"
else
    export RICE_COOKER_CACHE="${HOME}/.cache/rice-cooker"
fi

mkdir -p "${RICE_COOKER_CACHE}"

#
# Generate a random cache directory for temporary usage.
#
# @return string
#
function rice_cooker_recipe_cache_dir {
    local TMP_CACHE=$(uuidgen)

    rice_cooker_debug "Creating temporary cache directory <${TMP_CACHE}>"

    RECIPE_CACHE_DIR="${RICE_COOKER_CACHE}/${TMP_CACHE}"

    mkdir -p ${RECIPE_CACHE_DIR}
}

#
# Replace environment variables within a specific template.
#
# @param  string  FILEPATH
# @return string
#
function rice_cooker_substitute_env {
    local FILEPATH=$1

    # Use `${VAR}` or `$VAR` to replace variables with their actual values.
    RICE_COOKER_OUTPUT=$(envsubst < ${FILEPATH})

    # Use `@{VAR}` to prevent an existing variable to be replaced.
    RICE_COOKER_OUTPUT=$(echo "${RICE_COOKER_OUTPUT}" | sed -r 's/\@\{/\$\{/g')

    # Use `@[[VAR]]` to prevent an existing variable to be replaced.
    RICE_COOKER_OUTPUT=$(echo "${RICE_COOKER_OUTPUT}" | sed -r 's/\@\[\[(\w+)\]\]/\$\1/gi')
}

#
# Convert a HEX colour code into a RGB value.
#
# @param  string  HEX
# @return string
#
function rice_cooker_convert_hex_to_rgb {
    local HEX="$1"
    HEX=`echo ${HEX} | sed 's/#//g'`

    local R=`echo ${HEX} | sed 's/../0x&,/g' | awk -F "," '{print strtonum( $1 )}'`
    local G=`echo ${HEX} | sed 's/../0x&,/g' | awk -F "," '{print strtonum( $2 )}'`
    local B=`echo ${HEX} | sed 's/../0x&,/g' | awk -F "," '{print strtonum( $3 )}'`

    echo "${R}, ${G}, ${B}"
}

#
# Load the theme environment file, and convert any HEX colours
# to RGB by suffixing the variables with _RGB.
#
# @param  string  ENV
# @return void
#
function rice_cooker_load_theme_env {
    local ENV=$1

    local OLD_ENV=$(printenv)
    source $ENV
    local NEW_ENV=$(printenv)

    local ENV_DIFF=$(echo ${NEW_ENV[@]} ${OLD_ENV[@]} | tr ' ' '\n' | sort | uniq -u)

    while IFS= read -r ENV_ITEM; do
        local ENV_ITEM_KEY="${ENV_ITEM%%=*}"
        local ENV_ITEM_VALUE="${ENV_ITEM#*=}"

        if [[ "${ENV_ITEM_VALUE}" =~ ^#.* ]]; then
            local TMP_RGB_NAME="${ENV_ITEM_KEY}_RGB"
            local TMP_NOHASH_NAME="${ENV_ITEM_KEY}_NOHASH"
            local TMP_HEXDEC_NAME="${ENV_ITEM_KEY}_HEXDEC"

            declare -gx "${TMP_RGB_NAME}"="$(rice_cooker_convert_hex_to_rgb ${ENV_ITEM_VALUE})"
            declare -gx "${TMP_NOHASH_NAME}"="$(echo "${ENV_ITEM_VALUE}" | sed 's/#//g')"
            declare -gx "${TMP_HEXDEC_NAME}"="$(echo "0x${ENV_ITEM_VALUE}" | sed 's/#//g')"
        fi
    done <<< "${ENV_DIFF}"
}

#
# Kill a recipe off with an error message.
#
# @param  string  MESSAGE
# @return string
#
function rice_cooker_die {
    local MESSAGE=$1
    local FG="\033[1;37m"
    local RED="\033[0;31m"
    local RESET="\033[0m"

    echo -e "${FG}[${RED} !! ERROR !! ${FG}]: ${RED}${MESSAGE}${RESET}"
    exit 1
}

#
# Bypass a recipe with an warning message.
#
# @param  string  MESSAGE
# @return string
#
function rice_cooker_skip {
    local MESSAGE=$1
    local FG="\033[1;37m"
    local YELLOW="\033[0;33m"
    local RESET="\033[0m"

    echo -e "${FG}[${YELLOW} !! NOTICE !! ${FG}]: ${MESSAGE}${RESET}"
    exit 0
}

#
# Display a manual instruction for the user.
#
# @param  string  MESSAGE
# @return string
#
function rice_cooker_instruction {
    local MESSAGE=$1
}

#
# Display a manual code instruction for the user.
#
# @param  string  CODE
# @return string
#
function rice_cooker_manual_code {
    local CODE=$1
}

#
# Print a debug message.
#
# @param  string  MESSAGE
# @return string
#
function rice_cooker_debug {
    local MESSAGE=$1

    if [ "${RICE_COOKER_DEBUG}" != 1 ]; then
        return
    fi

    local FG="\033[1;37m"
    local CYAN="\033[0;96m"
    local PURPLE="\033[0;35m"
    local BLUE="\033[0;34m"
    local RESET="\033[0m"

    local OUTPUT="${FG}[${CYAN} Rice Cooker ${FG}]"

    if [ ! -z "$RICE_COOKER_RECIPE" ]; then
        local OUTPUT="${OUTPUT}${FG}[${BLUE} ${RICE_COOKER_RECIPE} ${FG}]"
    elif [ ! -z "$THEME" ]; then
        local OUTPUT="${OUTPUT}${FG}[${PURPLE} ${THEME} ${FG}]"
    fi

    echo -e "${OUTPUT}: ${MESSAGE}${RESET}"
}

#
# Clear out the compiled assets.
#
# @return void
#
function rice_cooker_clear_dist {
    if [ -d "${RICE_COOKER_DIST}" ]; then
        rice_cooker_debug "Deleting dist directory"
        rm -rf ${RICE_COOKER_DIST}
    fi

    rice_cooker_debug "Creating dist directory"
    mkdir -p ${RICE_COOKER_DIST}
}

#
# Clear out the cache.
#
# @return void
#
function rice_cooker_clear_cache {
    if [ -d "${RICE_COOKER_CACHE}" ]; then
        rice_cooker_debug "Deleting cache directory"
        rm -rf ${RICE_COOKER_CACHE}
    fi

    rice_cooker_debug "Creating cache directory"
    mkdir -p ${RICE_COOKER_CACHE}
}

#
# Install the given rice cooker theme.
#
# @param  string  THEME
# @return void
#
function rice_cooker_install {
    local THEME=$1
    local THEME_DIR="${RICE_COOKER_DIR}/${THEME}"
    local RECIPE_DIR="${THEME_DIR}/recipes"

    rice_cooker_clear_cache

    local FG="\033[1;37m"
    local PURPLE="\033[0;35m"
    local BLUE="\033[0;34m"
    local RESET="\033[0m"

    rice_cooker_debug "Installing theme ${PURPLE}${THEME}${FG}"

    # Source environment variables
    if [ -f "${THEME_DIR}/env" ]; then
        rice_cooker_debug "Setting up environment variables for theme ${PURPLE}${THEME}${FG}"

        # source "${THEME_DIR}/env"
        rice_cooker_load_theme_env "${THEME_DIR}/env"
    fi

    # Execute recipe installers
    for FILE in ${RECIPE_DIR}/*/install.sh; do
        local RECIPE_DIR=`dirname ${FILE}`
        local RECIPE=`basename ${RECIPE_DIR}`

        (
            if [ ! -z "${RC_RECIPES}" ]; then
                IFS=',' read -ra RECIPES_LIST <<< "${RC_RECIPES}"

                if [[ ! " ${RECIPES_LIST[@]} " =~ " ${RECIPE} " ]]; then
                    exit 0
                fi
            fi

            rice_cooker_debug "--------------------~< ${BLUE}${RECIPE}${FG} >~--------------------"

            local RICE_COOKER_RECIPE="${RECIPE}"
            local ENV="$(dirname ${FILE})/env"

            export RECIPE_DIST_DIR="${RICE_COOKER_DIST}/${RECIPE}"

            if [ -d "${RECIPE_DIST_DIR}" ]; then
                rm -rf "${RECIPE_DIST_DIR}"
            fi

            if [ -f "${ENV}" ]; then
                source "${ENV}"
            fi

            if [ -f "${FILE}" ]; then
                source "${FILE}"
            fi

            unset RECIPE_DIST_DIR
            unset RECIPE_CONFIG_DIR
        )

        EXIT_CODE=${PIPESTATUS[0]}

        if [ "${EXIT_CODE}" == "1" ]; then
            exit 1
        fi
    done
}

#
# Uninstall the given rice cooker theme.
#
# @param  string  THEME
# @return void
#
function rice_cooker_uninstall {
    local THEME=$1
    local THEME_DIR="${RICE_COOKER_DIR}/${THEME}"
    local RECIPE_DIR="${THEME_DIR}/recipes"

    rice_cooker_clear_dist
    rice_cooker_clear_cache

    rice_cooker_debug "Uninstalling theme <${THEME}>"

    # Execute recipe installers
    for file in ${RECIPE_DIR}/*/uninstall.sh; do
        local RECIPE=`basename $(dirname ${file})`
        if [ -f "${file}" ]; then
            rice_cooker_debug "-----"
            rice_cooker_debug "Running uninstall recipe <${RECIPE}> for theme <${THEME}>"
            
            source "${file}"
        fi
    done
}

while [ $# -gt 0 ]; do    
    case "${1}" in
        -h|--help)
            echo "This screen:"
            echo "  ./rice-cooker.sh --help"
            echo "  ./rice-cooker.sh -h"
            echo "-----"
            echo "Install theme using:"
            echo "  ./rice-cooker.sh --uninstall <theme>"
            echo "  ./rice-cooker.sh -u <theme>"
            echo "-----"
            echo "Install theme using:"
            echo "  ./rice-cooker.sh <theme>"
            exit 0
            ;;

        -u|--uninstall)
            rice_cooker_uninstall $2
            exit 0
            ;;

        *)
            rice_cooker_install $1
            exit 0
            ;;
    esac

    shift
done
