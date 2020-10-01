#!/bin/bash
device="hidpp_battery_0"
device_alt="mouse_$device"

for i in /sys/class/power_supply/hidpp_battery_*; do 
  sysclass=$(echo "$(<$(dirname $i)): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i" | grep "hidpp_battery" | awk -F' ' '{print $3}')
done

device=$(echo ${sysclass} | sed 's:.*/::')
device_alt="mouse_$device"

upower="upower -i /org/freedesktop/UPower/devices"

state=$($upower/$device_alt | grep "percentage" | tr -d -c 0-9)
	if [ "$state" == 100 ];then
		echo "󱊣"
	elif [ "$state" -lt 100 ] && [ "$state" -ge 50 ]; then
		echo "󱊢"
	elif [ "$state" -lt 50 ] && [ "$state" -ge 10 ]; then
		echo "󱊡"
	elif [ "$state" -lt 10 ]; then
		echo "󱃍"
	fi

