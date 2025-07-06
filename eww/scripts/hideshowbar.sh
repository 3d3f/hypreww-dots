#!/bin/bash

# Nome della variabile di stato di Eww
STATE_VAR="bar_visible"

# Controlla lo stato attuale della variabile
BAR_STATE=$(eww get "$STATE_VAR")

if [ "$BAR_STATE" = "true" ]; then
    # La barra è visibile, chiudila e applica il profilo "minimal"
    eww update "$STATE_VAR"=false
    eww close bar
    eww close barcorner-right
    eww close barcorner-left
    hyprctl --batch "keyword general:gaps_in 3"
    hyprctl --batch "keyword decoration:shadow:enabled true"
    hyprctl --batch "keyword general:gaps_out 5"
    hyprctl --batch "keyword general:border_size 0"
    hyprctl --batch "keyword decoration:rounding 5"          
else
    # La barra è nascosta, aprila e applica il profilo "estetico"
    eww update "$STATE_VAR"=true
    eww open bar
    eww open barcorner-right
    eww open barcorner-left
    hyprctl --batch "keyword general:gaps_in 3"
    hyprctl --batch "keyword decoration:shadow:enabled true"
    hyprctl --batch "keyword general:gaps_out 5"
    hyprctl --batch "keyword general:border_size 0"
    hyprctl --batch "keyword decoration:rounding 20"
fi
