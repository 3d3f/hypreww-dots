#!/bin/bash

# Nome della variabile di stato di Eww
STATE_VAR="bar_visible"

# Controlla lo stato attuale della variabile
BAR_STATE=$(eww get "$STATE_VAR")

if [ "$BAR_STATE" = "true" ]; then
    # La barra è visibile, chiudila e applica il profilo "minimal"
    eww update "$STATE_VAR"=false
    eww close bar
else
    # La barra è nascosta, aprila e applica il profilo "estetico"
    eww update "$STATE_VAR"=true
    eww open bar
fi
