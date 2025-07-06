#!/usr/bin/env bash

clear
cat << "EOF"
██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  
██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  
╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
 ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝
                                                  
███████╗ ██████╗██████╗ ██╗██████╗ ████████╗      
██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝      
███████╗██║     ██████╔╝██║██████╔╝   ██║         
╚════██║██║     ██╔══██╗██║██╔═══╝    ██║         
███████║╚██████╗██║  ██║██║██║        ██║         
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   


EOF

if [ ! -f /etc/arch-release ]; then
    echo "This script only works on Arch-based systems."
    exit 1
fi

pkg_installed() {
    pacman -Qq "$1" &> /dev/null
}

update_system() {
    echo "Starting the system update..."

    echo "Updating Official packages..."
    sudo pacman -Syu

    if pkg_installed yay; then
        echo "Updating AUR packages using yay..."
        yay -Syu
    elif pkg_installed paru; then
        echo "Updating AUR packages using paru..."
        paru -Syu
    else
        echo "AUR helper not installed, skipping AUR updates."
    fi

    if pkg_installed flatpak; then
        echo "Updating Flatpak packages..."
        flatpak update
    else
        echo "Flatpak not installed, skipping Flatpak updates."
    fi

    echo "System update completed."
}

if pkg_installed pacman-contrib; then
    ofc=$( (while pgrep -x checkupdates > /dev/null ; do sleep 1; done) ; checkupdates | wc -l)
else
    echo "pacman-contrib not installed; please install it to check for updates. Skipping Official updates."
    ofc="Not checked"
fi

if pkg_installed yay; then
    aur=$(yay -Qua | wc -l)
elif pkg_installed paru; then
    aur=$(paru -Qua | wc -l)
else
    aur="AUR helper not installed"
fi

if pkg_installed flatpak; then
    fpk=$(flatpak remote-ls --updates | wc -l)
else
    fpk="Flatpak not installed"
fi

echo "[Official] $ofc"
echo "[AUR]      $aur"
echo "[Flatpak]  $fpk"

read -p "Do you want to update the system? (Y/N): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    update_system
else
    echo "Update canceled."
fi

read -p "Update Plugins? (Y/N): " update_plugins
if [[ "$update_plugins" =~ ^[Yy]$ ]]; then
    echo "Updating plugins..."
    hyprpm update
else
    echo "Skipping plugin update."
fi

echo "Press any key to exit..."
read -n 1 -s
