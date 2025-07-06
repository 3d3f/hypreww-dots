#!/bin/bash


sleep 0.1
    
# Controlla lo stato del Caps Lock
CAPS_STATE=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .capsLock')

if [[ "$CAPS_STATE" == "true" ]]; then
    eww update capslock="ON"
else
    eww update capslock="OFF"
fi

# Mostra l'OSD
if [[ $(eww get open_caps_osd) == "false" ]]; then
    eww update open_caps_osd=true
    eww open caps_osd
    #eww open capscorner-left
    #eww open capscorner-right
fi

# Chiudi l'OSD dopo 2 secondi
sleep 2
eww update open_caps_osd=false
eww close capscorner-left
eww close capscorner-right
eww close caps_osd

