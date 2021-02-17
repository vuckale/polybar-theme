#!/bin/bash
if [ ! "$(which rfkill)" = "" ]; then
    status=$( rfkill list bluetooth )
	if [ ! -z "$status" ]; then
        if [ $( echo "$status" | grep "Soft blocked: yes" | wc -l ) -gt 0 ] ; then
            rfkill unblock bluetooth
            notify-send "bluetooth-switch.sh" "Enabled Bluetooth"
        else
            rfkill block bluetooth
            notify-send "bluetooth-switch.sh" "Disabled Bluetooth"
        fi
    else
		# no bluetooth
		notify-send "bluetooth-switch.sh" "No Bluetooth found"
		echo "$(date) ${PWD##*/}/`basename "$0"`: no bluetooth interface found" >> ../log.txt  
	fi
else
	# no rfkill installed
    notify-send "bluetooth-switch.sh" "rfkill not installed"
	echo "$(date) ${PWD##*/}/`basename "$0"`: no rfkill installed" >> ../log.txt
fi
