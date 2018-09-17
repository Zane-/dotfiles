#!/bin/sh

OPTIONS="\tdefault\n\tcolor\n\trainbow\n\tsiren\n\tpulse\n\t"
ROFI=`echo $OPTIONS | rofi -dmenu -i -lines 5 -font "Roboto Mono for Powerline 9" -columns 1 -width 15 -dpi 180 -p light -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print $1}'`

echo $ROFI

if [ ${#ROFI} -gt 0 ]; then
	sudo kill $(pgrep '(rainbow|siren|pulse).sh')
    case $ROFI in
    default)
        sudo ~/lightbar_scripts/default.sh
        ;;
	color)
		sudo ~/dotfiles/scripts/lightbar_color.sh
		;;
    rainbow)
        sudo ~/lightbar_scripts/rainbow.sh
        ;;
    siren)
        sudo ~/lightbar_scripts/siren.sh
        ;;
	pulse)
        sudo ~/lightbar_scripts/pulse.sh
		;;
    esac
fi

