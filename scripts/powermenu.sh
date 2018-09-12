#!/bin/sh

POWER="\tLog Out\n\tPower Off\n\tReboot\n\tSleep\n\tHibernate"
ROFI=`echo $POWER | rofi -dmenu -lines 5 -font "Roboto Mono for Powerline 9" -columns 1 -width 20 -location 3 -yoffset 56 -dpi 180 -p power -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print $1}'`

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
        MESG="Entering sleep mode..."
        CMD="systemctl suspend"
        ;;
    Hibernate)
        MESG="Hibernating..."
        CMD="systemctl hibernate"
        ;;
    esac
fi

notify-send "$MESG" && sleep 3 && $CMD
