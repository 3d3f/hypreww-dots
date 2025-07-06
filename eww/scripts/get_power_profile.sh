#!/bin/bash

# Funzione per leggere e capitalizzare profilo
get_profile() {
  profile=$(powerprofilesctl get)
  echo "${profile^}"
}

# Se passiamo un parametro, lo usiamo per settare il profilo
if [[ -n "$1" ]]; then
  powerprofilesctl set "$1"
fi

# Loop infinito che aggiorna la variabile EWW
while true; do
  current_profile=$(get_profile)
  eww update power_profile="$current_profile"
  sleep 5
done
