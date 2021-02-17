#!/bin/bash
if [ ! $( which pacmd ) == "" ]; then
	state=$(pacmd list-sink-inputs | grep "state:");
	if [ "$state" = "	state: RUNNING" ]; then
		echo "%{F$FOREGROUND}󰐎%{F-}"
	else
		echo "%{F$FOREGROUND_ALT}󰐎%{F-}"
	fi
else
	# no pacmd installed
	echo "X"
	echo "$(date) ${PWD##*/}/`basename "$0"`: no pacmd installed" >> ../log.txt
fi
