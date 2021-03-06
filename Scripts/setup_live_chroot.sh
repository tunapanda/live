#!/bin/bash -x


DIR=$1
if [ -z "$DIR" -o ! -d "$DIR" ]
then
    echo "Couldn't find directory: '$DIR'" >&2
    exit 1
fi

[ -e $DIR/dev ] || sudo mkdir $DIR/dev
sudo mount --bind /dev/ $DIR/dev
sudo chroot $DIR mount -t proc none /proc
sudo chroot $DIR mount -t sysfs none /sys
sudo chroot $DIR mount -t devpts none /dev/pts
