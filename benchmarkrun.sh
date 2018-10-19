#!/bin/bash

# Stop the window manager
/etc/init.d/matrix-gui-2.0 stop

# Change the frequency scaling governor to 'userspace' mode
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

for FREQUENCY in 1500000; do
    for CORE in 0; do
        # Set the scaling frequency for the 'userspace' mode
        echo $FREQUENCY > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
        
        echo "Entering $FREQUENCY, $(date)"

        taskset -c 1 ./logging.sh&
        export LOGGING_PID=$!
        echo "Logging PID = $LOGGING_PID"
        
        for BENCHMARK in sha; do
            echo 'BENCHMARK STARTED' >> Temperatures.log
	    taskset -c $CORE ./${BENCHMARK}
	    echo 'BENCHMARK ENDED' >> Temperatures.log
        done

	kill $LOGGING_PID
        
        echo "Benchmark finished, $(date)"
	
	done
done

# Revert the frequency scaling governor to 'ondemand' mode
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "Frequency governor changed to 'ondemand'"


