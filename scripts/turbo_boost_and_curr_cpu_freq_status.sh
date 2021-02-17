#!/bin/bash
status=$( cat /sys/devices/system/cpu/intel_pstate/no_turbo 2>/dev/null )
freq=$( lscpu | awk -F : '($1=="CPU MHz") {printf "%3.2fGHz\n", $2/1000}' )

if [ -z "$status" ]; then
	icon="%{F$FOREGROUND_ALT}󰐰%{F-}"
else
	if [ $status = 1 ]; then
		icon=$( echo "%{F$FOREGROUND_ALT}󰾆%{F-}" )
	else
		icon=$( echo "%{F$FOREGROUND_ALT}󰓅%{F-}" )
	fi
fi

if [ ! -z "$freq" ]; then
	echo "$icon $freq"
else
	echo "X"
	echo "$(date) ${PWD##*/}/`basename "$0"`: lscpu failed" >> ../log.txt
fi
