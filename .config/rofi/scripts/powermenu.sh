#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"

### Options ###
lock=""
suspend=""
power_off=""
reboot=""
log_out=""
# Variable passed to rofi
options="$lock\n$suspend\n$power_off\n$reboot\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu)"
case $chosen in
    $lock)
        playerctl pause
        $HOME/.config/i3/Scripts/volume.sh mute && betterlockscreen -l dimblur -t 'I am SHERlocked!' mode "default"
        ;;
    $suspend)
        mpc -q pause
        amixer set Master mute
        #systemctl suspend
        xfce4-session-logout --suspend
        ;;
    $power_off)
        #systemctl poweroff
        i3-msg [class="."] kill && dunstify -i system-shutdown -u critical 'Power Off' 'The system will power off in 20s.', sleep 20s && systemctl poweroff -i
        ;;
    $reboot)
        #systemctl reboot
        i3-msg [class="."] kill && dunstify -u critical 'Reboot' 'The system will reboot in 20s.', exec sleep 20s && systemctl reboot
        ;;
    $log_out)
        #i3-msg exit
        i3-msg [class="."] kill && i3-msg exit
        ;;
esac

