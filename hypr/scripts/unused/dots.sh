#!/bin/sh

clear

echo "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
echo "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
echo "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
echo "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
echo "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
echo "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
echo "███████╗ ██████╗██████╗ ██╗██████╗ ████████╗                 "
echo "██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝                 " 
echo "███████╗██║     ██████╔╝██║██████╔╝   ██║                    "
echo "╚════██║██║     ██╔══██╗██║██╔═══╝    ██║                    "
echo "███████║╚██████╗██║  ██║██║██║        ██║                    "
echo "╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝                    "

echo Welcome $USER, what would you like to do today?
echo "a) Add, push and commit dotfiles"
echo "b) Update the dotfiles in ~/.dotfiles"
echo "c) Edit this script"
echo "q) Exit"

read answer

case $answer in

a) mkdir -p ~/.dotfiles
   cd ~/.dotfiles 
   git add --all 
   git commit -m dotfiles
   git push origin main
   clear 
   exec sh "$0" "$@";;

b) rm -rf ~/.dotfiles/* 
   pacman -Qeq > ~/.dotfiles/pacman_Qeq_pkgs
   flatpak list --app --columns=origin --columns=application | awk '{print "flatpak install " $1,$2 " -y"}' > ~/.dotfiles/flatpaks.sh
   mkdir -p ~/.dotfiles/usr/share/sddm/themes/
   mkdir -p ~/.dotfiles/.config/gtk-3.0/
   mkdir -p ~/.dotfiles/Pictures/
   mkdir -p ~/.dotfiles/.jd/
   mkdir -p ~/.dotfiles/.jd/themes/
   mkdir -p ~/.dotfiles/.local/share/applications/
   cp -r ~/.config/gtk-3.0/bookmarks ~/.dotfiles/.config/gtk-3.0/
   cp -r ~/.zshrc ~/.dotfiles/
   cp -r ~/.zsh_history ~/.dotfiles/
   cp -r ~/.bashrc ~/.dotfiles/
   cp -r ~/.bash_history ~/.dotfiles/
   cp -r ~/.config/mimeapps.list ~/.dotfiles/.config/
   cp -r ~/.config/hypr ~/.dotfiles/.config/
   cp -r ~/.config/kitty ~/.dotfiles/.config/ 
   cp -r ~/.config/swaync ~/.dotfiles/.config/ 
   cp -r ~/.config/swaync-widgets ~/.dotfiles/.config/ 
   cp -r ~/.jd/cfg ~/.dotfiles/.jd/
   cp -r ~/.jd/themes/minimal ~/.dotfiles/.jd/themes/
   cp -r ~/.config/yazi ~/.dotfiles/.config/
   cp -r ~/.config/rofi ~/.dotfiles/.config/ 
   cp -r ~/.config/waybar ~/.dotfiles/.config/ 
   cp -r ~/.config/cava ~/.dotfiles/.config/ 
   cp -r ~/.config/btop ~/.dotfiles/.config/ 
   # cp -r ~/.config/Kvantum ~/.dotfiles/.config/ 
   cp -r ~/.config/mpv ~/.dotfiles/.config/ 
   cp -r ~/.config/nwg-dock-hyprland ~/.dotfiles/.config/ 
   cp -r ~/.config/swayosd ~/.dotfiles/.config/ 
   cp -r ~/.config/wlogout ~/.dotfiles/.config/ 
   cp -r ~/.config/starship.toml ~/.dotfiles/.config/ 
   cp -r ~/.local/share/applications ~/.dotfiles/.local/share/
   cp -r ~/Pictures/icons ~/.dotfiles/Pictures/
   cp -r ~/Pictures/Wallpapers ~/.dotfiles/Pictures/
   cp -r /usr/share/sddm/themes/TerminalStyleLogin ~/.dotfiles/usr/share/sddm/themes/
   clear
   exec sh "$0" "$@";;

c) micro ~/.config/hypr/scripts/dots.sh && clear && exec sh "$0" "$@";;

q) clear && echo Goodbye!;;
*) echo Not one of the choices && sleep 2 && clear && exec sh "$0" "$@";;
esac
