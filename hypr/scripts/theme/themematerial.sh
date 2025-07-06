#!/bin/bash

# Avvia Eww e disconnetti il processo dallo script
~/.config/eww/scripts/start.sh > /dev/null & disown

# Invia segnali a kitty e cava
pkill -SIGUSR1 kitty > /dev/null 2>&1
pkill -USR2 cava > /dev/null 2>&1

# Avvia lo script per Nautilus, se necessario
/home/fede/.config/hypr/scripts/theme/killnautilusifnotactive.sh & disown

# Chiude lo script principale
exit 0
