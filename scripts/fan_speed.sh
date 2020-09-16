#!/bin/bash
left_fan=$(sensors | grep "Left" | cut -d':' -f2 | cut -d ' ' -f2)
right_fan=$(sensors | grep "Right" | cut -d':' -f2 | cut -d ' ' -f2)
echo "$left_fan %{F$FOREGROUND_ALT}󰈐%{F-} $right_fan"

