#!/usr/bin/env bash

rice_cooker_recipe_cache_dir

rice_cooker_debug "Cloning the latest kernel..."
cd "${RECIPE_CACHE_DIR}"

asp set-git-protocol git
asp update linux
asp checkout linux

rice_cooker_debug "Enabling Voluntary Kernel Preemption"
sed -i 's/CONFIG_PREEMPT=y/CONFIG_PREEMPT_VOLUNTARY=y/' "${RECIPE_CACHE_DIR}/linux/repos/core-x86_64/config"

rice_cooker_debug "Renaming the custom kernel"
sed -i 's/pkgbase=linux/pkgbase=vfio-kernel/' "${RECIPE_CACHE_DIR}/linux/repos/core-x86_64/PKGBUILD"

rice_cooker_debug "Updating the package checksum"
updpkgsums "${RECIPE_CACHE_DIR}/linux/repos/core-x86_64/PKGBUILD"

rice_cooker_instruction "Manually run the following snippet to compile the kernel (might take a long time)"
rice_cooker_manual_code "cd ${RECIPE_CACHE_DIR}/linux/repos/core-x86_64/PKGBUILD && makepkg -s"