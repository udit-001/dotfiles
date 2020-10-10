#!/bin/bash

state=`synclient -l | fgrep TouchpadOff | sed 's/^.*= //'`
if [ $state -eq 1 ]
then
        dunstify -u normal -t 3000 "Touchpad Enabled"
        synclient TouchpadOff=0
else
        dunstify -u normal -t 3000 "Touchpad Disabled"
        synclient TouchpadOff=1
fi
