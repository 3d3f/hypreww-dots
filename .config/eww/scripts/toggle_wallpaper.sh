#!/bin/bash

open_launcher() {
    
    # Esegui il comando per aprire il launcher
    eww open killrofi &
    ~/.config/rofi/scripts/wallselecttoggle.sh &
    #eww open cornerwall-left
    #eww open cornerwall-right
    eww open wallpaper-closer
    ~/.config/eww/scripts/rofilistener1.sh &
}

close_launcher() {
    # Chiudi il processo rofi
    eww close wallpaper-closer
    eww close cornerwall-left
    eww close cornerwall-right
    eww close killrofi 
    pkill rofi
}

# Verifica se rofi è aperto
if pgrep -x "rofi" > /dev/null; then
    close_launcher
else
    open_launcher
fi