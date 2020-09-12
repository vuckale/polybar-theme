#!/bin/bash
state=$(pacmd list-sink-inputs | grep "state:");
if [ "$state" = "	state: RUNNING" ]; then
	# xdotool key XF86AudioPlay
	echo "%{F#fff}󰐎%{F-}"
else
	# xdotool key XF86AudioPlay
	echo "%{F#555}󰐎%{F-}"
fi 
