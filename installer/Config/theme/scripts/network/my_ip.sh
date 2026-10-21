#!/bin/bash

source ~/.config/theme/colors/bin.sh 
source ~/.config/bin/scripts/net_config/get_interface.sh

if [ -n "$ACTIVE_INTERFACE" ]; then
    IP=$(/usr/sbin/ifconfig "$ACTIVE_INTERFACE" | grep "inet " | awk '{print $2}')
    
    if [ $IS_WIRELESS = "true" ]; then
        SSID=$(/usr/sbin/iwgetid -r)
        echo "%{F$icon}直 %{F$fg_icon}$SSID %{F$fg_icon}- %{F$fg_icon}$IP%{u-}"
    else    
        echo "%{F$icon} %{F$fg_icon}$IP%{u-}"
    fi
else    
    echo "%{F$icon} No IP%{u-}"
fi