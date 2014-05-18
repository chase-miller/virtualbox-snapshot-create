#!/bin/sh

echo "Compacting virtualbox vdi images"
logger "Compacting virtualbox vdi images"

VBoxManage list hdds | grep "^UUID:" | awk -F " " '{print $2}' | xargs -L1 VBoxManage modifyhd --compact

echo "Done compacting virtualbox vdi images"
logger "Done compacting virtualbox vdi images"
