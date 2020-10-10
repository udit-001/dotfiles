#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 6)) | sed 's/[0-9]//g')
    # Send the notification
    #dunstify -i audio-volume-muted-blocking -t 3000 -r 2593 -u normal "    $bar"
    dunstify -i stock_volume -t 3000 -r 2593 -u normal "Volume: ${bar} ${volume}%"
	canberra-gtk-play -i audio-volume-change -d "changeVolume"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 3%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 3%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
	    dunstify -i audio-volume-muted -t 3000 -r 2593 -u normal "Volume Muted"
	else
	    send_notification
	fi
	;;
esac

