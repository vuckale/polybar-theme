#!/usr/bin/env bash

# clean up before starting a new polybar instance
clean_up() {
    # terminate already running bar instances
    killall -q polybar
}

# function for calculating tint from given rgb values and factor
tint() {
    r=$(echo "$1 + (255-$1) * $4" | bc -l | awk '{print int($1)}')
    g=$(echo "$2 + (255-$2) * $4" | bc -l | awk '{print int($1)}')
    b=$(echo "$3 + (255-$3) * $4" | bc -l | awk '{print int($1)}')
    res=$(printf \#%02X%02X%02X $r $g $b)
    echo $res
}

# parse colors from $COLOR as environment variables and export as env variables
color_env() {
    COLOR="nord.ini"
    BACKGROUND=$(grep "background "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
    FOREGROUND=$(grep "foreground "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
    FOREGROUND_ALT=$(grep "foreground-alt"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
    ALERT=$(grep "alert"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
    DATE_MODULE_HELPER="%{F$FOREGROUND_ALT}󰑄%{F-} %H:%M"
    DATE_MODULE_HELPER_ALT="%{F$FOREGROUND_ALT}󰑄 %{A1:gnome-control-center datetime:}󰃰%{A}%{F-} %H:%M:%S"
    DATE_MODULE_CALENDAR="%a %b %d %Y %{A1:gnome-calendar:}%{F$FOREGROUND_ALT}󰃭%{F-}%{A}"
    # tint foreground_alt for RAM memory usage
    hexinput=`echo "${FOREGROUND//#}" | tr '[:lower:]' '[:upper:]'` # uppercase-ing
    a=`echo $hexinput | cut -c-2`
    b=`echo $hexinput | cut -c3-4`
    c=`echo $hexinput | cut -c5-6`
    r=`echo "ibase=16; $a" | bc`
    g=`echo "ibase=16; $b" | bc`
    b=`echo "ibase=16; $c" | bc`
    FOREGROUND_TINT_0=$(echo $(tint $r $g $b 0.4))
    FOREGROUND_TINT_1=$(echo $(tint $r $g $b 0.3))
    FOREGROUND_TINT_2=$(echo $(tint $r $g $b 0.2))
    FOREGROUND_TINT_3=$(echo $(tint $r $g $b 0.1))
    FOREGROUND_EMPTY=$(echo "#55${FOREGROUND_TINT_0//#}")
    # export variables
    export BACKGROUND FOREGROUND FOREGROUND_ALT ALERT DATE_MODULE_HELPER DATE_MODULE_HELPER_ALT DATE_MODULE_CALENDAR FOREGROUND_TINT_0 FOREGROUND_TINT_1 FOREGROUND_TINT_2 FOREGROUND_TINT_3 FOREGROUND_EMPTY OPEN_WEATHER_API_KEY WEATHER_CHANNEL_PY_URL
}

# find path for hwmon (since it may change after reboot)
hwmon() {
    HWMON_PATH=$( for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "coretemp: Core 0" | awk -F' ' '{print $4}' )
    export HWMON_PATH
}

# launch top-left, top and top-right from config
run() {
    logfile="$HOME/.config/polybar/log.txt"
    current_date_time=$( echo "$(date)" )
    echo "launching polybar: $current_date_time" >> $logfile
    polybar --config=~/.config/polybar/config.ini top-left 2>&1 & disown
    echo "polybar top-left" >> $logfile
    polybar --config=~/.config/polybar/config.ini top 2>&1 & disown
    echo "polybar top" >> $logfile
    polybar --config=~/.config/polybar/config.ini top-right 2>&1 & disown
    echo "polybar top-left" >> $logfile
    echo "finished launching polybar..." >> $logfile
}

# call all above functions in order
main() {
    clean_up
    color_env
    hwmon
    run
}

main
