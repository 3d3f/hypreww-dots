#!/bin/bash

hyprctl keyword layerrule animation slide left, rofi

# Esegui il comando per avviare lo script
SCRIPT_COMMAND="rofi -normal-window -show drun -theme ewwapplauncher.rasi -kb-cancel "Escape,MouseSecondary""
echo "Esecuzione del comando: $SCRIPT_COMMAND"
$SCRIPT_COMMAND

