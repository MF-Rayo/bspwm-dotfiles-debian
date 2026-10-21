#!/bin/sh
export PATH="$HOME/.local/bin:$HOME/.fzf/bin:/opt/kitty/bin:/opt/nvim/bin:/snap/bin:/usr/local/bin:/usr/bin:/bin"

# Config 
TOP=$(jq -r '.bspwmrc.top_padding' "$HOME/.config/theme/config.json")
SCRATCHPAD_NAME="bspwm-scratch"
MAX_WIDTH_PERCENT=70
HEIGHT_PERCENT=35
LIBGL_ALWAYS_SOFTWARE=1 
export LIBGL_ALWAYS_SOFTWARE

# Una sola llamada a jq, parseo en bloque
get_monitor_geometry() {
    read -r SCREEN_WIDTH SCREEN_HEIGHT MONITOR_X MONITOR_Y <<EOF
$(bspc query -T -m focused | jq -r '.rectangle | "\(.width) \(.height) \(.x) \(.y)"')
EOF
}

calculate_position() {
    WIDTH=$((SCREEN_WIDTH * MAX_WIDTH_PERCENT / 100))
    HEIGHT=$((SCREEN_HEIGHT * HEIGHT_PERCENT / 100))
    X_POS=$((MONITOR_X + (SCREEN_WIDTH - WIDTH) / 2))
    Y_POS=$TOP
}

# Busca el ID sin subshell innecesaria — sale al primer match
get_scratchpad_id() {
    for node in $(bspc query -N -n ".floating"); do
        class=$(xprop -id "$node" WM_CLASS 2>/dev/null) || continue
        case "$class" in
            *"$SCRATCHPAD_NAME"*) printf '%s' "$node"; return ;;
        esac
    done
}

get_monitor_geometry
calculate_position
WINDOW_ID=$(get_scratchpad_id)

if [ -n "$WINDOW_ID" ]; then
    HIDDEN=$(bspc query -T -n "$WINDOW_ID" | jq -r '.hidden')
    if [ "$HIDDEN" = "false" ]; then
        bspc node "$WINDOW_ID" -g hidden
    else
        bspc node "$WINDOW_ID" -m focused
        xdo move   -x "$X_POS" -y "$Y_POS" "$WINDOW_ID"
        xdo resize -w "$WIDTH"  -h "$HEIGHT"  "$WINDOW_ID"
        bspc node "$WINDOW_ID" -g hidden=off -f
    fi
else
    bspc rule -a "$SCRATCHPAD_NAME" \
        state=floating sticky=on layer=above \
        rectangle="${WIDTH}x${HEIGHT}+${X_POS}+${Y_POS}" \
        --one-shot

    kitty --class="$SCRATCHPAD_NAME" &

    # Espera activa: máx 1s, sale en cuanto aparezca la ventana
    i=0
    while [ $i -lt 20 ]; do
        WINDOW_ID=$(get_scratchpad_id)
        [ -n "$WINDOW_ID" ] && break
        sleep 0.05
        i=$((i + 1))
    done

    [ -n "$WINDOW_ID" ] && {
        xdo move   -x "$X_POS" -y "$Y_POS" "$WINDOW_ID"
        xdo resize -w "$WIDTH"  -h "$HEIGHT"  "$WINDOW_ID"
    }
fi

# Monitor focus (opcional): solo si realmente lo usas
# Comenta este bloque si no trabajas con múltiples monitores
bspc subscribe monitor_focus | while read -r _; do
    get_monitor_geometry
    calculate_position
    WID=$(get_scratchpad_id)
    [ -z "$WID" ] && continue
    STATE=$(bspc query -T -n "$WID" | jq -r '.client.state')
    [ "$STATE" = "floating" ] || continue
    bspc node "$WID" -m focused
    xdo move   -x "$X_POS" -y "$Y_POS" "$WID"
    xdo resize -w "$WIDTH"  -h "$HEIGHT"  "$WID"
done &