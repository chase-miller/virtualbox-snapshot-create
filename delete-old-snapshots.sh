#!/bin/sh

# Deletes old snapshots

usage ()
{
  echo "usage: $0 [number of snapshots to keep]"
  exit
}

[ -n "$1" ] || usage

VM_IDS=$(VBoxManage list vms | awk -F '"' '{print $2}')

OIFS="${IFS}"
NIFS=$'\n'

IFS="${NIFS}"

for vm in ${VM_IDS}
do
	echo "Deleting all but latest $1 snapshots from $vm"
	VBoxManage snapshot "$vm" list | sed -e :a -e "$d;N;2,$1ba" -e 'P;D'  | awk -F "UUID: " '{print $2}' | awk -F ")" '{print $1}' | xargs -L1 VBoxManage snapshot "$vm" delete

	logger "Finished snapshot deletion of $vm"
	
	echo "Finished snapshot deletion of $vm"

	printf "\n\n"
done

IFS="${OIFS}"


