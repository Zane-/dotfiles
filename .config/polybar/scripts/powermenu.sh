#!/bin/sh

POWER="\tLog Out\n\tReboot\n\tPower Off\n\tSuspend"
ROFI=`echo $POWER | rofi -dmenu -i -lines 4 -font "Roboto Mono for Powerline 9" -columns 1 -width 15 -location 3 -yoffset 56 -dpi 180 -p power -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print $1}'`

echo $ROFI

if [ ${#ROFI} -gt 0 ]; then
    case $ROFI in
    Log)
        MESG="Quitting i3..."
        CMD="i3-msg exit"
        ;;
    Power)
        MESG="Powering off..."
        CMD="poweroff"
        ;;
    Reboot)
        MESG="Rebooting..."
        CMD="reboot"
        ;;
	Suspend)
		systemctl suspend
	 	exit 0
		;;
    esac
fi

notify-send "$MESG" && sleep 3 && $CMD
