#!/bin/bash
source ~/.config/theme/colors/bin.sh 

polybar=$(jq -r '.polybar' "$HOME/.config/theme/config.json")
IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')

icon_htb=""

if [ "$IFACE" = "tun0" ]; then
        echo "%{F$HTB_active}${icon_htb} $(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')%{u-}"
else
        if [[ "$polybar" = "Pacman" || "$polybar" = "Forest" ]] ; then
                echo "" && exit
        else
                echo "%{F$icon}%{u-} Disconnected" && exit
        fi
fi
