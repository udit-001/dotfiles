#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar top -c /home/$USER/.config/polybar/themes/space/config &
polybar bottom -c /home/$USER/.config/polybar/themes/space/config &

echo "Bars launched..."
