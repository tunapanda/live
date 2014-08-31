#!/bin/bash -x

function is_mounted() {
	df -h | grep $1		
}


for d in Initrd-root FS-root .FS-source Livecd-root .Livecd-source 
do 
	is_mounted $d && umount $d 
done

#rm -rf .Initrd-source/*
