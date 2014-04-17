#!/bin/sh

FORMATTED_DATE=$(date | awk '{gsub(/[ \t]/,"-");print}')

VM_IDS=$(VBoxManage list vms | awk -F '"' '{print $3}')
VM_IDS_ARRAY=(${VM_IDS//" "/ })

for ((i = 0 ; i < ${#VM_IDS_ARRAY[@]}; i++));
do
	NEXT=${VM_IDS_ARRAY[$(($i))]}
	VBoxManage snapshot "$NEXT" take "$FORMATTED_DATE"
	logger "From $0 - Created VirtualBox Snapshot for VM $NEXT"
done