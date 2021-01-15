#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist)  -  $(playerctl metadata title | cut -c 1-35)"
fi

if [[ $player_status = "Playing" ]]; then
    echo "%{F#ccffffff}   $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#66}   $metadata"
else
    echo ""
fi

