#!/bin/bash
status_soft=$(rfkill list | grep -A2 Bluetooth | grep "Soft blocked" )
status_soft_parsed=$(while read line; do echo "${line}"; done <<< "$status_soft")
status_hard=$(rfkill list | grep -A2 Bluetooth | grep "Hard blocked")
status_hard_parsed=$(while read line; do echo "${line}"; done <<< "$status_hard")
if [ "$status_soft_parsed" = "Soft blocked: yes" ]; then
	echo "󰂲"
elif [ "$status_soft_parsed" = "Soft blocked: no" ]; then
	echo "󰂯"
elif [ "$status_hard_parsed" = "Hard blocked: yes" ]; then
	echo "${env:ALERT}󰂲"
fi
