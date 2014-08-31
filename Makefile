all: iso

cleanall: clean iso

iso: env_setup Livecd-root/casper/initrd.lz Livecd-root/casper/tunapanda.squashfs
	Scripts/mkiso iso

chroot: env_setup
	sudo Scripts/setup_live_chroot.sh FS-root
	sudo chroot FS-root

env_setup: Livecd-root FS-root Initrd-root
	Scripts/env_setup.sh

Livecd-root:
	mkdir Livecd-root
	touch Livecd-root/.canary

FS-root:
	mkdir FS-root
	touch FS-root/.canary

Initrd-root:
	mkdir Initrd-root
	touch Initrd-root/.canary

Livecd-root/casper/initrd.lz: .Initrd-overlay
	cd Initrd-root ; find . | cpio --quiet --dereference -o -H newc | lzma -7 > ../Livecd-root/casper/initrd.lz

Livecd-root/casper/tunapanda.squashfs: .FS-overlay
	mksquashfs .FS-overlay Livecd-root/casper/tunapanda.squashfs -e '.fuse*' 
	du -sx --block-size=1 .FS-overlay | cut -f1 > Livecd-root/casper/tunapanda.size

.PHONY: clean all env_setup unmount chroot
clean: unmount

unmount:
	Scripts/env_teardown.sh
