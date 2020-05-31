#!/usr/bin/env bash

set -e

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
OUTPUTLOG="/tmp/polybar-outputlog"

SUCCESS="\e[32m"
ERROR="\e[31m"
WARNING="\e[33m"
INFO="\e[34m"
RESET="\e[39m"
NORMAL="${RESET}"


#
# Get the cache directory path.
#
function get_cache_dir {
    if [ ! -z "${XDG_CACHE_HOME}" ]; then
        local BASEPATH="${XDG_CACHE_HOME}"
    else
        local BASEPATH="${HOME}/.cache"
    fi

    echo "${BASEPATH}/qemu-control"
}

#
# Get the path to a specific cache file.
#
function get_cache_file {
    local CACHEDIR="$(get_cache_dir)"
    local FILE="${1}"
    local DIRNAME="$(dirname "${FILE}")"

    if [[ "${DIRNAME}" != "." && ! -d "${CACHEDIR}/${DIRNAME}" ]]; then
        mkdir -p "${CACHEDIR}/${DIRNAME}"
    fi

    if [ ! -f "${CACHEDIR}/${FILE}" ]; then
        touch "${CACHEDIR}/${FILE}"
    fi

    echo "${CACHEDIR}/${FILE}"
}

#
# Get the contents of a specific cache file.
#
function get_cache_file_contents {
    local FILE="${1}"

    cat "$(get_cache_file "${FILE}")"
}

#
# Set the contents of a specific cache file.
#
function set_cache_file_contents {
    local FILE="${1}"
    local CONTENTS="${2}"

    echo "${CONTENTS}" > "$(get_cache_file "${FILE}")"
}

#
# Log a message to the polybar output file.
#
function log_to_polybar {
    local MESSAGE="${1}"
    local TYPE="${2}"
    local WAIT="${3:-1}"

    if [ ! -f "${OUTPUTLOG}" ]; then
        touch "${OUTPUTLOG}"
    fi

    sleep "${WAIT}"

    if [[ ! -z "${TYPE}" && "${TYPE}" != "" ]]; then
        echo "[${TYPE}] ${MESSAGE}" > "${OUTPUTLOG}"
    else
        echo "" > "${OUTPUTLOG}"
    fi
}

#
# Write an action message.
#
function log_action {
    local MESSAGE="${1}"
    local COLOUR="${2:-${NORMAL}}"

    log_to_polybar "${MESSAGE}" "action"

    echo -e "${COLOUR}${MESSAGE}${RESET}"
}

#
# Write an informational message.
#
function log_info {
    local MESSAGE="${1}"
    local COLOUR="${2:-${INFO}}"

    log_to_polybar "${MESSAGE}" "info"

    echo -e "  └ ${COLOUR}${MESSAGE}${RESET}"
}

#
# Write a warning message.
#
function log_warning {
    local MESSAGE="${1}"
    local COLOUR="${2:-${WARNING}}"

    log_to_polybar "${MESSAGE}" "warning"

    echo -e "  └ ${COLOUR}${MESSAGE}${RESET}"
}

#
# Write an error message.
#
function log_error {
    local MESSAGE="${1}"
    local COLOUR="${2:-${ERROR}}"

    log_to_polybar "${MESSAGE}" "error"

    echo -e "${COLOUR}${MESSAGE}${RESET}"
}

#
# Write a successful message.
#
function log_success {
    local MESSAGE="${1}"
    local COLOUR="${2:-${SUCCESS}}"

    log_to_polybar "${MESSAGE}" "success"

    echo -e "  └ ${COLOUR}${MESSAGE}${RESET}"
}

#
# Run a process.
#
function start_process {
    local PROCESS="process/${1}"

    if [[ "${PROCESS}" == process/\@* ]]; then
        local PROCESS="$(echo ${PROCESS//\@/})"

        log_info "Passing through start event for process <${PROCESS}>..."
        eval "${PROCESS} start"
        return
    fi

    if [ "$(type -t ${PROCESS})" != "function" ]; then
        log_warning "Process <${PROCESS}> not found, skipping start event..."
        return
    fi

    local COMMAND="$("${PROCESS}")"

    if pgrep -fx "${COMMAND}" > /dev/null
    then
        log_warning "Process <${PROCESS}> already running, skipping start event..."
        return
    fi
    
    eval "${COMMAND} &"
    log_success "Process <${PROCESS}> started."
}

#
# Kill a process.
#
function stop_process {
    local PROCESS="process/${1}"

    if [[ "${PROCESS}" == process/\@* ]]; then
        local PROCESS="$(echo ${PROCESS//\@/})"

        log_info "Passing through stop event for process <${PROCESS}>..."
        eval "${PROCESS} stop"
        return
    fi

    if [ "$(type -t ${PROCESS})" != "function" ]; then
        log_warning "Process <${PROCESS}> not found, skipping stop event..."
        return
    fi

    local COMMAND="$("${PROCESS}")"

    if ! pgrep -fx "${COMMAND}" > /dev/null
    then
        log_warning "Process <${PROCESS}> not running, skipping stop event..."
        return
    fi

    pkill -fx "${COMMAND}"
    log_success "Process <${PROCESS}> stopped."
}

#
# Register a hook.
#
function add_hook {
    local HOOKPATH="/etc/libvirt/hooks/qemu.d/${VM}"
    local FILE="${SCRIPTPATH}/qemu-hooks/${1}"
    local HOOK="${2}"

    if [ -L "${HOOKPATH}/${HOOK}" ] && [ -e "${HOOKPATH}/${HOOK}" ]; then
        log_warning "Hook <${HOOK}> already exists, skipping..."
        return
    fi

    ln -s "${FILE}" "${HOOKPATH}/${HOOK}"
    log_success "Hook <${HOOK}> created."
}

#
# Unregister a hook.
#
function remove_hook {
    local HOOKPATH="/etc/libvirt/hooks/qemu.d/${VM}"
    local HOOK="${1}"

    if [ ! -L "${HOOKPATH}/${HOOK}" ] && ! [ -e "${HOOKPATH}/${HOOK}" ]; then
        log_warning "Hook <${HOOK}> not found, skipping..."
        return
    fi

    rm "${HOOKPATH}/${HOOK}"
    log_success "Hook <${HOOK}> removed."
}

#
# Get the status of a virsh domain.
#
function get_virsh_domain_status {
    local DOMAIN="${1}"
    local STATUS="$(virsh list --all | grep " ${DOMAIN} " | awk '{ print $3}')"

    if ([ "x${STATUS}" == "x" ] || [ "x${STATUS}" != "xrunning" ])
    then
        echo "down"
    else
        echo "up"
    fi
}

#
#
#
function await_virsh_domain_status {
    local VM="${1}"
    local EXPECTED_STATUS="${2}"
    local OPPOSITE_STATUS=$([ "${EXPECTED_STATUS}" == "up" ] && echo "down" || echo "up")
    local EXPECTED_STATUS_LABEL=$([ "${EXPECTED_STATUS}" == "up" ] && echo "boot up" || echo "shut down")
    local MAX_ATTEMPTS="${3:-60}"

    local ATTEMPT=0
    local STATUS="$(get_virsh_domain_status "${VM}")"
    while ([ "${STATUS}" == "${OPPOSITE_STATUS}" ]); do
        if [ "${ATTEMPT}" == "${MAX_ATTEMPTS}" ]; then
            break
        fi

        ATTEMPT=$((ATTEMPT+1))
        sleep 1

        STATUS="$(get_virsh_domain_status "${VM}")"
        log_info "Awaiting virsh domain <${VM}> to ${EXPECTED_STATUS_LABEL} (attempt #${ATTEMPT})..."
    done;
}





# v ------------------ Domain Configuration ------------------ v #

#
# Booting with Monitor
#
function boot/monitor {
    add_hook "switch_displays.sh" "started/begin/20_switch_displays.sh"
    add_hook "switch_displays.sh" "stopped/end/10_switch_displays.sh"
    add_hook "switch_screenlayout.sh" "started/begin/10_switch_screenlayout.sh"
    add_hook "switch_screenlayout.sh" "stopped/end/20_switch_screenlayout.sh"

    start_process "@virsh"
    start_process "scream"
    # start_process "barrier"
}

#
# Shutting down with Monitor
#
function shutdown/monitor {
    stop_process "@virsh"
    stop_process "scream"
    # stop_process "barrier"

    remove_hook "started/begin/20_switch_displays.sh"
    remove_hook "stopped/end/10_switch_displays.sh"
    remove_hook "started/begin/10_switch_screenlayout.sh"
    remove_hook "stopped/end/20_switch_screenlayout.sh"
}

#
# Booting with Looking Glass
#
function boot/lookingglass {
    start_process "@virsh"
    start_process "scream"
    start_process "lookingglass"
}

#
# Shutting down with Looking Glass
#
function shutdown/lookingglass {
    stop_process "@virsh"
    stop_process "scream"
    stop_process "lookingglass"
}

#
# Virsh process.
#
function process/virsh {
    local ACTION="${1}"
    local STATUS="$(get_virsh_domain_status "${VM}")"

    if [ "${ACTION}" == "start" ]; then
        if [ "${STATUS}" == "up" ]; then
            log_warning "Process <${FUNCNAME[0]}> already running, skipping start event..."
            return
        fi

        virsh start "${VM}"
        log_success "Process <${FUNCNAME[0]}> started."

        await_virsh_domain_status "${VM}" "up" "60"
        return
    fi

    if [ "${ACTION}" == "stop" ]; then
        if [ "${STATUS}" == "down" ]; then
            log_warning "Process <${FUNCNAME[0]}> not running, skipping stop event..."
            return
        fi

        virsh shutdown "${VM}"
        log_success "Process <${FUNCNAME[0]}> stopped."

        await_virsh_domain_status "${VM}" "down" "60"
        return
    fi
}

#
# Looking Glass process.
#
function process/lookingglass {
    echo "looking-glass-client -K 120 -m 281 -g OpenGL -o input:grabKeyboard=0 -o win:size=1920x1080 -o opengl:vsync=1 >/dev/null 2>&1"
}

#
# Scream process.
#
function process/scream {
    echo "/usr/bin/scream -o pulse -i libvirt0"
}

#
# Barrier process.
#
function process/barrier {
    echo "/usr/bin/barrierc --enable-crypto --name linux 192.168.1.76:24800"
}





# v ------------------ Execution ------------------ v #

VM="${1}"
ACTION="${2}"
FALLBACK_TYPE="$(get_cache_file_contents "state")"
TYPE=$([ ! -z "${3}" ] && echo "${3}" || echo "${FALLBACK_TYPE}")
COMMAND="${ACTION}/${TYPE}"

# Exit out early in case we can't detect the action type.
if [ -z "${TYPE}" ]; then
    log_error "Cannot identify action type, exiting..."
    exit 100
fi

# If the action is run/kill fake the command to execute a process.
if [[ "${ACTION}" == "run" || "${ACTION}" == "kill" ]]; then
    COMMAND="process/${TYPE}"
fi

# Exit out early if there isn't an appropriate action type function to call.
if [ "$(type -t ${COMMAND})" != "function" ]; then
    log_error "Cannot find <${COMMAND}> lifecycle hook, exiting..."
    exit 101
fi

# Update the state depending on the action.
if [ "${ACTION}" == "boot" ]; then
    if [ ! -z "${FALLBACK_TYPE}" ]; then
        STATUS="$(get_virsh_domain_status "${VM}")"

        if [ "${STATUS}" == "up" ]; then
            log_warning "Virtual machine is running, skipping residual cleanup..."
        else
            log_action "Cleaning up residue from previous boot, running <shutdown/${FALLBACK_TYPE}>"
            "shutdown/${FALLBACK_TYPE}" &>/dev/null
            log_success "Residual cleanup successful!"
        fi
    fi

    set_cache_file_contents "state" "${TYPE}"
elif [ "${ACTION}" == "shutdown" ]; then
    set_cache_file_contents "state" ""
fi

# Execute the action type function.
log_action "Running action <${COMMAND}>"

if [ "${ACTION}" == "run" ]; then
    start_process "${TYPE}"
elif [ "${ACTION}" == "kill" ]; then
    stop_process "${TYPE}"
else
    "${COMMAND}"
fi

log_action "Successfully ran action <${COMMAND}>!" "${SUCCESS}"

log_to_polybar "" "" 5

exit 0
