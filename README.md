## What is this?
Build scripts for Tunapanda Edubuntu, a custom variant of Ubuntu/Edubuntu, designed for deployment in no/low-bandwidth classrooms.

It is primarily a project by [Tunapanda.Org](http://tunapanda.org), but the goal is to make it into a system that can be used by other organizations with similar goals. 

## How does it work?
For a technical overview of how the system works, its limitations and its roadmap, see [this document]( https://docs.google.com/document/d/19N5jBC4Ag1mglCEbwayOptUEfUo6TMhCyDVEeAnokVg/edit?usp=sharing). However... 

**NOTE:** For now this is just a generic framework for building customized versions of an exisiting ISO. Very few of the specific changes Tunapanda makes for its version are currently implemented. Instead, you will get essentially a copy of the ISO you put in, plus some Tunapanda branding on the boot menu, and a /usr/local/tunapanda directory on the resulting system. 

Figuring out the best way to reproduce the OS customizations that Tunapanda has made in an automatable way (see the *Problems* section of the document linked above), and incorporating them into this build chain will be the primary purpose of this repository for now!

## How do I use it?
### Dependencies
The system is currently only tested on Ubuntu 12.x, but it should work on anything that provides these dependencies:
* [unionfs-fuse](http://podgorny.cz/moin/UnionFsFuse) 
* make
* mkisofs

In Ubuntu, you can get these with `sudo apt-get install unionfs-fuse make genisoimage`

## Build process
1. Clone this repository
1. In the resulting directory, place an [Edubuntu 12.04 ISO](http://edubuntu.org/download) in it.
  * Any other distro that uses the Ubiquity installer should work, but is un-tested.
1. Rename or symlink the ISO so it has the filename `source.iso`
1. Run `make`

If everything works, you should find your new ISO in a directory called `Completed`. 

**NOTE:** When the build is complete, you may want to unmount all the unionfs stuff by running `make unmount`

Feel free to contact the repository owner if you have questions or comments. 
