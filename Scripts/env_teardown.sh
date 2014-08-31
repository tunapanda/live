#!/bin/bash -x

LIB="$(dirname ${BASH_SOURCE[0]})"/lib.sh
if [ ! -e $LIB ] 
then 
	echo "ERROR: Required file not found: $LIB" >&2
	exit 1
else
	source $LIB
fi
require_root

is_mounted FS-root/dev &&  umount FS-root/{proc,sys,dev/pts,dev}
for d in Initrd-root FS-root .FS-source Livecd-root .Livecd-source 
do 
	is_mounted $d && umount $d 
done

