#!/usr/bin/env bash

theme="$HOME/.config/rofi/music/player.rasi"
cover=$(playerctl metadata mpris:artUrl)
cache_dir="$HOME/.cache/rofi-music"
mkdir -p "$cache_dir"

[[ "$cover" =~ "i.ytimg.com" ]] && cover="${cover/hqdefault/maxresdefault}"

img_dest="$HOME/.config/rofi/music/img.png"
fallback="$HOME/.Wallpaper/AppliedWallpaper.png"


if [ -n "$cover" ]; then 
    cache_key=$(echo "$cover" | md5sum | cut -d' ' -f1)
    cache_file="$cache_dir/${cache_key}.png"

    if [ ! -f "$cache_file" ]; then
        if curl -s -L --max-time 3 --connect-timeout 1 \
            -o /tmp/preview_raw.png \
            "${cover}" 2>/dev/null && [ -s /tmp/preview_raw.png ]; then
            
            convert /tmp/preview_raw.png \
                -strip -background none -alpha on +repage \
                "$cache_file" 2>/dev/null || cp "$fallback" "$cache_file"
        else
            cp "$fallback" "$cache_file"
        fi
    fi
    ln -sf "$cache_file" "$img_dest"
else
    ln -sf "$fallback" "$img_dest"
fi

status="$(playerctl status 2>/dev/null)"

if [[ -z "$status" ]]; then
	mesg="Offline"
else
	prompt="$(playerctl metadata artist 2>/dev/null)"
	mesg="$(playerctl metadata title 2>/dev/null) - $status"
fi

[[ "$status" == "Playing" ]] && option_1="" || option_1=""
option_2=""
option_3=""
option_4=""
option_5=""
option_6=""

active=""
urgent=""

repeat_status="$(playerctl loop 2>/dev/null)"
shuffle_status="$(playerctl shuffle 2>/dev/null)"

[[ "$repeat_status" == "Track" || "$repeat_status" == "Playlist" ]] && active="-a 4" || urgent="-u 4"
[[ "$shuffle_status" == "On" ]] && active="${active:+$active,}5" || urgent="${urgent:+$urgent,}5"


rofi_cmd() {
	rofi -theme-str "listview {columns: 6; lines: 1;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme "$theme"
}

run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

run_cmd() {
	case "$1" in
		--opt1) playerctl play-pause ;;
		--opt2) playerctl stop ;;
		--opt3) playerctl previous ;;
		--opt4) playerctl next ;;
		--opt5) playerctl loop ;;
		--opt6) playerctl shuffle ;;
	esac
}

chosen="$(run_rofi)"

case "$chosen" in
	$option_1) run_cmd --opt1 ;;
	$option_2) run_cmd --opt2 ;;
	$option_3) run_cmd --opt3 ;;
	$option_4) run_cmd --opt4 ;;
	$option_5) run_cmd --opt5 ;;
	$option_6) run_cmd --opt6 ;;
esac