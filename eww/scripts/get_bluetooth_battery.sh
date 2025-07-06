#!/bin/bash

# Usa bluetoothctl per ottenere la lista dei dispositivi e analizzare l'output
while IFS=' ' read -r _ address alias; do
  # Controlla lo stato della connessione
  connected_status=$(bluetoothctl info "$address" | grep "Connected:" | awk '{print $2}')
  
  if [ "$connected_status" == "yes" ]; then
    # Ottieni la percentuale della batteria se disponibile
    battery_percentage=$(bluetoothctl info "$address" | grep "Battery Percentage:" | grep -oP '\(\K[0-9]+')
    
    # Se c'è una percentuale, stampala; altrimenti restituisci stringa vuota
    if [ -n "$battery_percentage" ]; then
      echo "$battery_percentage%"
    else
      echo ""
    fi
    exit 0
  fi
done < <(bluetoothctl devices)

# Se nessun dispositivo è connesso, restituisci una stringa vuota
echo ""
exit 0
