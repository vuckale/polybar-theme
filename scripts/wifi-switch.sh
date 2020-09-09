#!/bin/bash
if [ $(rfkill list wifi | grep "Soft blocked: yes" | wc -l) -gt 0 ] ; then
    rfkill unblock wifi
    notify-send "Enabled Wireless" "connecting to previously used ssid..."
else
    SSID=$(iwgetid -r)
    rfkill block wifi
    notify-send "Disabled Wireless" "disconnected from ${SSID}"
fi
