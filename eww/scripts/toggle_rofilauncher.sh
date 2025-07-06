#!/bin/bash

open_launcher() {
    # Esegui il comando per aprire il launcher
    ~/.config/eww/scripts/ewwapplaunchertoggle.sh &
    eww open killrofi &
    eww open rofilauncher-closer
    #eww open launchcorner-right &
    #sleep 0.2 && eww open launchcorner-left &
    ~/.config/eww/scripts/rofilistener1.sh &
}

close_launcher() {
    # Chiudi il processo rofi
    eww close rofilauncher-closer
    eww close launchcorner-left
    eww close launchcorner-right
    eww close clipcorner-left 
    eww close clipcorner-right
    eww close clipboard-closer
    eww close killrofi
    pkill rofi
}

# Verifica se rofi è aperto
if pgrep -x "rofi" > /dev/null; then
    close_launcher
else
    open_launcher
fi
