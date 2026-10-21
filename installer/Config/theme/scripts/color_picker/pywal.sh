#!/bin/sh

case "$1" in
    --dir)
        file="$2"
        ~/.local/bin/wal -i "$file" -s --cols16
        echo "$file"
        ;;
    *)
        ~/.local/bin/wal -i ~/.Wallpaper/AppliedWallpaper.png -s --cols16
        ;;
esac   

. ~/.cache/wal/colors.sh

hex2dec() {
    printf "%d" "0x$1"
}

#extrae par de caracteres
hex_component() {
    printf "%s" "$1" | cut -c$2-$3
}

generar_shades() {
    hex="${1#\#}"
    r=$(hex2dec "$(hex_component "$hex" 1 2)")
    g=$(hex2dec "$(hex_component "$hex" 3 4)")
    b=$(hex2dec "$(hex_component "$hex" 5 6)")

    for p in 0 2 6 10; do
        rn=$(( r + (255 - r) * p / 100 ))
        gn=$(( g + (255 - g) * p / 100 ))
        bn=$(( b + (255 - b) * p / 100 ))
        printf "#%02X%02X%02X " "$rn" "$gn" "$bn"
    done
}

set -- $(generar_shades "$color0")
color_shade1=$1
color_shade2=$2
color_shade3=$3
color_shade4=$4

cat > ~/.BSPWM/Themes/ZeroColor/colors/bin.sh << EOF
#░█████╗░░█████╗░██╗░░░░░░█████╗░██████╗░░██████╗
#██╔══██╗██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔════╝
#██║░░╚═╝██║░░██║██║░░░░░██║░░██║██████╔╝╚█████╗░
#██║░░██╗██║░░██║██║░░░░░██║░░██║██╔══██╗░╚═══██╗
#╚█████╔╝╚█████╔╝███████╗╚█████╔╝██║░░██║██████╔╝
#░╚════╝░░╚════╝░╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

#Scripts
icon="${color1}"
fg_icon="${color7}"
HTB_active="${color1}"
play="${color1}"
music="${color1}"

#i3lock-color
bg='${color0}'
highlight='${color1}'
bg_alt='${color2}'
fg='${color7}'
fg_dim='#b3b9b8'
text='#dadada'
border='#b3b9b8'
error='#e06e6e'
line='#b3b9b8'
indicator='#8ccf7e'
warning='#e5c76b'
accent='#c47fd5'
alpha='dd'


# Cava gradient
cava_fg='${color0}'
cava_g1='${color0}' 
cava_g2='${color3}' 
cava_g3='${color8}'


#others
cmatrix='white'
ranger_border='white'
fastfetch='white'


#bspwmrc
focused_border="${color1}"
normal_border="#3e3e3e"


#dunst
dusnt_bd="${color1}"
dusnt_bg="${color0}"
dusnt_fg="${color7}"
EOF


cat > ~/.BSPWM/Themes/ZeroColor/colors/eww.scss << EOF
//_____________      __  __      __ 
//\_   _____/  \    /  \/  \    /  
// |    __)_\   \/\/   /\   \/\/   /
// |                  /  \        / 
///_______  / \__/\  /    \__/\  /  
//        \/       \/          \/   
// ZERO COLOR ----------------------


\$bg: ${color0};
\$bg-alt: ${color_shade3};
\$fg: ${color7};

\$icon: #0f94d2;
\$launcher: ${color1};

\$workspacefocus: #e0af68;
\$workspaceoccupied: ${color1};
\$workspaceempty: ${color1};


//----------------------------------

\$red: #dd6777;
\$gray: #3A404E;
\$blue: #7aa2f7;
\$cyan: ${color1};
\$magenta: #c296eb;
\$green: #90ceaa;
\$yellow: #e0af68;
EOF


cat > ~/.BSPWM/Themes/ZeroColor/colors/polybar.ini << EOF
;; ┌────────────────────────────────────────────────────────────┐
;; │░█▀█░█▀█░█░░░█░█░█▀▄░█▀█░█▀▄░░░░░░░░░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀│
;; │░█▀▀░█░█░█░░░░█░░█▀▄░█▀█░█▀▄░░░░▀░░░░█░░░█░█░█░░░█░█░█▀▄░▀▀█│
;; │░▀░░░▀▀▀░▀▀▀░░▀░░▀▀░░▀░▀░▀░▀░░░░▀░░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀│
;; └────────────────────────────────────────────────────────────┘


[color]
bg = ${color0}
fg = ${color7}
fg-alt = ${color1}

transparent = #40000000
launch = ${color1}

active_space = ${color1}
inactive_space = ${color7}
ac = #FEC006


;Cuts
volume_level = ${color7}
volume_full = ${color1}

;Shapes
shade1 = ${color0}
shade2 = ${color_shade2}
shade3 = ${color_shade3}
shade4 = ${color_shade4}

;Pacman
mb = ${color_shade3}
pacman = #e0af68
ghost = ${color1}
points = ${color1}
power = ${color1}

pc_cpu = ${color1}
pc_ram = ${color1}
volume = ${color1}
play   = ${color1}
play_alt = ${color1}

EOF

cat > ~/.BSPWM/Themes/ZeroColor/colors/rofi.rasi << EOF
* {
    font: "JetBrainsMono NF Bold 9";
    background: ${color0};
    background-alt: ${color_shade3};
    foreground: ${color7};
    selected: ${color1};
    active: #9ece6a;
    urgent: ${color2};
}
EOF


cat > ~/.BSPWM/Themes/ZeroColor/colors/p10k-colors.zsh << EOF
ICON_FG='${color0}'
ICON_BG='${color1}'

DIR_FG='${color7}'
DIR_BG='${color0}'
EOF

cat > ~/.BSPWM/Themes/ZeroColor/colors/kitty.ini << EOF
background #000000
active_tab_background ${color1}
active_tab_foreground ${color0}
inactive_tab_background ${color0}
inactive_tab_foreground ${color7}
EOF