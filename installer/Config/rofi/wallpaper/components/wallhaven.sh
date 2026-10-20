#!/usr/bin/env bash

API_KEY=$(jq -r '.api.wallhaven' "$HOME/.config/theme/config.json")

case "$1" in 

    --search)
        QUERY="$2"
        PAGE="$3"
        DIR_DEST="$4"
        CPU="$5"

        RESPONSE=$(curl -sf "https://wallhaven.cc/api/v1/search" --get --data-urlencode "q=$QUERY" \
            --data-urlencode "categories=111" --data-urlencode "purity=100" --data-urlencode "sorting=relevance" \
            --data-urlencode "ratios=16x9,16x10" --data-urlencode "atleast=1920x1080" \
            --data-urlencode "per_page=36" --data-urlencode "page=$PAGE" -H "X-API-Key: $API_KEY")

        if echo "$RESPONSE" | grep -q '"data":\[\]'; then
            notify-send -t 1500 "WallHaven: No results found for wallpapers of $QUERY"
            exit 0
        else
            rm -rf "$DIR_DEST/map.json"
            echo "$RESPONSE" | jq '[.data[] | {id: .id, thumb: .thumbs.small, full: .path}]' > "$DIR_DEST/map.json"

            export DIR_DEST

            jq -r '.[] | "\(.id)\t\(.thumb)"' "$DIR_DEST/map.json" | xargs -P "$CPU" -I{} bash -c '
            IFS=$'\''\t'\'' read -r id url <<< "{}"
            dest="$DIR_DEST/raw/${id}.jpg"
            [ -f "$dest" ] || curl -sf -o "$dest" "$url"
        '
        fi
        ;;

    --download)
        ID="$2"
        QUERY="$3"
        DIR_JSON="$4"
        DIR_DEST="$5"
        
        URL=$(jq -r --arg id "$ID" '.[] | select(.id == $id) | .full' "$DIR_JSON/map.json")
        name=$(echo "$QUERY" | tr ' ' '_' | tr [:upper:] [:lower:])

        EXT="${URL##*.}"
        NEXT_NUM=$(ls "$DIR_DEST" 2>/dev/null \
            | grep -E "^${name}[0-9]+\." | wc -l)
        
        NEXT_NUM=$((NEXT_NUM + 1))
        DEST="$DIR_DEST/$name${NEXT_NUM}.${EXT}"

        if [ ! -f "$DEST" ]; then
            notify-send -t 2000 "WallHaven: 󱧫 Downloading wallpaper"
            curl -sf -H "X-API-Key: $API_KEY" -o "$DEST" "$URL" \
                || notify-send -t 2000 "WallHaven: 󱧫 Error Downloading wallpaper'"
        fi
        cp -r "$DEST" "$HOME/.Wallpaper/"
        notify-send -t 2000 "WallHaven: 󱧫 Downloaded wallpaper"
        ;;
esac