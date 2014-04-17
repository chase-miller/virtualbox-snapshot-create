#!/bin/sh

# Creates a snapshot of each VM in VirtualBox. The name is the timestamp.

FORMATTED_DATE="$(date | awk '{gsub(/[ \t]/,"-");print}')-snapshot"

VM_IDS=$(VBoxManage list vms | awk -F '"' '{print $3}')
VM_IDS_ARRAY=(${VM_IDS//" "/ })

for ((i = 0 ; i < ${#VM_IDS_ARRAY[@]}; i++));
do
	NEXT=${VM_IDS_ARRAY[$(($i))]}
	
	COMMAND="VBoxManage snapshot "$NEXT" take "$FORMATTED_DATE" --live"
	echo $COMMAND
	$($COMMAND)
	
	logger "From $0 - Created VirtualBox Snapshot $FORMATTED_DATE for VM $NEXT"
	
	echo "Created VirtualBox Snapshot $FORMATTED_DATE for VM $NEXT"
	printf "\n\n"
done