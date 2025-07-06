#!/bin/bash

direction=$1
current=$2

# Ottieni gli ID dei workspace attivi ordinati
active_workspaces=($(hyprctl workspaces -j | jq 'sort_by(.id) | .[].id'))

# Trova indice dell'attuale workspace
for i in "${!active_workspaces[@]}"; do
    if [[ ${active_workspaces[$i]} -eq $current ]]; then
        index=$i
        break
    fi
done

# Calcola il nuovo indice ciclico
if [[ $direction == "down" ]]; then
    new_index=$(( (index + 1) % ${#active_workspaces[@]} ))
elif [[ $direction == "up" ]]; then
    new_index=$(( (index - 1 + ${#active_workspaces[@]}) % ${#active_workspaces[@]} ))
else
    exit 1
fi

# Passa al workspace selezionato
target=${active_workspaces[$new_index]}
hyprctl dispatch workspace "$target"
