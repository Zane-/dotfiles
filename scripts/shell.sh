#!/bin/bash

cd ~

rofi=`rofi -dmenu -i -lines 0  -font "Material Design Icons 9" -hide-scrollbar -columns 1 -width 20 -location 2 -yoffset 56 -dpi 220 -p  -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print}'`

if [[ -n $rofi ]]; then
	exec $rofi
fi
