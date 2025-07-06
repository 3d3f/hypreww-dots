#!/bin/bash

# Directory contenente i wallpaper
wallpaper_dir="$HOME/Pictures/Wallpapers"

# Controllo se la directory esiste
if [[ ! -d "$wallpaper_dir" ]]; then
    echo "La directory $wallpaper_dir non esiste."
    exit 1
fi

# Selezione del wallpaper tramite rofi
select_wallpaper() {
    wallpapers=$(find "$wallpaper_dir" -type f)

   selected_wallpaper=$(echo "$wallpapers" | while IFS= read -r a; do
	echo -en "${a##*/}\0icon\x1fthumbnail://$a\n"
	done | PREVIEW=true rofi -dmenu -i -p "" -kb-cancel Escape,MouseSecondary -theme ~/.config/rofi/wallpaper.rasi)

    echo "$selected_wallpaper"
}

# Logica principale
selected_wallpaper=$(select_wallpaper)

if [[ -n "$selected_wallpaper" && -f "$wallpaper_dir/$selected_wallpaper" ]]; then
    set_wallpaper "$wallpaper_dir/$selected_wallpaper"
    
else
    echo "Nessun wallpaper selezionato o file non valido."
    exit 1
fi

~/.config/hypr/scripts/theme/material/material.py --image "$wallpaper_dir/$selected_wallpaper"
~/.config/hypr/scripts/theme/themematerial.sh


