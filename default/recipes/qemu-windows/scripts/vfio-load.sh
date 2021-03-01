#!/usr/bin/env bash

tmpStatus=$(virsh list --all | grep " ${QEMU_VFIO_DOMAIN} " | awk '{ print $3 }')
if ([ "x$tmpStatus" == "xrunning" ])
then
    tmpUtilization=$(ssh -i ${QEMU_VFIO_SSH_KEY} ${QEMU_VFIO_SSH} 'nvidia-smi.exe --format=csv,noheader --query-gpu=utilization.gpu')
    utilization=$(echo $tmpUtilization | sed 's/[^0-9]*//g')

    echo "$utilization"
else
    echo "0"
fi

exit 0
