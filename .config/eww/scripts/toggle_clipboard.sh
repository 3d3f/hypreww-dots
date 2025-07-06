#!/bin/bash

open_launcher() {
    # Esegui il comando per aprire il launcher
    ~/.config/eww/scripts/ewwclipboardtoggle.sh &
    eww open killrofi &
    eww open clipboard-closer
    #eww open clipcorner-right &
    #sleep 0.2 && eww open clipcorner-left &
    ~/.config/eww/scripts/rofilistener1.sh &
}

close_launcher() {
    # Chiudi il processo rofi
    eww close clipcorner-left 
    eww close clipcorner-right
    eww close clipboard-closer
    eww close launchcorner-left
    eww close launchcorner-right
    eww close rofilauncher-closer
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

