#!/bin/bash

get_active_interface() {
    if command -v ip &>/dev/null; then
        local interface=$(ip route show default 2>/dev/null | awk '/default/ {print $5}')
        if [ -n "$interface" ] && ip addr show "$interface" 2>/dev/null | grep -q "inet "; then
            echo "$interface"
            return 0
        fi
    fi
    if command -v route &>/dev/null; then
        local interface=$(route -n 2>/dev/null | awk '$1 == "0.0.0.0" {print $8; exit}')
        [ -n "$interface" ] && echo "$interface" && return 0
    fi
    echo ""
}

interface=$(get_active_interface)

ifstat -i ${interface} 1 1 | awk 'NR==3 {printf "%.1f↓\n%.1f↑\n", $1/1024, $2/1024}'