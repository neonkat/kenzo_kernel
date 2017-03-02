#!/system/bin/sh

# Mount root as RW to apply tweaks and settings
busybox mount -o remount,rw /system
busybox mount -t rootfs -o remount,rw rootfs

# Install Busybox
/sbin/bb/busybox --install -s /sbin

#MSM hotplug
#echo "0" > /sys/module/msm_hotplug/msm_enabled;
#echo "1" > /sys/module/msm_hotplug/min_cpus_online;
#echo "750" > /sys/module/msm_hotplug/down_lock_duration;
#echo "2" > /sys/module/msm_hotplug/max_cpus_online_susp;

#intelli-plug
#echo "787200" > /sys/module/intelli_plug/parameters/screen_off_max;
#echo "2" > /sys/module/msm_hotplug/max_cpus_online_susp;
#echo "2500" > /sys/module/msm_hotplug/boost_lock_duration;

#zram tweaks
echo "0" > /proc/sys/kernel/randomize_va_space;
echo "0" > /proc/sys/vm/page-cluster;
echo "10" > /proc/sys/vm/dirty_ratio;
echo "50" > /proc/sys/vm/vfs_cache_pressure;
echo "5" > /proc/sys/vm/dirty_background_ratio;
echo "3000" > /proc/sys/vm/dirty_writeback_centisecs;
echo "600" > /proc/sys/vm/dirty_expire_centisecs;
echo "75" > /proc/sys/vm/swappiness;
echo "4096" > /proc/sys/vm/min_free_kbytes;
echo "5120000" > /proc/sys/vm/dirty_background_bytes;

#cpu

#vibration amplitude
# echo "53" > /sys/class/timed_output/vibrator/amp;

# LMK
#echo "1536,2048,4096,16384,28672,32768" > /sys/module/lowmemorykiller/parameters/minfree;

#Correct entropy values
echo "1366" > /proc/sys/kernel/random/read_wakeup_threshold;
echo "2048" > /proc/sys/kernel/random/write_wakeup_threshold;

#i/o
echo "sioplus" > /sys/block/mmcblk0/queue/scheduler;
for i in /sys/block/*/queue;do
 echo 512 > $i/read_ahead_kb;
done;

# Google Services battery drain fixer by Alcolawl@xda
pm enable com.google.android.gms/.update.SystemUpdateActivity
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver
