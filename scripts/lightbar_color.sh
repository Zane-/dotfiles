#!/bin/sh

ROFI=`rofi -dmenu -i -lines 0 -font "Roboto Mono for Powerline 9" -columns 1 -width 15 -dpi 180 -p color -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print}'`

sudo ectool lightbar seq stop
sudo ectool lightbar 4 $ROFI
