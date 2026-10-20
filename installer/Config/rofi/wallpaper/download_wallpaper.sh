#!/usr/bin/env bash

source ~/.config/theme/colors/bin.sh
icons="$HOME/.config/rofi/wallpaper/components/icons"
convert "$icons/plus-preview.png" -alpha on -fill "$icon" -colorize 100% "$icons/plus.png"
convert "$icons/moewalls-preview.png" -alpha on -fill "$icon" -colorize 100% "$icons/moewalls.png"

THEME=$(jq -r '.theme' "$HOME/.config/theme/config.json")
DIR_WALLPAPERS="$HOME/.BSPWM/Themes/$THEME/Wallpaper"
ROFI="$HOME/.config/rofi/wallpaper/config.rasi"
CACHE_DIR="/tmp/wallpapers_wallhaven_moewall"

[ ! -d  "$CACHE_DIR" ] &&  mkdir "$CACHE_DIR"

QUERY=$(rofi -dmenu -p "󰥱 $(whoami)" -theme "$ROFI" \
    -theme-str '      
        window {
            width: 640px;
            height: 350px;
        }       
        imagebox{
            background-image:   url("~/.Wallpaper/AppliedWallpaper.png", width);
        } 
        listview {
            background-color: transparent;
        }' \
    < /dev/null)

[ -z "$QUERY" ] && exit 0

QUERY_SLUG=$(echo "$QUERY" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g')
BASE_CACHE="$CACHE_DIR/$QUERY_SLUG"

[ ! -d "$BASE_CACHE/wallhaven/raw" ] && [ ! -d "$BASE_CACHE/wallhaven/processed" ] && mkdir -p "$BASE_CACHE/wallhaven/raw" "$BASE_CACHE/wallhaven/processed"
[ ! -d "$BASE_CACHE/moewall/raw" ] && [ ! -d "$BASE_CACHE/moewall/processed"  ] && mkdir -p "$BASE_CACHE/moewall/raw" "$BASE_CACHE/moewall/processed"

get_optimal_jobs() {
    cpus=$(nproc 2>/dev/null || echo 4)
    echo $(( cpus > 2 ? cpus * 3 / 4 : 2 ))
}

resize_image (){ # 16:9 a 1:1
    local DIR_ORIGIN="$1"
    local DIR_DEST="$2"

    find "$DIR_ORIGIN" -type f -print0 \
    | xargs -0 -P "$(get_optimal_jobs)" -I{} bash -c '
        imagen="$1"; dir="$2"; size="$3"
        name=$(basename "$imagen")
        cache="$dir/$name"
        [ -f "$cache" ] || convert "$imagen" \
            -resize "${size}^" \
            -gravity center \
            -extent "${size}" \
            -quality 88 \
            "$cache"
    ' _ {} "$DIR_DEST" "272x272"
}

PAGE=1

menu_rofi() {
    local input_file="$1"
    local TOTAL="$2"
    rofi -dmenu -input "$input_file" -p "󰥱 $QUERY • Pag $PAGE • Total $TOTAL" \
        -theme "$ROFI" -show-icons -icon-size 272 -mesg "↵ Download   More  󰈆 Esc"
}

moewalls(){
    notify-send -t 2000 "MoeWall: Searching wallpaper [Pag $PAGE]"
    ~/.config/rofi/wallpaper/components/moewall.py --search "$QUERY" "$BASE_CACHE/moewall" "$PAGE" 
    
    if [ ! -f "$BASE_CACHE/moewall/map.json" ]; then
        exit 0
    fi
    
    resize_image "$BASE_CACHE/moewall/raw" "$BASE_CACHE/moewall/processed"
    MENU_FILE=$(mktemp $CACHE_DIR/wall_menu_XXXX.txt)
    printf '\u200bnext_page\000icon\037%s\n'  "$icons/plus.png"  >> "$MENU_FILE"
    
    jq -r '.[] | "\(.title)\t\(.filename)"' "$BASE_CACHE/moewall/map.json" | while IFS=$'\t' read -r TITLE FILENAME; do
            THUMB="$BASE_CACHE/moewall/processed/${FILENAME}.jpg"

            if [ -f "$THUMB" ]; then
                printf '\u200b%s\000icon\037%s\n' "$FILENAME" "$THUMB"
            fi
        done >> "$MENU_FILE"

    TOTAL=$(jq '. | length' "$BASE_CACHE/moewall/map.json")
    SELECTED=$(menu_rofi "$MENU_FILE" "$TOTAL")

    rm -f "$MENU_FILE"
    SELECTED="${SELECTED#$'\u200b'}" 

    case "$SELECTED" in
        "")
            exit 0
            ;;
        "next_page")
            PAGE=$((PAGE + 1))
            moewalls
            ;;
        *)
            notify-send -t 2000 "MoeWall:  Downloading wallpaper"
            ~/.config/rofi/wallpaper/components/moewall.py --download "$SELECTED" "$BASE_CACHE/moewall" "$DIR_WALLPAPERS" "$HOME/.Wallpaper/"
            ;;
    esac        
}

while true; do
    notify-send -t 2000 "WallHaven: Searching Wallpaper [Pag $PAGE]"
    ~/.config/rofi/wallpaper/components/wallhaven.sh "--search" "$QUERY" "$PAGE" "$BASE_CACHE/wallhaven" "$(get_optimal_jobs)"

    if [ -f "$BASE_CACHE/wallhaven/map.json" ]; then    
        resize_image "$BASE_CACHE/wallhaven/raw" "$BASE_CACHE/wallhaven/processed"
        
        MENU_FILE=$(mktemp $CACHE_DIR/wall_menu_XXXX.txt)        
        printf '\u200bmoewalls\000icon\037%s\n' "$icons/moewalls.png" >> "$MENU_FILE"
        printf '\u200bnext_page\000icon\037%s\n'  "$icons/plus.png"  >> "$MENU_FILE"

        jq -r '.[] | .id' "$BASE_CACHE/wallhaven/map.json" | while read -r ID; do
            THUMB="$BASE_CACHE/wallhaven/processed/${ID}.jpg"
            [ -f "$THUMB" ] || continue
            printf '\u200b%s\000icon\037%s\n' "$ID" "$THUMB" >> "$MENU_FILE"
        done

        TOTAL=$(jq '. | length' "$BASE_CACHE/wallhaven/map.json")

        SELECTED=$(menu_rofi "$MENU_FILE" "$TOTAL")
        rm -f "$MENU_FILE"

        SEL_ID=$(printf '%s' "$SELECTED" | sed 's/^\xE2\x80\x8B//')
        
        case "$SEL_ID" in
            "")
                exit 0
                ;;
            "moewalls")
                PAGE=1
                moewalls --search "$QUERY" "$CACHE_DIR/thumbs" "$BASE_CACHE/moewall" "$PAGE" 
                exit 0
                ;;
            "next_page")
                PAGE=$((PAGE + 1))
                continue
                ;;
            *)
                ~/.config/rofi/wallpaper/components/wallhaven.sh "--download" "$SEL_ID" "$QUERY" "$BASE_CACHE/wallhaven" "$DIR_WALLPAPERS"
                exit 0
                ;;
        esac
    else
        moewalls --search "$QUERY" "$CACHE_DIR/thumbs" "$BASE_CACHE/moewall" "$PAGE"  
    fi
    exit 0
done