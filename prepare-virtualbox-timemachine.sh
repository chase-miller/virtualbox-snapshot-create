#!/bin/sh

# Prepares virtualbox for time machine backups

usage ()
{
  echo "usage: $0 [number of snapshots to keep]"
  exit
}

[ -n "$1" ] || usage

snapshot-virtualbox.sh

delete-old-snapshots.sh $1

VM_IDS=$(VBoxManage list vms | awk -F '"' '{print $2}')

OIFS="${IFS}"
NIFS=$'\n'

IFS="${NIFS}"

for vm in ${VM_IDS}
do
	echo "Compacting vdi for $vm"

	VBoxManage modifyhd "$vm" –-compact

	logger "Finished compacting vdi of $vm"

	echo "Finished compacting vdi of $vm"	

	printf "\n\n"
done

IFS="${OIFS}"
