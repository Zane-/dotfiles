#!/bin/bash

cd ~

rofi=`rofi -dmenu -i -lines 0  -font "Roboto Mono for Powerline 9" -hide-scrollbar -columns 1 -width 33 -location 3 -yoffset 56 -dpi 180 -p shell -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print}'`

exec $rofi
