# virtualbox-snapshot-create
Shell script to create a virtualbox snapshot

In retrospect these scripts seem quite hacky.  I've since read about the problems of using snapshots as backup mechanisms.

In light of this, I've replaced these scripts with a simple script (that is added to a crontab) that calls an rsync command to my NAS:
  rsync -av -e ssh --delete /Users/{user}/VirtualBox\ VMs/ {user}@freenas.local:/mnt/{rest of nas location} 2>&1 | tee /dev/stderr | logger -i -t "rsync virtualbox task: "

These scripts may prove to be useful to some, so please feel free to fork :-).  
  
