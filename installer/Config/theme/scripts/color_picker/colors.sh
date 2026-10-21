#!/bin/sh

. ~/.config/theme/colors/bin.sh

cat > ~/.config/cava/config << EOF
[general]
mode = waves
framerate = 60
autosens = 1
sensitivity = 100
bars = 0
bar_width = 2
bar_spacing = 1
lower_cutoff_freq = 50
higher_cutoff_freq = 10000

[input]
method = pulse
source = auto

[output]
method = ncurses
channels = stereo

[color]
background = default
foreground = '$cava_fg'
gradient = 1
gradient_count = 4
gradient_color_1 = '$cava_g1'
gradient_color_2 = '$cava_g2'
gradient_color_3 = '$cava_g3'

[smoothing]
integral = 70
monstercat = 1
waves = 1
gravity = 80
ignore = 0

EOF

cat > ~/.config/fastfetch/config.jsonc << EOF
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "color": {"1": "$fastfetch"},
    "padding": { 
      "top": 2,
      "left": 1,
      "right": 2
    }
  },

  "display": {
    "separator": "  ",
    "color": {
      "keys": "$fastfetch",   
      "title": "$fastfetch"
    }
  },
  "modules": [
    // Title
    {
      "type": "title",
      "format": "{#1}╭───────────── {#}{user-name-colored}"
    },
    // System Information
    {
      "type": "custom",
      "format": "{#1}│ {#}System Information"
    },
    {
      "type": "os",
      "key": "{#separator}│  {#keys}󰍹 OS"
    },
    {
      "type": "kernel",
      "key": "{#separator}│  {#keys}󰒋 Kernel"
    },
    {
      "type": "uptime",
      "key": "{#separator}│  {#keys}󰅐 Uptime"
    },
    {
      "type": "packages",
      "key": "{#separator}│  {#keys}󰏖 Packages",
      "format": "{all}"
    },
    {
      "type": "custom",
      "format": "{#1}│"
    },
    // Desktop Environment
    {
      "type": "custom",
      "format": "{#1}│ {#}Desktop Environment"
    },
    {
      "type": "de",
      "key": "{#separator}│  {#keys}󰧨 DE"
    },
    {
      "type": "wm",
      "key": "{#separator}│  {#keys}󱂬 WM"
    },
    {
      "type": "wmtheme",
      "key": "{#separator}│  {#keys}󰉼 Theme"
    },
    {
      "type": "display",
      "key": "{#separator}│  {#keys}󰹑 Resolution"
    },
    {
      "type": "shell",
      "key": "{#separator}│  {#keys}󰞷 Shell"
    },
    {
      "type": "custom",
      "format": "{#1}│"
    },
    // Hardware Information
    {
      "type": "custom",
      "format": "{#1}│ {#}Hardware Information"
    },
    {
      "type": "cpu",
      "key": "{#separator}│  {#keys}󰻠 CPU"
    },
    {
      "type": "gpu",
      "key": "{#separator}│  {#keys}󰢮 GPU"
    },
    {
      "type": "memory",
      "key": "{#separator}│  {#keys}󰍛 Memory"
    },
    {
      "type": "disk",
      "key": "{#separator}│  {#keys}󰋊 Disk (/)",
      "folders": "/"
    },
    {
      "type": "custom",
      "format": "{#1}│"
    },
    // Colors
    {
      "type": "colors",
      "key": "{#separator}│",
      "symbol": "circle"
    },
    // Footer
    {
      "type": "custom",
      "format": "{#1}╰───────────────────────────────╯"
    }
  ]
}
EOF


cat > ~/.config/dunst/dunstrc << EOF
[global]
monitor = 0
follow = mouse
width = 400
height = (80,80)
offset = (20,60)
scale = 0
origin = top-right
notification_limit = 0
padding = 5
horizontal_padding = 40
frame_width = 2
frame_color = "${BORDER}" 
separator_color = frame
separator_height = 2
transparency = 30
corner_radius = 15

font = JetBrainsMono Nerd Font 10
markup = full
format = "%s %b"
alignment = left
vertical_alignment = center
word_wrap = yes
ignore_newline = no
stack_duplicates = false
hide_duplicate_count = true

icon_position = left
enable_recursive_icon_lookup = true

show_indicators = false
indicate_hidden = yes
shrink = no

timeout = 8

progress_bar = true
progress_bar_height = 6
progress_bar_frame_width = 1
progress_bar_min_width = 150
progress_bar_max_width = 300

[urgency_low]
background = "${dusnt_bg}"     
foreground = "${dusnt_fg}"      
frame_color = "${dusnt_bd}"
timeout = 6
icon = dialog-information

[urgency_normal]
background = "${dusnt_bg}"
foreground = "${dusnt_fg}"
frame_color = "${dusnt_bd}"
timeout = 8
icon = dialog-warning

[urgency_critical]
background = "${dusnt_bg}"
foreground = "${dusnt_fg}"
frame_color = "${dusnt_bd}"
timeout = 0
icon = dialog-error

EOF