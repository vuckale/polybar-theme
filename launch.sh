#!/usr/bin/env bash

# function for calculating tint from given rgb values and factor
calculate_tint() {
    r=$(echo "$1 + (255-$1) * $4" | bc -l | awk '{print int($1)}')
    g=$(echo "$2 + (255-$2) * $4" | bc -l | awk '{print int($1)}')
    b=$(echo "$3 + (255-$3) * $4" | bc -l | awk '{print int($1)}')
    res=$(printf \#%02X%02X%02X $r $g $b)
    echo $res
}

# Terminate already running bar instances
killall -q polybar

# Find path for hwmon (since it may change after reboot)
HWMON_PATH=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "coretemp: Core 0" | awk -F' ' '{print $4}')

# Parsing colors from $COLOR as environment variables
COLOR="autumn_var3.ini"
BACKGROUND=$(grep "background "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
FOREGROUND=$(grep "foreground "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
FOREGROUND_ALT=$(grep "foreground-alt"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
ALERT=$(grep "alert"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
DATE_MODULE_HELPER="%{F$FOREGROUND_ALT}󰑄%{F-} %H:%M"
DATE_MODULE_HELPER_ALT="%{F$FOREGROUND_ALT}󰑄 %{A1:gnome-control-center datetime:}󰃰%{A}%{F-} %H:%M:%S"
DATE_MODULE_CALENDAR="%a %b %d %Y %{A1:gnome-calendar:}%{F$FOREGROUND_ALT}󰃭%{F-}%{A}"

# tint foreground_alt for memory usage
hexinput=`echo "${FOREGROUND_ALT//#}" | tr '[:lower:]' '[:upper:]'` # uppercase-ing
a=`echo $hexinput | cut -c-2`
b=`echo $hexinput | cut -c3-4`
c=`echo $hexinput | cut -c5-6`

r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`

FOREGROUND_ALT_TINT_0=$(echo $(calculate_tint $r $g $b 0.5))
FOREGROUND_ALT_TINT_1=$(echo $(calculate_tint $r $g $b 0.4))
FOREGROUND_ALT_TINT_2=$(echo $(calculate_tint $r $g $b 0.3))
FOREGROUND_ALT_TINT_3=$(echo $(calculate_tint $r $g $b 0.2))

# Exporting variables
export BACKGROUND FOREGROUND FOREGROUND_ALT ALERT DATE_MODULE_HELPER DATE_MODULE_HELPER_ALT DATE_MODULE_CALENDAR HWMON_PATH FOREGROUND_ALT_TINT_0 FOREGROUND_ALT_TINT_1 FOREGROUND_ALT_TINT_2 FOREGROUND_ALT_TINT_3

# Launch top-left, top and top-right
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
polybar --config=~/.config/polybar/config.ini top-left >>/tmp/polybar1.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top >>/tmp/polybar2.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top-right >>/tmp/polybar3.log 2>&1 & disown
echo "Launched polybar..."
