#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

HWMON_PATH=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "coretemp: Core 0" | awk -F' ' '{print $4}')
export HWMON_PATH

COLOR="autumn_var3.ini"

BACKGROUND=$(grep "background "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
export BACKGROUND

FOREGROUND=$(grep "foreground "  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
export FOREGROUND

FOREGROUND_ALT=$(grep "foreground-alt"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
export FOREGROUND_ALT

ALERT=$(grep "alert"  ~/.config/polybar/colors/$COLOR | cut -d'=' -f2 | sed 's/ //g')
export ALERT

DATE_MODULE_HELPER="%{F$FOREGROUND_ALT}󰑄%{F-} %H:%M"
export DATE_MODULE_HELPER

DATE_MODULE_HELPER_ALT="%{F$FOREGROUND_ALT}󰑄 %{A1:gnome-control-center datetime:}󰃰%{A}%{F-} %H:%M:%S"
export DATE_MODULE_HELPER_ALT

DATE_MODULE_CALENDAR="%a %b %d %Y %{A1:gnome-calendar:}%{F$FOREGROUND_ALT}󰃭%{F-}%{A}"
export DATE_MODULE_CALENDAR

# Launch top-left, top and top-right
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
polybar --config=~/.config/polybar/config.ini top-left >>/tmp/polybar1.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top >>/tmp/polybar2.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top-right >>/tmp/polybar3.log 2>&1 & disown
echo "Launched polybar..."
