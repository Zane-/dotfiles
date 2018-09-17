#!/bin/bash

rofi=`echo -e "$(task list | awk '{if(NR>3)print}' | head -n -2)" | rofi -dmenu -i -lines 10 -font "Roboto Mono for Powerline 9" -hide-scrollbar -columns 1 -width 35 -location 1 -xoffset 202 -yoffset 56 -dpi 180 -p tasks -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print}'`

echo $rofi

first="$(echo $rofi | head -c 2)"
re='^[0-9]+ '
if ! [[ $first =~ $re ]]; then
	task add $rofi
else
	task $first done
fi
