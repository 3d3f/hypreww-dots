#!/bin/bash

# Verifica se Rofi è in esecuzione

PROCESS_NAME="nwg-dock-hyprland -f -a start -p left -mt 47 -mb 4 -i 68"

if pgrep -x "rofi" > /dev/null; then
    echo "Rofi è in esecuzione. Chiusura in corso..."
    pkill -x "rofi"
    # Termina lo script
    exit 0
else
    echo "Rofi non è in esecuzione. Continuo con lo script..."
fi

# Esegui il comando per impostare la layerrule
LAYERRULE_COMMAND="hyprctl keyword layerrule animation slide, rofi"
echo "Esecuzione del comando: $LAYERRULE_COMMAND"
$LAYERRULE_COMMAND

# Esegui il comando per avviare lo script
SCRIPT_COMMAND="rofi -show drun -theme applauncher.rasi -kb-cancel "Escape,MouseSecondary""
echo "Esecuzione del comando: $SCRIPT_COMMAND"
$SCRIPT_COMMAND
