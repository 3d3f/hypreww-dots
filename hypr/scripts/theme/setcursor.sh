#!/bin/bash

gsettings set org.gnome.desktop.interface cursor-size 33

# Ottieni lo schema di colore preferito
color_scheme=$(~/.config/hypr/scripts/theme/material/material.py --current)

# Verifica lo schema di colore e applica i comandi appropriati
if [[ "$color_scheme" == "light" ]]; then
    # Imposta il cursore per lo schema di colore chiaro
    hyprctl setcursor Bibata-Modern-Classic 36
    gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
elif [[ "$color_scheme" == "dark" ]]; then
    # Imposta il cursore per lo schema di colore scuro
    hyprctl setcursor Bibata-Modern-Ice 36
    gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Ice
else
    echo "Schema di colore sconosciuto o non supportato."
fi
