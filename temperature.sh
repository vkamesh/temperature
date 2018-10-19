#!/bin/sh
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)

for i in 1 2 3 4 5 6 7 8 9 10
do
  echo "cat /sys/class/thermal/thermal_zone0/temp command${i}1 && command${i}2 && command${i}3"
done | xargs -P 10 -l 1 bash -c

