status=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
freq=$(lscpu | awk -F : '($1=="CPU MHz") {printf "%3.2fGHz\n", $2/1000}')
if [ $status = 1 ]; then
	echo "%{F$FOREGROUND_ALT}󰾆%{F-} $freq"
else 
	echo "%{F$FOREGROUND_ALT}󰓅%{F-} $freq"
fi
