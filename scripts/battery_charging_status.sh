#!/bin/bash
for i in /sys/class/power_supply/BAT*; do
  sysclass=$( echo "$(<$(dirname $i)): $(cat ${i%_*}_label 2>/dev/null || echo $( basename ${i%_*} ) ) $i" | grep "BAT" | awk -F' ' '{print $3}' )
done

if [ -d "$sysclass" ]; then
	state=$(cd $sysclass && cat status)
	if [ $state = "Discharging" ]; then
		echo 󱐤
	elif [ $state = "Charging" ]; then
		echo 󱐥
	elif [ $state = "Full" ]; then
		echo 󱐥
	fi
else
	# no sysclass directory found
	echo "$(date) ${PWD##*/}/`basename "$0"`: no $sysclass directory found" >> ../log.txt
	echo "X"
fi
