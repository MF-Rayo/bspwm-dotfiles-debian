#!/bin/bash

STATE_FILE="/tmp/polybar_net_state"
touch "$STATE_FILE"

read -r STATE < "$STATE_FILE" 2>/dev/null || STATE=0

if [[ "$STATE" == "0" ]]; then
    ~/.config/theme/scripts/network/my_ip.sh
else
    ~/.config/theme/scripts/network/speed.sh
fi