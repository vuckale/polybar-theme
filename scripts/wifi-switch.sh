#!/bin/bash
if [ $(rfkill list wifi | grep "Soft blocked: yes" | wc -l) -gt 0 ] ; then
    rfkill unblock wifi
    notify-send "wifi-switch.sh" "Enabled Wireless, connecting to previously used ssid..."
else
    SSID=$(iwgetid -r)
    rfkill block wifi
    if [ "$SSID" = "" ]; then
	msg="Disabled Wireless"
    else
	msg="Disabled Wireless, disconnected from ${SSID}"
    fi
    notify-send "wifi-switch.sh" "$msg"
fi
