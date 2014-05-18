#!/bin/sh

# Prepares virtualbox for time machine backups

usage ()
{
  echo "usage: $0 [number of snapshots to keep]"
  exit
}

[ -n "$1" ] || usage

echo "Preparing virtualbox for time machine backups"
logger "Preparing virtualbox for time machine backups"

snapshot-virtualbox.sh
printf "\n\n"

delete-old-snapshots.sh $1
printf "\n\n"

#compact-virtualbox-vdis.sh
#printf "\n\n"

echo "Done preparing virtualbox for time machine backups"
logger "Done preparing virtualbox for time machine backups"
