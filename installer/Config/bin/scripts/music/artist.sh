#!/bin/bash

source ~/.config/theme/colors/bin.sh 
polybar=$(jq -r '.polybar' "$HOME/.config/theme/config.json")

MAX_TOTAL_CHARS=20

format_output() {
    local title="$1" 

    local full_text="${title}"
    if [ ${#full_text} -le $MAX_TOTAL_CHARS ]; then
        echo "$full_text"
        return
    fi

    local max_title=$MAX_TOTAL_CHARS  

    [ ${#title} -gt $max_title ] && title="${title:0:$((max_title - 3))}"

    echo "${title}"
}

title=$(playerctl metadata xesam:title 2>/dev/null)

if [[ -z "$title" ]]; then
    if [[ "$polybar" == "Pacman" || "$polybar" == "Forest" ]]; then
        echo ""
        exit 0
    else    
        echo "  No Music"
        exit 0
    fi
fi

if [[ "$polybar" == "Pacman" ]]; then
    echo "%{F$play}  [ %{F$fg_icon}$(format_output "$title")%{F$play} ]"
else
    echo "  $(format_output "$title")"
fi
