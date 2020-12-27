#!/bin/bash
gcc stress.c -o stress_a72 -Ofast -mcpu=cortex-a72 -mtune=cortex-a72 -ffast-math -funroll-all-loops
taskset -c 0 ./stress_a72 2>&1 &
taskset -c 1 ./stress_a72 2>&1 &
taskset -c 2 ./stress_a72 2>&1 &
taskset -c 3 ./stress_a72 2>&1 &

function cleanup()
{
	killall stress_a72
	exit 0
}

trap cleanup SIGINT

while true
do
	echo -n "a72 freq: "
        cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
	echo -n "temp: "
        cat /sys/devices/virtual/thermal/thermal_zone0/temp
        echo ""
        sleep 1
done

