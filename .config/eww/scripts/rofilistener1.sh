#!/bin/bash

# Aspetta che Rofi venga avviato (se non è già in esecuzione)
echo "Attendo che Rofi venga avviato..."
while ! pgrep -x "rofi" > /dev/null; do
    sleep 0.2
done

echo "Rofi è stato avviato. Attendo che venga chiuso..."

# Aspetta che Rofi venga chiuso
while pgrep -x "rofi" > /dev/null; do
    sleep 0.2
done

echo "Rofi è stato chiuso. Chiudo i widget..."

# Chiude i widget EWW
eww close clipcorner-left
eww close clipcorner-right
eww close launchcorner-left
eww close launchcorner-right
eww close cornerwall-left
eww close cornerwall-right
eww close clipboard-clear
eww close rofilauncher-closer
eww close clipboard-closer
eww close wallpaper-closer
eww close killrofi



