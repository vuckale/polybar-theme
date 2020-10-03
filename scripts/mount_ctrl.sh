#!/bin/bash

get_mounted_drive_info(){
    unset DRIVES
    while IFS= read -r LINE; do
    DRIVES+=("${LINE}")
    done < <(lsblk -r | grep /media | cut -d' ' -f 7,8 | cut -d'/' -f 4)
    for drive in ${DRIVES[@]}; do
        echo -e "%{F$FOREGROUND_ALT}󱊟%{F-} %{T8}%{F$FOREGROUND}$drive%{F-}%{T-} \c"
    done
    printf "\n"
}

case "$1" in
    --list)
        get_mounted_drive_info
        ;;
esac
