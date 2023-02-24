#!/bin/bash

# originally found on stackoverflow or github issue?

#Args
img=$1

#Usage checks
if [[ -z $img ]]; then
  echo "Usage: $0 imagefile.img"
  exit -1
fi
if [[ ! -e $img ]]; then
  echo "ERROR: $img is not a file..."
  exit -2
fi
if (( EUID != 0 )); then
   echo "ERROR: You need to be running as root."
   exit -3
fi

#Creating the mount point
losetup loop55 -P $img
#Mounting image boot partition
sudo mount /dev/loop55p1 /mnt
#Creating username and password into userconfig file
echo 'berryboot:$6$uE1YmGMLJIuYRDA6$7uggLlPOnrfoFczREehC9C.rHVe2N5QQfK5Tbuio1bRAgob6/6j1iN8QyrJkvv4rfVbhsFICI.cPmKe.rT8Qi.' > /mnt/userconf.txt #Adding custom user account only for Raspberry Pi OS Lite
echo ""
#Unmounting image boot partition
sudo umount /mnt
#Detaching the mount point
sudo losetup -d /dev/loop55
echo ""
echo "-------------------------------------"
echo "==== DONE! IMAGE READY ===="
echo "-------------------------------------"
echo ""
sync
