#!/bin/bash
source ~/.config/theme/colors/bin.sh 
polybar=$(jq -r '.polybar' "$HOME/.config/theme/config.json")

if [[ "$polybar" = "Forest" || "$polybar" = "Cuts" ]]; then
    DOWN_ARROW=""
    UP_ARROW=""   
elif [[ "$polybar" = "Pacman" ]]; then
    DOWN_ARROW="󰄠"
    UP_ARROW="󰄝"
else
    DOWN_ARROW=""
    UP_ARROW=""
fi

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

format_speed() {
    local bytes=$1 
    awk -v b="$bytes" 'BEGIN {
        if (b < 1024)
            printf "%.1fB/s", b
        else if (b < 1048576)
            printf "%.1fKB/s", b/1024        # Kilobytes
        else if (b < 1073741824)
            printf "%.1fMB/s", b/1048576     # Megabytes
        else
            printf "%.1fGB/s", b/1073741824  # Gigabytes
    }'
}

get_net_bytes() {
    local iface=$1
    awk -v iface="$iface:" '$1 == iface {print $2, $10}' /proc/net/dev
}

INTERFACE=$(get_active_interface)

if [ -z "$INTERFACE" ]; then
    echo "%{F$fg_icon} No Network"
    exit 0
fi

# Primera muestra
read RX1 TX1 < <(get_net_bytes "$INTERFACE")
sleep 1
# Segunda muestra
read RX2 TX2 < <(get_net_bytes "$INTERFACE")

# Bytes por segundo
DOWN_BPS=$(( RX2 - RX1 ))
UP_BPS=$(( TX2 - TX1 ))

# Proteger negativos (reinicio de contador)
[ "$DOWN_BPS" -lt 0 ] && DOWN_BPS=0
[ "$UP_BPS"   -lt 0 ] && UP_BPS=0

DOWNLOAD_FORMATTED=$(format_speed "$DOWN_BPS")
UPLOAD_FORMATTED=$(format_speed "$UP_BPS")

echo "%{F$icon}${DOWN_ARROW} %{F$fg_icon}${DOWNLOAD_FORMATTED} %{F$icon}${UP_ARROW} %{F$fg_icon}${UPLOAD_FORMATTED}"
