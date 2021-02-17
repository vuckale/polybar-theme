#!/bin/bash
device="hidpp_battery_0"
device_alt="mouse_$device"
if [ ! $( which upower ) == "" ]; then
	for i in /sys/class/power_supply/hidpp_battery_*; do
		sysclass=$( echo "$( <$( dirname $i ) ): $( cat ${i%_*}_label 2>/dev/null ||\
		 echo $( basename ${i%_*} )) $i" | grep "hidpp_battery" |\
		 awk -F' ' '{print $3}' )
	done
	if [ -d $sysclass ]; then
		device=$(echo ${sysclass} | sed 's:.*/::')
		device_alt="mouse_$device"
		upower="upower -i /org/freedesktop/UPower/devices"
		mouse_charging_status=$(cat ${sysclass}/status)
		state=$($upower/$device_alt | grep "percentage" | tr -d -c 0-9)
		if [ "$mouse_charging_status" = "Unknown" ]; then
			echo "%{F$FOREGROUND_ALT}󰍾%{F-}"
		else
			prefix=$(echo "%{F$FOREGROUND_ALT}󰦋")

			if [ "$mouse_charging_status" = "Charging" ]; then
				echo "$prefix󰂄%{F-}$state%"
			else
				if [ "$state" == 100 ];then
					echo "$prefix󱊣%{F-}$state%"
				elif [ "$state" -lt 100 ] && [ "$state" -ge 50 ]; then
					echo "$prefix󱊢%{F-}$state%"
				elif [ "$state" -lt 50 ] && [ "$state" -ge 10 ]; then
					echo "$prefix󱊡%{F-}$state%"
				elif [ "$state" -lt 10 ]; then
					echo "$prefix󱃍%{F-}$state%"
				fi
			fi
		fi
	else
		# no sysclass found
		echo "Y"
		echo "$(date) ${PWD##*/}/`basename "$0"`: no $sysclass directory found" >> ../log.txt
	fi
else
	# no upower installed
	echo "X"
	echo "$(date) ${PWD##*/}/`basename "$0"`: no upower installed" >> ../log.txt
fi
