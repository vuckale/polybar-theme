#!/bin/bash
state=$(pacmd list-sink-inputs | grep "state:");
if [ "$state" = "	state: RUNNING" ]; then
	echo "%{F$FOREGROUND}󰐎%{F-}"
else
	echo "%{F$FOREGROUND_ALT}󰐎%{F-}"
fi 
