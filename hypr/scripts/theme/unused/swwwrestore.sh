#!/bin/bash

# Recupera l'ultimo wallpaper impostato
last_wallpaper=$(cat ~/.config/swww/last_wallpaper 2>/dev/null)

# Se esiste un wallpaper salvato, imposta il wallpaper con swww
if [[ -n "$last_wallpaper" && -f "$last_wallpaper" ]]; then
    swww img "$last_wallpaper" --transition-type grow --transition-fps 60 --transition-duration 2

 # Aggiunta dei comandi successivi
wal -n -i "$last_wallpaper" && hyprctl dispatch exec /home/fede/.config/hypr/scripts/theme/theme.sh
    
fi
