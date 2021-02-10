#!/bin/bash
if [ ! "$( which rfkill )" = "" ]; then
    status=$( rfkill list wifi )
    if [ ! -z "$status" ]; then
        if [ $( echo "$status" | grep "Soft blocked: yes" | wc -l ) -gt 0 ] ; then
            rfkill unblock wifi
            notify-send "wifi-switch.sh" "Enabled Wireless, connecting to previously used ssid..." 2>/dev/null
            # restart polybar
            sleep 5
            ~/.config/polybar/launch.sh
        else
            SSID=$( iwgetid -r )
            rfkill block wifi
            if [ "$SSID" = "" ]; then
                msg="Disabled Wireless"
            else
                msg="Disabled Wireless, disconnected from ${SSID}"
            fi
            notify-send "wifi-switch.sh" "$msg" 2>/dev/null
        fi
    else
        # no wifi
        echo "Y"
    fi
else
    # no rfkill
    echo "X"
fi
