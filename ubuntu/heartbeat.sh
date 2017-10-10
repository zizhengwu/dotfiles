#!/bin/bash
while : 
do
    nice -n 1 xdotool key Scroll_Lock
    date +%T ## show some sign of life
    sleep 100
done
