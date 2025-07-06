#!/bin/bash

spaces() {
    # Prende solo i workspace con almeno una finestra
    hyprctl workspaces -j | jq '[.[] | select(.windows > 0) | {id: (.id | tostring), windows}]'
}

# Primo output per inizializzare EWW
spaces

# Listener: Hyprland >= v0.40.0
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r _; do
    spaces
done
