#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$BASH_SOURCE")`

PROFILE="/home/anomalyce/Desktop/scripts/neutron/profiles/setup.json"
NEUTRON="/home/anomalyce/Desktop/scripts/neutron/neutron.py"

$NEUTRON -q $PROFILE
sleep 2
$NEUTRON -o $PROFILE

# WORKSPACE_DIR="$(dirname ${SELF_DIR})/workspaces"
# TMP_WORKSPACE=1000

# # Kill all global programs
# if [ -f "${WORKSPACE_DIR}/global/unload.sh" ]; then
#    i3-msg --quiet "exec --no-startup-id ${WORKSPACE_DIR}/global/unload.sh"
# fi

# # Killing all existing programs and re-creating the workspace layouts
# for LAYOUT in $(ls "${WORKSPACE_DIR}"/[0-9]*/layout.json | sort -V);
# do
#     # Layout file
#     if [[ -f "${LAYOUT/layout.json/layout-vertical.json}" ]]; then
#         LAYOUT="${LAYOUT/layout.json/layout-vertical.json}"
#     fi

#     WORKSPACE="$(basename $(dirname $(echo "${LAYOUT}")))"

#     if [ -f "${WORKSPACE_DIR}/${WORKSPACE}/unload.sh" ]; then
#         i3-msg --quiet "exec --no-startup-id ${WORKSPACE_DIR}/${WORKSPACE}/unload.sh"
#     fi

#     i3-msg --quiet "[workspace=neutron(setup.default)@${WORKSPACE}] kill"
#     i3-msg --quiet "workspace neutron(setup.default)@${WORKSPACE}; append_layout ${LAYOUT}"
#     i3-msg --quiet "reload"
# done

# # Switch to a temporary workspace as we launch all the programs
# i3-msg --quiet "workspace ${TMP_WORKSPACE}"

# # Start all global programs
# if [ -f "${WORKSPACE_DIR}/global/load.sh" ]; then
#     i3-msg --quiet "exec --no-startup-id ${WORKSPACE_DIR}/global/load.sh"
# fi

# # Launch all the programs
# for LOADER in $(ls "${WORKSPACE_DIR}"/[0-9]*/load.sh | sort -V);
# do
#     i3-msg --quiet "exec --no-startup-id ${LOADER}"
# done

# # Jump to the primary workspaces
# i3-msg --quiet "workspace neutron(setup.default)@10; workspace neutron(setup.default)@2"

# # Mark all urgent windows as read
# for TIMER in 0 5 10; do
#     ( sleep ${TIMER} && while $(i3-msg --quiet "[urgent=latest] focus" >/dev/null 2>&1); do :; done )
# done
