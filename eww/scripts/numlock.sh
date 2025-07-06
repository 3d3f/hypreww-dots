#!/bin/bash

sleep 0.1
# Controlla lo stato del Num Lock
NUM_STATE=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .numLock')

if [[ "$NUM_STATE" == "true" ]]; then
    eww update numlock="ON"
else
    eww update numlock="OFF"
fi

# Mostra l'OSD
if [[ $(eww get open_num_osd) == "false" ]]; then
    eww update open_num_osd=true
    eww open num_osd
    #eww open numcorner-left
    #eww open numcorner-right
fi

# Chiudi l'OSD dopo 2 secondi
sleep 2
eww update open_num_osd=false
eww close numcorner-left
eww close numcorner-right
eww close num_osd
