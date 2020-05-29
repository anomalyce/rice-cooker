#!/usr/bin/env bash

tmpStatus=$(virsh list --all | grep " ${QEMU_VFIO_DOMAIN} " | awk '{ print $3 }')
if ([ "x$tmpStatus" == "xrunning" ])
then
    tmpTemp=$(ssh -i ${QEMU_VFIO_SSH_KEY} ${QEMU_VFIO_SSH} 'nvidia-smi.exe --format=csv,noheader --query-gpu=temperature.gpu')
    temp=$(echo $tmpTemp | sed 's/[^0-9]*//g')

    echo "$temp°C"
else
    echo "N/A"
fi

exit 0
