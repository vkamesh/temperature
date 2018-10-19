#!/bin/bash

# Stop the window manager
/etc/init.d/matrix-gui-2.0 stop

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

for FREQ in 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 1100000 1176000 1200000 1300000 1400000 1500000; do
#for FREQ in 800000 900000 1000000 1100000 1176000 1200000 1300000 1400000 1500000; do

    for CORE in 0; do

	# The frequency scaling governer is set to operate in the 'userspace' mode
	echo $FREQ > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

	echo "Entering $FREQ, $(date)"

	echo -n "start" >/dev/udp/137.194.165.146/8000

	for BENCHMARK in sha; do
#	    for i in {1..1024}; do
	    	taskset -c $CORE ./${BENCHMARK}
#	    done
	done

	echo -n "stop" >/dev/udp/137.194.165.146/8000
    done

    echo "Entering sleep for 10 seconds"
    sleep 10;

done

echo "Benchmark finished, $(date)"

# Revert the frequency scaling governer to 'ondemand' mode
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

