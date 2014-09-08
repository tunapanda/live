#!/bin/bash -x

LIB="$(dirname ${BASH_SOURCE[0]})"/lib.sh
if [ ! -e $LIB ] 
then 
	echo "ERROR: Required file not found: $LIB" >&2
	exit 1
else
	source $LIB
fi

UID=$(id -u)

if [ ! -e source.iso ]
then
	echo ""
	echo "ERROR: source.iso not found" >&2
	echo "  Please copy or symlink the source ISO you want to use to" >&2
	echo "  source.iso in the build directory" >&2 
	echo ""
	exit $ERRNOISO
fi

for d in Livecd Initrd FS
do
	if [ ! -e .${d}-source ] 
	then
		mkdir .${d}-source
	fi
	if [ ! -e ${d}-root ]
	then
		mkdir ${d}-root
		touch ${d}-root/.canary
	fi
done
( is_mounted .Livecd-source || sudo mount -o norock,uid=${UID},loop source.iso .Livecd-source ) &&
( is_mounted Livecd-root || (
	unionfs-fuse -o nonempty -o cow .Livecd-overlay=rw:.Livecd-source=ro Livecd-root  &&
	rm -rf .Initrd-source/* &&
	pushd .Initrd-source && 
	lzcat ../Livecd-root/casper/initrd.lz | cpio -idv ; popd ) ) &&
( is_mounted .FS-source || sudo mount .Livecd-source/casper/filesystem.squashfs .FS-source ) &&
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
	exit $ERRMOUNTFAILED
fi

echo "DONE"

