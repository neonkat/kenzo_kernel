# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=
do.devicecheck=1
do.initd=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=kenzo
device.name2=kate
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# remove mpdecsion binary
mv $bindir/mpdecision-rm $bindir/mpdecision

#add custom tuning to init.rc
insert_line init.qcom.rc "import /init.infected.rc" after "import /init.trace.rc" "import /init.infected.rc";

insert_line init.qcom.rc "import init.qcom.power.rc" before "import init.qcom.usb.rc" "import init.qcom.power.rc";

insert_line init.qcom.rc "import /init.spectrum.rc" after "import /init.infected.rc" "import /init.spectrum.rc";

# Disable MP Decison
replace_line init.rc "service mpdecision /system/bin/mpdecision" "#mpdecision /system/bin/mpdecision2";

# Disable mp decision(6.x roms)
replace_line init.qcom.rc "service mpdecision /system/bin/mpdecision" "#mpdecision /system/bin/mpdecision2";

# Add frandom compatibility
backup_file ueventd.rc;
insert_line ueventd.rc "frandom" after "urandom" "/dev/frandom              0666   root       root\n";
insert_line ueventd.rc "erandom" after "urandom" "/dev/erandom              0666   root       root\n";
backup_file file_contexts;
insert_line file_contexts "frandom" after "urandom" "/dev/frandom		u:object_r:frandom_device:s0\n";
insert_line file_contexts "erandom" after "urandom" "/dev/erandom               u:object_r:erandom_device:s0\n";

# end ramdisk changes

write_boot;

## end install

