#!/usr/bin/env bash

if ! [ -x "$(command -v virsh)" ]; then
    rice_cooker_skip "QEMU/Libvirt is not installed, skipping recipe..."
fi

mkdir -p "${RECIPE_DIST_DIR}"

rice_cooker_debug "Publishing the qemu-control script"
cp "${RECIPE_DIR}/scripts/qemu-control.sh" "${RECIPE_DIST_DIR}/qemu-control.sh"
chmod +x "${RECIPE_DIST_DIR}/qemu-control.sh"
