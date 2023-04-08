#!/bin/bash

# This script sets a username and password on a raspberry pi image, as the default image doesn't set one anymore.
#
# original author github/agoldcheidt - https://github.com/lukechilds/dockerpi/issues/53

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
echo 'pi:$6$uE1YmGMLJIuYRDA6$7uggLlPOnrfoFczREehC9C.rHVe2N5QQfK5Tbuio1bRAgob6/6j1iN8QyrJkvv4rfVbhsFICI.cPmKe.rT8Qi.' > /mnt/userconf.txt #Adding custom user account only for Raspberry Pi OS Lite
echo ""
#Unmounting image boot partition
sudo umount /mnt

sudo mount /dev/loop55p2 /mnt
sudo cp /etc/ssh/ssh_host* /mnt/etc/ssh/
sudo umount /mnt

#Detaching the mount point
sudo losetup -d /dev/loop55
echo ""
echo "-------------------------------------"
echo "==== DONE! IMAGE READY ===="
echo "-------------------------------------"
echo ""
sync
