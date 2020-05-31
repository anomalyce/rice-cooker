#!/usr/bin/env bash

SELF_DIR=`realpath $(dirname "$0")`

STATUS="$(virsh list --all | grep " windows " | awk '{ print $3}')"

if ([ "x${STATUS}" == "x" ] || [ "x${STATUS}" != "xrunning" ])
then
    echo $(cat "${SELF_DIR}/windows-offline.sh" | sh)
else
    echo $(cat "${SELF_DIR}/windows-online.sh" | sh)
fi
