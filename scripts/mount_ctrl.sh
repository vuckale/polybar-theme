#!/bin/bash

get_mounted_drive_info(){
    raw=$(lsblk | grep /media | cut -d' ' -f 1,8,12)
    device_block_and_size=$(echo $raw | cut -d' ' -f 1,2)
    device_name=$(echo $raw | cut -d' ' -f3 | cut -d'/' -f4)
    output=$(echo "$device_block_and_size $device_name")

    if [ -z "$output" ]; then
        echo "empty"
    else
        echo "$output"
    fi
}

case "$1" in
    --list)
        get_mounted_drive_info
        ;;
esac
