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
        echo -n "A72 "
        vcgencmd measure_clock arm
        echo -n "A72 "
        vcgencmd measure_temp
        echo -n ""
		vcgencmd get_throttled
        echo ""
        sleep 1
done

