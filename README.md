Build scripts for Tunapanda Edubuntu, a custom variant of Ubuntu/Edubuntu, designed for deployment in no/low-bandwidth classrooms.

It is primarily a project by [Tunapanda.Org](http://tunapanda.org), but the goal is to make it into a system that can be used by other organizations with similar goals. 

The system is currently only tested on Ubuntu 12.x, but it should work on anything that supports unionfs-fuse (in Ubuntu, be sure to do `sudo apt-get install unionfs-fuse` before you begin).

For a technical overview of how the system works, its limitations and its roadmap, see [this document]( https://docs.google.com/document/d/19N5jBC4Ag1mglCEbwayOptUEfUo6TMhCyDVEeAnokVg/edit?usp=sharing). However, **NOTE:** for now this is just a generic framework for building customized versions of an exisiting ISO. Very few of the specific changes Tunapanda makes for its version are currently implemented. 

For now, ideally, if you place an [Edubuntu 12.04 ISO](http://edubuntu.org/download) with the filename `source.iso` in the build directory and run `make`, it *should* create essentially a copy of that ISO with some Tunapanda branding in the boot menu, but the system you boot or install from there will basically be stock Edubuntu. 

Figuring out the best way to reproduce the OS customizations that Tunapanda has made in an automatable way (see the *Problems* section of the document linked above), and incorporating them into this build chain will be the primary purpose of this repository for now.

Feel free to contact the repository owner if you have questions or comments. 
