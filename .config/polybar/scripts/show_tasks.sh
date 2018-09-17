#!/bin/bash

task list > tasks.txt
TASK_1=`sed '4q;d' tasks.txt`
TASK_2=`sed '5q;d' tasks.txt`
TASK_3=`sed '6q;d' tasks.txt`
TASK_4=`sed '7q;d' tasks.txt`
TASK_5=`sed '8q;d' tasks.txt`

TASKS="\t$TASK_1\n\t$TASK_2\n\t$TASK_3\n\t$TASK_4\n\t$TASK_5"
rofi=`echo -e $TASKS | rofi -dmenu -lines 5 -font "Roboto Mono for Powerline 9" -hide-scrollbar -columns 1 -width 35 -location 1 -xoffset 290 -yoffset 56 -dpi 180 -p tasks -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print $1}'`

echo $rofi

if [ ${#rofi} -gt 0 ]; then
    case $rofi in
    1)
		task 1 done
        ;;
    2)
		task 2 done
        ;;
    3)
		task 3 done
        ;;
    4)
		task 4 done
        ;;
    5)
		task 5 done
        ;;
    esac
fi
