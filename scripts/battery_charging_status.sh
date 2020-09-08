#!/bin/bash
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state")
state=$(echo $state | cut -d':' -f2)
if [ $state = "discharging" ]; then
	echo 󱐤
elif [$state = "charging" ]; then
	echo 󱐥
elif [$state = "fully-charged" ]; then
	echo 󱐥
fi
