#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Launch top-left, top and top-right
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
polybar top-left >>/tmp/polybar1.log 2>&1 & disown
polybar top >>/tmp/polybar2.log 2>&1 & disown
polybar top-right >>/tmp/polybar3.log 2>&1 & disown
echo "Launched polybar..."
