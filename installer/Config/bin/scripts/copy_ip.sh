#!/bin/bash
export DISPLAY=:0
export XAUTHORITY="/home/$(whoami)/.Xauthority"
source ~/.config/bin/scripts/net_config/get_interface.sh

json="$HOME/.target.json"
vpn=$(/usr/sbin/ifconfig tun0 2>/dev/null | grep "inet " | awk '{print $2}')

case $1 in
    --myip)
        if [ -n "$vpn" ]; then
            sleep 0.3
            xdotool type "$vpn"
        else
            my_ip=$(/usr/sbin/ifconfig "$ACTIVE_INTERFACE" | grep "inet " | awk '{print $2}')
            sleep 0.3
            xdotool type "$my_ip"
        fi
        exit 0
        ;;
    --target)
        target=$(jq -r --argjson id "$(jq '.target | tonumber' "$json")" '.items[] | select(.id == $id) | .target' "$json")
        IP=$(echo "$target" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
        if [ -n "$IP" ]; then
            sleep 0.3
            xdotool type "$IP"
        fi
        exit 0
        ;;
esac