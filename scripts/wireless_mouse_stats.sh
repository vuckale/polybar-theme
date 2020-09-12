#!/bin/bash
device="hidpp_battery_0"
device_alt="mouse_$device"

for i in /sys/class/power_supply/hidpp_battery_*; do 
  sysclass=$(echo "$(<$(dirname $i)): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i" | grep "hidpp_battery" | awk -F' ' '{print $3}')
done

device=$(echo ${sysclass} | sed 's:.*/::')
device_alt="mouse_$device"

upower="upower -i /org/freedesktop/UPower/devices"

mouse_model_name=$(cat ${sysclass}/model_name)
mouse_online_status=$(cat ${sysclass}/online)

if [ $2 = 1 ]; then
	state=$($upower/$device_alt | grep "percentage" | tr -d -c 0-9)
	echo "$state%"
	if [ $1 = "1" ]; then
		notify-send "$mouse_model_name" "$state%"
	fi
elif [ $2 = 2 ]; then
	if [ $mouse_online_status = "0" ]; then
		echo -e "\e[31m󰄯"
		if [ $1 = "1" ]; then
			notify-send "$mouse_model_name" "is disconnected"
		fi
	else
		echo -e "\e[32m󰄯"
		if [ $1 = "1" ]; then
			notify-send "$mouse_model_name" "is connected"
		fi
	fi
fi
