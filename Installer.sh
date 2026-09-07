#!/bin/bash
# ==============================================================================
#  Auto Installer script for BSPWM Environment
#  Created by: r4yx
#  Distro: Debian
#  Date: 20/06/2026
# ==============================================================================
#  Este script automatiza la instalación y configuración del entorno de trabajo
#  con BSPWM. Incluye configuraciones personalizadas, scripts propios, así como
#  modificaciones e integraciones de herramientas y recursos de terceros.
#
#  Este proyecto integra y adapta módulos/configuraciones creadas por otros 
#  autores de la comunidad. Todos los derechos de los componentes
#  de terceros pertenecen a sus respectivos creadores.
# ==============================================================================

w="\033[0;37m"; r="\033[0;31m"; g="\033[0;32m"; y="\033[0;33m"; sb="\033[0;36m"; reset="\033[0m" 

banner() {
clear
echo -e "${w}⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ${r}D"    
echo -e "${w}⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ${r}O"
echo -e "${w}⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡟⢟${r}⢝⢝⢝⢝⢝⢟${w}⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ${r}T"
echo -e "${w}⣿⣿⣿⣿⣿⣿⣿⣿⢟${r}⢕⢕⢌⢢⢡⢑⢕⠕⠕⢕⢕${w}⠏⠄⢏⣺⣿⣿⣿⣿⣿⣿ ${r}F"
echo -e "${w}⣿⣿⣿⣿⣿⣿⢟${r}⢕⢅⢕⢕⢕⢅⢕⢑⢕⢕⢕${w}⡵⠁⡂⠅⠂⠄⠙⣿⣿⣿⣿⣿ ${r}I"
echo -e "${w}⣿⣿⣿⣿⣿⢏${r}⢆⢕⢕⢕⢔⠕⢕⢕⢅⢕⢕${w}⢵⠁⢂⠀⠐⢐⠐⠀⢍⣿⣿⣿⣿ ${r}L"
echo -e "${w}⣿⣿⣿⣿⣟${r}⢅⢕⢑⢕⢅⢕⢕⢕⢕⢑⢅${w}⡵⠋⡀⠄⠠⠨⢀⡬⢜${r}⢾${w}⣿⣿⣿⣿ ${r}E"
echo -e "${w}⣿⣿⣿⣿⣗${r}⢕⣕⡕⢕⢕⢕⢔⢕${w}⠵⢓${w}⠩⠀⢀⢔⢳⢈⠠⠘⡬${r}⡢${w}⣹⣿⣿⣿⣿ ${r}S"
echo -e "${w}⣿⣿⣿⣿⡏${r}⢅${w}⡂⡌⢣${r}⢕⢕${w}⠕⠡⠐⡐⡤⡜⢡⠝⠡⠀⡂⠅⡯${r}⡪${w}⣾⣿⣿⣿⣿ "
echo -e "${w}⣿⣿⣿⣿⣿${r}⣏⣪⠇⢢${w}⢵⣃⠍⡐⡢⠔⣍⠮⠇⠌⡐⡀⠐⢠⠫${r}⣺${w}⣿⣿⣿⣿⣿"
echo -e "${w}⣿⣿⣿⣿⣿⣿⠂⢤${r}⠣${w}⡏⠠⡩⢒⡢⠅⠤⢍⡐⢐⢐⢀⢨${r}⢎${w}⣾⣿⣿⣿⣿⣿⣿ ${r}B"
echo -e "${w}⣿⣿⣿⣿⣿⠃⢲⣿⣧⠧⠋⡤⢊⢐⠨⠈⠀⠌⢆⠄⡀⣾⣿⣿⣿⣿⣿⣿⣿⣿ ${r}S"
echo -e "${w}⣿⣿⣿⣿⣿⡌⠸⣟⣡⣜⢁⢂⢂⢐⠨⢈⢈⢀⣸⡆⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿ ${r}P"
echo -e "${w}⣿⣿⣿⣿⣿⣷⣅⠍⢛⠻⠆⢂⠀⠀⠌⠄⠂⠶⠿⣷⢐⠸⢿⣿⣿⣿⣿⣿⣿⣿ ${r}W"
echo -e "${w}⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣷⣶⣾⣶⣷⣷⣾⣾⣶⣾⣷⣾⣾⣿⣿⣿⣿⣿⣿⣿ ${r}M\n"
}

# Config Spinner
FRAME=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
FRAME_INTERVAL=0.1
declare -a RESUMEN=()

format_time() {
    local secs=$1
    if [ "$secs" -lt 60 ]; then
        echo "${secs}s"
    else
        echo "$((secs / 60))m $((secs % 60))s"
    fi
}

view_status() {
    clear
    banner
    echo ""
    for linea in "${RESUMEN[@]}"; do
        echo -e "$linea"
    done
    echo ""
}

execute() {
    local msg_progress="$1"
    local msg_success="$2"
    shift 2
    local logfile
    logfile=$(mktemp)
    local start_time
    start_time=$(date +%s)

    "$@" >"$logfile" 2>&1 &
    local pid=$!

    tput civis
    while kill -0 "$pid" 2>/dev/null; do
        local now elapsed tiempo
        now=$(date +%s)
        elapsed=$(( now - start_time ))
        tiempo=$(format_time "$elapsed")
        for frame in "${FRAME[@]}"; do
            if ! kill -0 "$pid" 2>/dev/null; then
                break
            fi
            printf "\r${sb}[%s]${y} %s ${sb}(%s)${reset}   " "$frame" "$msg_progress" "$tiempo"
            sleep "$FRAME_INTERVAL"
        done
    done
    tput cnorm

    wait "$pid"
    local exit_code=$?
    local total_time
    total_time=$(format_time "$(( $(date +%s) - start_time ))")

    if [ $exit_code -ne 0 ]; then
        RESUMEN+=("\n${r}[ERROR] ${msg_progress} (${total_time})${reset}")
        view_status
        echo -e "\n${r}[ERROR] Script stopped. Failure log:${reset}\n"
        cat "$logfile"
        rm -f "$logfile"
        exit 1
    fi

    RESUMEN+=("${g}[✔] ${msg_success} ${sb}(${total_time})${reset}\n")
    rm -f "$logfile"
    view_status
}

system_update(){
    sudo apt update -y && sudo apt-get upgrade -y && sudo apt autoremove -y
}

install_packages(){
    local distro=$1

    # Parrot 7
    if [ "$distro" = "parrot" ]; then
        sudo apt install -y -t parrot-backports \
            libatk1.0-dev libatk-bridge2.0-dev libatspi2.0-dev \
            libglib2.0-dev libpango1.0-dev libjson-glib-dev \
            libwayland-dev libwebp-dev seclists
    # Kali 2026.2
    elif [ "$distro" = "kali" ]; then
        sudo apt install -y libdbusmenu-gtk3-4 seclists
    # Debian 13
    else
        sudo apt install -y gawk curl python3-pip net-tools rsync
    fi

    # Paquetes base y entorno BSPWM
    sudo apt install -y \
        bspwm sxhkd rofi feh scrot dunst kitty zsh \
        adwaita-icon-theme xclip numlockx xdotool \
        imagemagick mpv playerctl btop acpi bc jq xxhash \
        bat fzf ranger fastfetch cmatrix locate scrub pipx polybar wireless-tools

    # Dependencias para compilar repositorios
    sudo apt install -y \
        build-essential make gcc autoconf automake libtool meson ninja-build libjpeg-dev libgif-dev \
        pkg-config cmake curl uthash-dev libpulse-dev libxkbcommon-dev libxkbcommon-x11-dev \
        libgtk-3-dev libgtk-layer-shell-dev libdbusmenu-gtk3-dev libdbusmenu-glib-dev \
        libcairo2-dev libpango1.0-dev libgdk-pixbuf-2.0-dev libepoxy-dev \
        libev-dev libpam0g-dev libconfig-dev libdbus-1-dev libpcre2-dev \
        libfftw3-dev libasound2-dev libiniparser-dev libncursesw5-dev \
        libx11-dev libx11-xcb-dev libxext-dev libxrender-dev libxcomposite-dev \
        libxdamage-dev libxfixes-dev libpixman-1-dev libgl1-mesa-dev \
        libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev \
        libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev \
        libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev \
        libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev
}

clone_repositories(){
    mkdir -p ~/github
    cd ~/github
    git clone https://github.com/elkowar/eww.git
    git clone https://github.com/yshui/picom.git
    git clone https://github.com/karlstav/cava.git
    git clone https://github.com/ujjwal96/xwinwrap.git
    git clone https://github.com/Raymo111/i3lock-color.git
    git clone https://github.com/vinceliuice/Qogir-icon-theme.git
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    git clone --recursive https://github.com/akinomyoga/ble.sh.git
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k
}

compiling_repositories(){
    local dir=$1
    local distro=$2

    cd ~/github/ble.sh
    make install PREFIX=$HOME/.local

    cd ~/github/cava
    ./autogen.sh
    ./configure
    make
    sudo make install

    cd ~/github/i3lock-color
    sudo ./install-i3lock-color.sh

    cd ~/github/picom
    git submodule update --init --recursive
    meson setup --buildtype=release build
    ninja -C build
    sudo ninja -C build install

    cd ~/github/Qogir-icon-theme
    ./install.sh
    sudo ./install.sh
    sudo rm -rf /usr/share/icons/default/index.theme
    sudo cp -r $dir/installer/cursor/index.theme /usr/share/icons/default/
    sudo cp -r $dir/installer/cursor/.Xresources ~/.Xresources

    cd ~/github/xwinwrap
    make
    sudo make install

    # Install EWW
    if [[ $distro = "parrot" || $distro = "kali" ]]; then
        sudo apt remove -y rustc cargo || true
    fi
    if ! command -v rustup &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    else
        rustup update
    fi

    echo -e "\n\n${b}[INFO] PATH ~/.cargo/bin\n${reset}"
    if ! echo "$PATH" | grep -q "$HOME/.cargo/bin"; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
        export PATH="$HOME/.cargo/bin:$PATH"
    fi

    cd ~/github/eww
    cargo build --release
    sudo cp target/release/eww /usr/local/bin/
}

config_pulseaudio(){
    systemctl --user stop pipewire pipewire-pulse 2>/dev/null
    systemctl --user disable pipewire pipewire-pulse 2>/dev/null

    sudo apt remove --purge -y pipewire pipewire-audio-client-libraries pipewire-pulse wireplumber 2>/dev/null
    sudo apt install -y pulseaudio pulseaudio-utils
    rm -rf ~/.config/pulse

    pulseaudio --kill 2>/dev/null
    pulseaudio --start
}

install_neovim() {
    sudo apt remove -y neovim 2>/dev/null || true
    rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

    sudo apt install -y tar shellcheck luarocks lua5.1 libgit2-dev nodejs npm

    nvim_file=$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest \
        | jq -r '.assets[] | select(.name=="nvim-linux-x86_64.tar.gz") | .browser_download_url')

    if [ -z "$nvim_file" ]; then
        echo "Failed to get URL Neovim."
        exit 1
    fi

    sudo rm -rf /opt/nvim
    sudo mkdir -p /opt/nvim
    if ! curl -fL "$nvim_file" | sudo tar -xzf - --strip-components=1 -C /opt/nvim; then
        echo "Error downloading or extracting NVIM"
        exit 1
    fi

    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

    sudo rm -rf /root/.config/nvim 2>/dev/null || true
    sudo ln -s "$HOME/.config/nvim" /root/.config/nvim

    /opt/nvim/bin/nvim --headless "+Lazy! sync" +qall || true

    servers=(
        bash-language-server
        lua-language-server
        basedpyright
        clangd
        rust-analyzer
        marksman
        intelephense
    )

    for server in "${servers[@]}"; do
        /opt/nvim/bin/nvim --headless -c "MasonInstall $server" -c "sleep 200m" -c qall || true
    done
}

themes_config(){
    local dir=$1
    local distro=$2

    # Install lsd
    sudo dpkg -i $dir/installer/lsd.deb

    # HackNerdFonts and Polybar fonts
    sudo cp -v $dir/installer/fonts/HNF/* /usr/local/share/fonts/
    sudo cp -v $dir/installer/fonts/polybar/* /usr/share/fonts/truetype/

    # Themes Setup
    cp -rv $dir/installer/Config/* ~/.config/

    # Config .p10k.zsh and .zshrc
    rm -rf ~/.zshrc
    cp -v $dir/installer/.zshrc ~/.zshrc && chmod +x ~/.zshrc
    cp -v $dir/Themes/Nord/.p10k.zsh ~/.p10k.zsh
    sudo cp -v $dir/installer/.p10k.zsh-root /root/.p10k.zsh

    # Bashrc
    cp -v $dir/installer/.bashrc ~/.bashrc && chmod +x ~/.bashrc

    # Notify
    cp -rf $dir/installer/Config/dunst/ ~/.config/

    # Scripts
    sudo cp -v $dir/installer/scripts/* /usr/local/bin/

    # Plugins ZSH
    sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions

    sudo mkdir -p /usr/share/zsh-sudo
    cd /usr/share/zsh-sudo
    sudo wget -q https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

    if [ "$distro" = "parrot" ]; then
        sudo apt install -y zsh-autocomplete
        sudo chsh -s /usr/bin/zsh
        sudo usermod --shell /usr/bin/zsh root
    else
        sudo bash -c 'echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list.d/tmp-debian.list'
        sudo apt update
        sudo apt install -y xserver-xorg-video-vmware
        sudo rm /etc/apt/sources.list.d/tmp-debian.list
    fi
    
    sudo ln -sfv ~/.zshrc /root/.zshrc
    echo -e '\nexport TERM=xterm-256color' | sudo tee -a /root/.zshrc
    
    for script in settarget settings shortcuts whichSystem.py xwall wifi ccmatrix; do
        sudo chmod +x /usr/local/bin/$script
    done

    # Nord Theme
    cp -r $dir/Themes/Nord/Wallpaper ~/.Wallpaper

    pip install pywal16 --break-system-packages
    pip install cloudscraper --break-system-packages
    pip install revshellgen --break-system-packages
    sudo pipx install git+https://github.com/brightio/penelope

    # Sintaxis en nano
    echo 'include "/usr/share/nano/*.nanorc"' > ~/.nanorc
    sudo sed -i 's/\r$//' /usr/local/bin/shortcuts

    sudo rm -rf ~/github

    chmod +x \
    ~/.config/bin/scripts/*.sh \
    ~/.config/bin/scripts/music/*.sh \
    ~/.config/bin/scripts/net_config/*.sh \
    ~/.config/bin/scripts/color_picker/*.sh \
    ~/.config/bspwm/* \
    ~/.config/eww/*.sh \
    ~/.config/eww/scripts/* \
    ~/.config/i3lock-color/* \
    ~/.config/polybar/*.sh \
    ~/.config/polybar/themes/{Cuts,Lofi,Pacman,Round,Shapes}/*.sh \
    ~/.config/ranger/*.sh \
    ~/.config/rofi/wallpaper/components/* \
    ~/.config/rofi/{notes,wallpaper,music,power_menu,screenshot,themes}/*
}


banner
dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ "$EUID" -eq 0 ]; then
    echo -e "${sb}[!] ${y}Run the installer without ${r}Root.${reset}"
    exit 1
elif grep -q -i "kali" /etc/os-release; then
    echo -e "${sb}[+] ${y}Distro ${sb}Kali Linux${reset}\n"
    distro=kali
elif grep -q -i "parrot" /etc/os-release; then
    echo -e "${sb}[+] ${y}Distro ${g}Parrot OS${reset}\n"
    distro=parrot
elif grep -q -i "debian" /etc/os-release; then
    echo -e "${sb}[+] ${y}Distro ${g}DEBIAN${reset}\n"
    distro=debian
else
    echo -e "\n${y}[WARNING] Distribution not detected or identified${reset}"
    grep -i "^name" /etc/os-release | head -1
    exit 1
fi

echo -e "${sb}[INFO] Sudo credentials required to continue.\n"
sudo -v || { echo -e "\n${r}[ERROR] Failed to authenticate.${reset}"; exit 1; }
banner
while true; do sudo -n true; sleep 50; done &
SUDO_KEEPER_PID=$!
trap "kill $SUDO_KEEPER_PID 2>/dev/null" EXIT

backup_repo() {
    mkdir -p "$HOME/.BSPWM"
    rsync -av --delete "$dir/" "$HOME/.BSPWM" >/dev/null 2>&1
}

execute "Updating system"               "System updated successfully"               system_update
execute "Installing base packages"      "Base packages installed successfully"      install_packages "$distro"
execute "Cloning repositories"          "Repositories cloned successfully"          clone_repositories
execute "Compiling repositories"        "Repositories compiled successfully"        compiling_repositories "$dir" "$distro"
execute "Configuring PulseAudio"        "PulseAudio configured successfully"        config_pulseaudio
execute "Installing Neovim"             "Neovim installed successfully"             install_neovim
execute "Applying theme configuration"  "Theme configuration applied successfully"  themes_config "$dir" "$distro"
execute "Saving backup of repo"         "Backup saved to ~/.BSPWM successfully"     backup_repo
execute "Updating system"               "System updated successfully"               system_update

if [[ $distro = "debian" ]]; then
    sudo apt install lightdm xorg -y
    sudo systemctl enable --now lightdm
    sudo chsh -s /usr/bin/zsh root
fi

echo -e "\n${g}[✔] ${sb}BSPWM ${y}installed successfully${reset}\n"
