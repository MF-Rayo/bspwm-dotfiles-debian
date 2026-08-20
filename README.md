# Dotfiles & BSPWM Installer for Debian

<img width="1774" height="887" alt="Image" src="https://github.com/user-attachments/assets/a3591174-c3aa-4bf3-884f-56ccbd255f9a" />

An automated installation script to deploy a fully customized BSPWM desktop environment. This setup includes a choice of two shells, attractive desktop widgets, keyboard shortcuts, and dynamic color extraction from wallpapers on Debian based distributions.

## Table of Contents

- [Features](#features)
- [Installation & Setup](#install)
- [Compatibility](#compatibility)
- [Themes](#themes)
- [Rofi](#rofi)
- [Keybindings](#shortcuts)
- [Api Keys](#apikey)
- [Virtual Machine Setup](#tips)
- [Credits & External Resources](#credits)

---
<a name="features"></a>
## Features

*   **Dual Shell Support:** Interactive choice between **Zsh + Powerlevel10k** or a highly customized **Bashrc**.
*   **Terminal:** Powered by **Kitty** for GPU-accelerated performance and layout splits.
*   **Status Bars & Widgets:** Lightweight **Polybar** navigation combined with beautiful **Eww** bars.
*   **Compositor:** Smooth animations and blur effects using an optimized **Picom** fork.
*   **App Launcher:** Custom **Rofi** menus for application launching, power management, and theme swapping.
*   **Lockscreen:** Secure and blurred locking mechanism via **i3lock**.
*   **Live Wallpapers:** Animated desktop background support using **XWinWrap** and **Feh**.

---

<a name="install"></a>
## Installation & Setup

Run the automated script to install core components, and custom configuration files. 

```bash
# Clone the repository
git clone https://github.com/MF-Rayo/bspwm-dotfiles-debian.git

# Enter the directory and grant execution permissions
cd bspwm-dotfiles-debian && chmod +x Installer.sh

# Run the installer
./Installer.sh
```

## Select desktop environment

### Debian 
<img width="876" height="396" alt="Image" src="https://github.com/user-attachments/assets/f9e6a383-d64c-46cc-a566-a70883b551cc" />

### Kali Linux
<img width="897" height="381" alt="Image" src="https://github.com/user-attachments/assets/1bbd5ed6-f7c0-44f8-96be-8b7698f03700" />

### Parrot OS
<img width="858" height="447" alt="Image" src="https://github.com/user-attachments/assets/f37eadec-2724-474c-aec6-0701cbde9b24" />

---

<a name="compatibility"></a>
## Compatibility

Tested and fully supported on clean installations of the following rolling and stable bases:

### Debian
<img width="1366" height="768" alt="Debian BSPWM Setup" src="https://github.com/user-attachments/assets/bfa4bf49-7872-4906-be71-fa6d73d31b55" />

### Parrot OS
<img width="1366" height="768" alt="Image" src="https://github.com/user-attachments/assets/8789fc63-d7df-4556-8d11-8feef97a2f77" />

### Kali Linux
<img width="1366" height="768" alt="Kali Linux BSPWM Setup" src="https://github.com/user-attachments/assets/8295adf5-2bac-4810-a42d-714411cd80a9" />

---

<a name="themes"></a>
## Themes

Switch between built-in color schemes directly through the Rofi selector interface:

| Themes |
| :---: |
| **Nord** <br> <img width="100%" alt="Nord Theme" src="https://github.com/user-attachments/assets/3c526f3a-5b0c-4be7-83d1-3408e15701a7" /> |
| **Purple** <br> <img width="100%" alt="Purple Theme" src="https://github.com/user-attachments/assets/d4fcf6de-c3c5-4a17-8517-fe21928cc02d" /> |
| **Green** <br> <img width="100%" alt="Green Theme" src="https://github.com/user-attachments/assets/a6946ff2-e309-4b8a-87ad-ec7ee173f8ca" /> |
| **Yellow** <br> <img width="100%" alt="Yellow Theme" src="https://github.com/user-attachments/assets/b17c9ad7-a70b-457e-afc3-a6221ec01e36" /> |
| **Blue** <br> <img width="100%" alt="Blue Theme" src="https://github.com/user-attachments/assets/42464cae-4455-42b7-838e-f5596235c4d1" /> |
| **Red** <br> <img width="100%" alt="Red Theme" src="https://github.com/user-attachments/assets/c1b06c3e-1693-4c1f-a45a-8a9d8e7748c5" /> |
| **Black** <br> <img width="100%" alt="Black Theme" src="https://github.com/user-attachments/assets/6d361bcf-f106-48b6-9f56-18c10bff6a81" /> |
| **White** <br> <img width="100%" alt="White Theme" src="https://github.com/user-attachments/assets/c2efdb6a-1938-47f5-b197-a133fe735402" /> |
| **ZeroColor** <br> <img width="100%" alt="ZeroColor Theme" src="https://github.com/user-attachments/assets/2951f0da-cebc-4211-a539-756fbab0b81e" /> |

> [!NOTE]
> The **ZeroColor** theme instantly extracts palette colors from your active wallpaper using [pywal16](https://github.com/eylles/pywal16).

<video width="100%" height="auto" src="https://github.com/user-attachments/assets/66e23de6-dd6f-401b-9d77-880d7111c642"></video>

---

<a name="rofi"></a>
## Rofi

**Selector:** Use `Super` + `Ctrl` + `p` to open the launcher and switch Polybar styles on the fly.

<img width="1917" height="1078" alt="Image" src="https://github.com/user-attachments/assets/341c9286-78d1-40b5-bdb1-96552d52c35c" />

**Selector:** Use `Super` + `Ctrl` + `t` to open the launcher and switch Themes styles on the fly.

<img width="1366" height="768" alt="Image" src="https://github.com/user-attachments/assets/02498d4b-14b3-46fa-8d82-608e9bc44886" />

**Selector:** Use `Super` + `Ctrl` + `w` to open the launcher and switch Wallpaper styles on the fly.

<img width="1153" height="709" alt="Image" src="https://github.com/user-attachments/assets/7d5ebbef-0da1-45e1-8a31-2cb88898e38f" />

**Selector:** Use `Super` + `D` to open the launcher and launch apps on.

<img width="1362" height="572" alt="Image" src="https://github.com/user-attachments/assets/d52205bb-ce5a-4234-8a1d-61c5365f5b28" />

**Selector:** Use `Super` + `M` to open the music preview.

<img width="968" height="607" alt="Image" src="https://github.com/user-attachments/assets/4155c1eb-e7a1-4921-abb8-c64e21560650" />

---

<a name="shortcuts"></a>
# Keybindings & Shortcuts 
---

This guide lists all configured keybindings managed by `sxhkd` for **BSPWM** and system shortcuts.

### Applications & Custom Scripts

| Keybinding | Action / Command | Description |
| :--- | :--- | :--- |
| `Super` + `Return` | `kitty` | Open Terminal (with software GL) |
| `Alt` + `s` | `ScratchPad.sh` | Toggle Scratchpad Window |
| `Shift` + `l` | `i3lock-everblush` | Lock Screen |
| `Super` + `Shift` + `f` | `firefox` | Launch Firefox Web Browser |
| `Super` + `Shift` + `b` | `burpsuite` | Launch Burp Suite |
| `F1` | `copy_ip.sh --myip` | Copy Local IP Address to Clipboard |
| `F2` | `copy_ip.sh --target` | Copy Target IP Address to Clipboard |
| `Super` + `k` | `keyboard.sh` | Switch Keyboard Layout / Settings |
| `Alt` + `r` | `pkill -USR1 -x sxhkd` | Reload `sxhkd` Configuration |

### Rofi Menus & Pickers

| Keybinding | Action / Command | Description |
| :--- | :--- | :--- |
| `Super` + `d` | `apps.rasi` | Application Launcher |
| `Super` + `p` | `power` | Power Menu (Shutdown, Reboot, Lock) |
| `Alt` + `m` | `player.sh` | Music Player Control Menu |
| `Alt` + `n` | `notes` | Quick Notes Menu |
| `Print` | `screenshot` | Take Screenshot Menu |
| `Super` + `Ctrl` + `t` | `ThemeSelect` | Rofi Theme Selector |
| `Super` + `Ctrl` + `w` | `WallSelect` | Wallpaper Selector |
| `Super` + `Ctrl` + `p` | `PolySelect` | Polybar Theme Selector |
| `Super` + `Ctrl` + `d` | `download_wallpaper.sh` | Download Wallpaper Script |

### Window Management (BSPWM)

| Keybinding | Action / Command | Description |
| :--- | :--- | :--- |
| `Super` + `Alt` + `r` | `bspc wm -r` | Restart BSPWM |
| `Super` + `Alt` + `q` | `bspc quit` | Quit BSPWM |
| `Super` + `q` | `bspc node -c` | Close Window |
| `Super` + `Shift` + `q` | `bspc node -k` | Kill Window |
| `Super` + `m` | `bspc desktop -l next` | Toggle Layout (Tiled / Monocle) |
| `Super` + `g` | `bspc node -s biggest.window` | Swap current window with biggest |
| `Super` + `t` | State: `tiled` | Set Window to Tiled |
| `Super` + `Shift` + `t` | State: `pseudo_tiled` | Set Window to Pseudo-Tiled |
| `Super` + `s` | State: `floating` | Set Window to Floating |
| `Super` + `f` | State: `fullscreen` | Toggle Fullscreen |
| `Super` + `Ctrl` + `m` | Flag: `marked` | Toggle Marked Flag |
| `Super` + `Ctrl` + `x` | Flag: `locked` | Toggle Locked Flag |
| `Super` + `Ctrl` + `y` | Flag: `sticky` | Toggle Sticky Flag |
| `Super` + `Ctrl` + `z` | Flag: `private` | Toggle Private Flag |

### Focus, Navigation & Resizing

| Keybinding | Action / Command | Description |
| :--- | :--- | :--- |
| `Super` + `← ↓ ↑ →` | Focus direction | Focus window in given direction |
| `Super` + `Shift` + `← ↓ ↑ →` | Swap direction | Swap window in given direction |
| `Super` + `1-0` | Desktop `1-10` | Switch to Desktop N |
| `Super` + `Shift` + `1-0` | Move to Desktop | Send window to Desktop N |
| `Super` + `Tab` / `` ` `` | Desktop `last` | Switch to last used desktop/node |
| `Super` + `Alt` + `← ↓ ↑ →` | Resize outward | Expand window size |
| `Super` + `Alt` + `Shift` + `← ↓ ↑ →` | Resize inward | Contract window size |
| `Super` + `Ctrl` + `← ↓ ↑ →` | Move floating | Move floating window position |

### Media & Volume Controls

| Keybinding | Command | Description |
| :--- | :--- | :--- |
| `XF86AudioRaiseVolume` | `pactl set-sink-volume +1%` | Volume Up (+1%) |
| `XF86AudioLowerVolume` | `pactl set-sink-volume -1%` | Volume Down (-1%) |
| `XF86AudioMute` | `pactl set-sink-mute toggle` | Mute / Unmute Audio |
| `XF86AudioNext` | `playerctl next` | Next Track |
| `XF86AudioPrev` | `playerctl previous` | Previous Track |
| `XF86AudioPlay` | `playerctl play-pause` | Play / Pause |


---

<a name="apikey"></a>
### API Keys Configuration (Optional)

To enable integration with **OpenWeather** (for weather widgets) and **Wallhaven** (for downloading wallpapers), you need to provide your own API keys.

1. **Get your free API keys:**
    
    - **OpenWeather API:** [openweathermap.org](https://openweathermap.org/)
        
    - **Wallhaven API:** [wallhaven.cc](https://wallhaven.cc)
        
2. **Edit your local configuration file:**
```bash
nvim ~/.config/theme/config.json
```

```json
{
  "theme": "White",
  "polybar": "Cuts",
  "bspwmrc": {
    "left_padding": "4",
    "right_padding": "4",
    "top_padding": "34",
    "bottom_padding": "34",
    "bar": "/home/r4yx/.config/polybar/launch.sh"
  },
  "api": {
    "wallhaven": "YOUR_WALLHAVEN_API_KEY",
    "openweather": "YOUR_OPENWEATHER_API_KEY"
  },
  "city": "YOUR_CITY_NAME"
}
```

----
<a name="tips"></a>
## Virtual Machine Setup

If you are running this environment inside a Virtual Machine, you may experience performance issues, graphical glitches, or lag with window animations. 

> [!NOTE]
> **Note for VMware users:** Go to **Virtual Machine Settings** ➔ **Display** ➔ Check **Accelerate 3D graphics** and increase the **Graphics Memory** slider.

<img width="986" height="422" alt="Image" src="https://github.com/user-attachments/assets/2717b6a1-8084-4a35-acd3-b52b150dc77b" />


### Enabling Battery Passthrough on Laptops (VMware Only)

If you are running VMware on a laptop, the guest OS may not detect your battery status by default (showing `No Battery` in Polybar or system widgets). 

To allow the Virtual Machine to read your host laptop's battery and AC adapter status, follow these steps:

1. **Power off** your Virtual Machine completely.
2. Locate and open your virtual machine's `.vmx` configuration file using a text editor (e.g., `Notepad` or `nano`).
3. Add the following lines at the end of the file:

```ini
batterymeter.enable = "TRUE"
acpi.present = "TRUE"
chipset.useAcpiBattery = "TRUE"
chipset.useApmBattery = "TRUE"
```

> [!NOTE]
> If you do not need audio input inside your VM, you can also disable the microphone completely by adding/editing these parameters in the .vmx file.

```ini
sound.startConnected = "FALSE"
sound.record.enable = "FALSE"
sound.record.autodetect = "FALSE"
```

---
<a name="credits"></a>
## Credits & External Resources

This project integrates tools, configurations, and inspiration from several open-source repositories. Visit the original projects below to learn more about their setup and inner workings:

### Base Inspiration & Configurations
* **[gh0stzk/dotfiles](https://github.com/gh0stzk/dotfiles):** Primary inspiration for adapting the **Polybar** and **EWW** configurations, as well as the design architecture for the theme, wallpaper, and bar selectors.
* **[adi1090x/polybar-themes](https://github.com/adi1090x/polybar-themes):** Source for various Polybar layouts and theme designs.
* **[adi1090x/rofi](https://github.com/adi1090x/rofi):** Source for Rofi themes and menu styles.

---

### Core Tools & Dependencies
* **[polybar/polybar](https://github.com/polybar/polybar):** Fast and easy-to-use status bar.
* **[elkowar/eww](https://github.com/elkowar/eww):** ElKowar's Wacky Widgets for custom desktop popups and widgets.
* **[yshui/picom](https://github.com/yshui/picom):** X compositor for transparency, animations, and shadows.
* **[karlstav/cava](https://github.com/karlstav/cava):** Console-based Audio Visualizer for ALSA / PulseAudio / PipeWire.
* **[ujjwal96/xwinwrap](https://github.com/ujjwal96/xwinwrap):** Utility to allow applications/animated wallpapers as desktop backgrounds.
* **[Raymo111/i3lock-color](https://github.com/Raymo111/i3lock-color):** Feature-rich screen locker with customization support.
* **[vinceliuice/Qogir-icon-theme](https://github.com/vinceliuice/Qogir-icon-theme):** Modern icon theme for Linux desktops.
* **[romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k):** Fast and feature-packed Zsh theme (configured for both standard users and root).
* **[akinomyoga/ble.sh](https://github.com/akinomyoga/ble.sh):** Bash Line Editor for syntax highlighting and enhanced autocompletion.
