#!/usr/bin/env bash

if ! [ -x "$(command -v virsh)" ]; then
    rice_cooker_skip "QEMU/Libvirt is not installed, skipping recipe..."
fi

mkdir -p "${RECIPE_DIST_DIR}"

rice_cooker_debug "Publishing the Single 4K screenlayout"
rice_cooker_substitute_env "${RECIPE_DIR}/screenlayouts/single-4k.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/single-4k.sh"
chmod +x "${RECIPE_DIST_DIR}/single-4k.sh"

rice_cooker_debug "Publishing the Dual 4K screenlayout"
rice_cooker_substitute_env "${RECIPE_DIR}/screenlayouts/dual-4k.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/dual-4k.sh"
chmod +x "${RECIPE_DIST_DIR}/dual-4k.sh"

rice_cooker_debug "Publishing the VFIO load script"
rice_cooker_substitute_env "${RECIPE_DIR}/scripts/vfio-load.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/vfio-load.sh"
chmod +x "${RECIPE_DIST_DIR}/vfio-load.sh"

rice_cooker_debug "Publishing the VFIO temperature script"
rice_cooker_substitute_env "${RECIPE_DIR}/scripts/vfio-temp.sh"
echo "${RICE_COOKER_OUTPUT}" > "${RECIPE_DIST_DIR}/vfio-temp.sh"
chmod +x "${RECIPE_DIST_DIR}/vfio-temp.sh"

exit 0
