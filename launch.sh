#!/usr/bin/env bash
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

# Exporting variables
export BACKGROUND FOREGROUND FOREGROUND_ALT ALERT DATE_MODULE_HELPER DATE_MODULE_HELPER_ALT DATE_MODULE_CALENDAR HWMON_PATH

# Launch top-left, top and top-right
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
polybar --config=~/.config/polybar/config.ini top-left >>/tmp/polybar1.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top >>/tmp/polybar2.log 2>&1 & disown
polybar --config=~/.config/polybar/config.ini top-right >>/tmp/polybar3.log 2>&1 & disown
echo "Launched polybar..."
