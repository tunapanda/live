#!/bin/bash 

# error codes
ERRNOISO=1
ERRCANARIES=2

if [ ! -e source.iso ]
then
	echo ""
	echo "FAIL: source.iso not found" >&2
	echo "  Please copy or symlink the source ISO you want to use to" >&2
	echo "  source.iso in the build directory" >&2 
	echo ""
	exit $ERRNOISO
fi

function is_mounted() {
	df -h | grep $1		
}

( is_mounted .Livecd-source || mount -o loop source.iso .Livecd-source ) &&
( is_mounted Livecd-root || (
	unionfs-fuse -o nonempty -o cow .Livecd-overlay=rw:.Livecd-source=ro Livecd-root  &&
	rm -rf .Initrd-source/* &&
	pushd .Initrd-source && 
	lzcat ../Livecd-root/casper/initrd.lz | cpio -idv ; popd ) ) &&
( is_mounted .FS-source || mount Livecd-root/casper/filesystem.squashfs .FS-source ) &&
( is_mounted FS-root || unionfs-fuse -o nonempty -o cow .FS-overlay=rw:.FS-source=ro FS-root ) &&
( is_mounted Initrd-root || unionfs-fuse -o nonempty -o cow .Initrd-overlay=rw:.Initrd-source=ro Initrd-root ) &&

# The mountpoints have '.canary' files in them. If this file is
# still visible, something when wrong with the mount.
CANARIES=""
for d in {Livecd,Initrd,FD}-root 
do
	if [ -e $d/.canary ] 
	then 
		CANARIES="$d $CANARIES" 
	fi
done

if [ -n "$CANARIES" ] 
then
	echo "'.canary' files found\! These dirs may not have mounted properly: $CANARIES" >&2
	exit $ERRCANARIES
fi

echo "DONE"

