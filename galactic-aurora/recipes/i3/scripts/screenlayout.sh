#!/usr/bin/env bash

xrandr \
    --output "${MONITOR_PRIMARY}" \
        --mode 3840x2160 \
        --pos 0x0 \
        --rotate normal \
    --output "${MONITOR_SECONDARY}" \
        --mode 3840x2160 \
        --rotate normal \
        --pos 3840x0
