#!/bin/bash

# Verifica se Rofi è in esecuzione
if pgrep -x "rofi" > /dev/null; then
    echo "Rofi è in esecuzione. Chiusura in corso..."
    pkill -x "rofi"
    # Termina lo script
    exit 0
else
    echo "Rofi non è in esecuzione. Continuo con lo script..."
fi

hyprctl keyword layerrule animation fade, rofi
cliphist list | rofi -kb-cancel Escape,MouseSecondary -dmenu -display-columns 2 -theme clipboard.rasi -show-icons | cliphist decode | wl-copy
