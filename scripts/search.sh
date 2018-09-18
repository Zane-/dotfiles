#!/bin/bash

rofi=`rofi -dmenu -i -lines 0  -font "Roboto Mono for Powerline 11" -hide-scrollbar -columns 1 -width 30 -location 0 -dpi 200 -p search -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print}'`

if [[ -n $rofi ]]; then
	xdg-open "https://www.google.com/search?q=$rofi"
fi
