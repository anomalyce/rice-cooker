#!/usr/bin/env bash

if ! [ -x "$(command -v polybar)" ]; then
    rice_cooker_skip "Polybar is not installed, skipping recipe..."
fi

mkdir -p "${RECIPE_DIST_DIR}/modules"

rice_cooker_debug "Publishing the configuration"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/config.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/config.ini"

rice_cooker_debug "Publishing the launch script"
rice_cooker_substitute_env "${RECIPE_DIR}/stubs/polybar.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/polybar.sh"
chmod +x "${RECIPE_DIST_DIR}/polybar.sh"

rice_cooker_debug "Publishing VPN module"
cp -r "${RECIPE_DIR}/stubs/modules/vpn" "${RECIPE_DIST_DIR}/modules/vpn"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/vpn/polybar-offline.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/vpn/polybar-offline.sh"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/vpn/polybar-online.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/vpn/polybar-online.sh"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/vpn/vpn.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/vpn/vpn.ini"
chmod +x "${RECIPE_DIST_DIR}/modules/vpn/mullvad.sh"

rice_cooker_debug "Publishing Do Not Disturb module"
cp -r "${RECIPE_DIR}/stubs/modules/donotdisturb" "${RECIPE_DIST_DIR}/modules/donotdisturb"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/donotdisturb/donotdisturb.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/donotdisturb/donotdisturb.ini"

rice_cooker_debug "Publishing System module"
cp -r "${RECIPE_DIR}/stubs/modules/system" "${RECIPE_DIST_DIR}/modules/system"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/system/system.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/system/system.ini"

rice_cooker_debug "Publishing Windows module"
cp -r "${RECIPE_DIR}/stubs/modules/windows" "${RECIPE_DIST_DIR}/modules/windows"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/windows/windows-offline.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/windows/windows-offline.sh"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/windows/windows-online.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/windows/windows-online.sh"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/windows/windows.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/windows/windows.ini"
chmod +x "${RECIPE_DIST_DIR}/modules/windows/status.sh"

rice_cooker_debug "Publishing Network module"
cp -r "${RECIPE_DIR}/stubs/modules/network" "${RECIPE_DIST_DIR}/modules/network"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/network/network.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/network/network.ini"

rice_cooker_debug "Publishing Time Date module"
cp -r "${RECIPE_DIR}/stubs/modules/timedate" "${RECIPE_DIST_DIR}/modules/timedate"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/timedate/timedate.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/timedate/timedate.ini"

rice_cooker_debug "Publishing Microphone module"
cp -r "${RECIPE_DIR}/stubs/modules/microphone" "${RECIPE_DIST_DIR}/modules/microphone"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/microphone/microphone.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/microphone/microphone.ini"
chmod +x "${RECIPE_DIST_DIR}/modules/microphone/microphone.sh"

rice_cooker_debug "Publishing Volume module"
cp -r "${RECIPE_DIR}/stubs/modules/volume" "${RECIPE_DIST_DIR}/modules/volume"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/volume/volume.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/volume/volume.ini"

rice_cooker_debug "Publishing Workspaces module"
cp -r "${RECIPE_DIR}/stubs/modules/workspaces" "${RECIPE_DIST_DIR}/modules/workspaces"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/workspaces/workspaces.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/workspaces/workspaces.ini"

rice_cooker_debug "Publishing i3 mode module"
cp -r "${RECIPE_DIR}/stubs/modules/i3-mode" "${RECIPE_DIST_DIR}/modules/i3-mode"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/i3-mode/i3-mode.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/i3-mode/i3-mode.ini"

rice_cooker_debug "Publishing Applications module"
cp -r "${RECIPE_DIR}/stubs/modules/applications" "${RECIPE_DIST_DIR}/modules/applications"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/applications/applications.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/applications/applications.ini"

rice_cooker_debug "Publishing pacman module"
cp -r "${RECIPE_DIR}/stubs/modules/pacman" "${RECIPE_DIST_DIR}/modules/pacman"
rice_cooker_substitute_env "${RECIPE_DIST_DIR}/modules/pacman/pacman.ini"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/modules/pacman/pacman.ini"
chmod +x "${RECIPE_DIST_DIR}/modules/pacman/checkupdates.sh"

rice_cooker_debug "Re-launching Polybar"
source "${RECIPE_DIST_DIR}/polybar.sh"

exit 0
