#!/bin/bash
STATE_FILE="/tmp/polybar_net_state"
read -r STATE < "$STATE_FILE" 2>/dev/null || STATE=0
echo $(( (STATE + 1) % 2 )) > "$STATE_FILE"