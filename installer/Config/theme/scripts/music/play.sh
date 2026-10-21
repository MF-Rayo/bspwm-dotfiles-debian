#!/bin/bash
source ~/.config/theme/colors/bin.sh 
polybar=$(jq -r '.polybar' "$HOME/.config/theme/config.json")

#play/pause
[ "$1" = "--click" ] && playerctl play-pause 2>/dev/null && exit 0

playing=$(playerctl status 2>/dev/null | grep -c "Playing")

[ $playing -eq 0 ] && playing=$(playerctl -l 2>/dev/null | xargs -n1 playerctl status 2>/dev/null | grep -c "Playing")

if [[ "$polybar" == "Pacman" ]]; then
    [ $playing -gt 0 ] && echo "%{F$play}  " || echo "%{F$play}  "
else
    [ $playing -gt 0 ] && echo "" || echo ""
fi