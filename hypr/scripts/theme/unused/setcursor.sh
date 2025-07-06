#!/bin/bash

# Ottieni lo schema di colore preferito
color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)

# Verifica lo schema di colore e applica i comandi appropriati
if [[ "$color_scheme" == "'prefer-light'" ]] || [[ "$color_scheme" == "'default'" ]]; then
    # Imposta il cursore per lo schema di colore chiaro
    hyprctl setcursor BreezeX-RosePine-Linux 40
    gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux
elif [[ "$color_scheme" == "'prefer-dark'" ]]; then
    # Imposta il cursore per lo schema di colore scuro
    hyprctl setcursor BreezeX-RosePineDawn-Linux 40
    gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePineDawn-Linux
else
    echo "Schema di colore sconosciuto o non supportato."
fi
