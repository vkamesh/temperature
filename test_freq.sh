#!/bin/bash

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

for FREQ in 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 1100000 1176000 1200000 1300000 1400000 1500000; do

    for CORE in 0; do

	# The frequency scaling governer is set to operate in the 'userspace' mode
	echo $FREQ > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

	echo "Entering $FREQ"

    done

    echo "Entering sleep for 10 seconds"
    sleep 1;

done

echo "Benchmark finished, $(date)"

# Revert the frequency scaling governer to 'ondemand' mode
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

