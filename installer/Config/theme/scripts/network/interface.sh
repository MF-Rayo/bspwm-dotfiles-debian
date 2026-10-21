#!/usr/bin/env bash

ACTIVE_INTERFACE=""
IS_WIRELESS=false

for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -E '^e'); do
    if ip addr show "$iface" 2>/dev/null | grep -q "inet "; then
        ACTIVE_INTERFACE="$iface"
        break
    fi
done

if [ -z "$ACTIVE_INTERFACE" ]; then
    for iface in $(/usr/sbin/ifconfig -a | grep -o '^wl[^:]*'); do
        if /usr/sbin/ifconfig "$iface" 2>/dev/null | grep -q "inet "; then
            ACTIVE_INTERFACE="$iface"
            IS_WIRELESS=true
            break
        fi
    done
fi