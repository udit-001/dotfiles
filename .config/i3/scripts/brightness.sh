#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down


function send_notification {
	if [ "$?" = "0" ]; then
		brightness=$(echo $1 | grep -oP '=> \K.*')
		bar=$(seq -s "─" $(($brightness / 14)) | sed 's/[0-9]//g')
		dunstify -i preferences-system-brightness-lock -t 3000 -r 2593 -u normal "Brightness: ${bar} ${brightness}%"
	else
		brightness=$(/usr/lib/gnome-settings-daemon/gsd-backlight-helper --get-brightness)
		bar=$(seq -s "─" $(($brightness / 14)) | sed 's/[0-9]//g')
		dunstify -i preferences-system-brightness-lock -t 3000 -r 2593 -u normal "Brightness: ${bar} ${brightness}%"
	fi
	#echo $brightness
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    # Send the notification
    #dunstify -i audio-volume-muted-blocking -t 3000 -r 2593 -u normal "    $bar"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	brightness_level=$(brightlight -i 5)> /dev/null
	# Up the volume (+ 5%)
	send_notification "$brightness_level"
	;;
    down)
	brightness_level=$(brightlight -d 5) > /dev/null
	send_notification "$brightness_level"
	;;
esac

