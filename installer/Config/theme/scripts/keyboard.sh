#!/bin/bash
current=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$current" = "us" ]; then
    setxkbmap latam
    notify-send -t 1500 " Keyboard ES (Latam)"
else
    setxkbmap us
    notify-send -t 1500 " Keyboard US"
fi