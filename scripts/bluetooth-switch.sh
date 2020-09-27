#!/bin/bash
if [ $(rfkill list bluetooth | grep "Soft blocked: yes" | wc -l) -gt 0 ] ; then
    rfkill unblock bluetooth
    notify-send "bluetooth-switch.sh" "Enabled Bluetooth"
else
    rfkill block bluetooth
    notify-send "bluetooth-switch.sh" "Disabled Bluetooth"
fi
