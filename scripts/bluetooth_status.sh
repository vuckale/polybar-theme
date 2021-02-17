#!/bin/bash
if [ ! "$( which rfkill )" = "" ]; then
	status=$( rfkill list | grep -A2 Bluetooth )
	if [ ! -z "$status" ]; then
		status_soft=$( echo "$status" | grep "Soft blocked" )
		status_hard=$( echo "$status" | grep "Hard blocked")
		status_soft_parsed=$( while read line; do echo "${line}"; done <<< "$status_soft" )
		status_hard_parsed=$( while read line; do echo "${line}"; done <<< "$status_hard" )
		if [ "$status_soft_parsed" = "Soft blocked: yes" ]; then
			echo "󰂲"
		elif [ "$status_soft_parsed" = "Soft blocked: no" ]; then
			echo "󰂯"
		elif [ "$status_hard_parsed" = "Hard blocked: yes" ]; then
			echo "${env:ALERT}󰂲"
		fi
	else
		# no bluetooth
		echo "$(date) ${PWD##*/}/`basename "$0"`: no bluetooth interface found" >> ../log.txt
		echo "Y"
	fi
else
	# no rfkill installed
	echo "$(date) ${PWD##*/}/`basename "$0"`: no rfkill installed" >> ../log.txt
    echo "X"
fi
