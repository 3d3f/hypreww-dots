#!/bin/bash

while true; do
  players=$(playerctl -l 2>/dev/null)
  
  if [[ -z "$players" ]]; then
    echo '{"song": "", "artist": "", "status": "Stopped"}'
  else
    # Prende i metadata dal player di default (il primo elencato)
    metadata=$(playerctl metadata --format '{"song": "{{title}}", "artist": "{{artist}}", "status": "{{status}}"}' 2>/dev/null)
    # Se playerctl fallisce, forziamo comunque l'output
    if [[ -z "$metadata" ]]; then
      echo '{"song": "", "artist": "", "status": "Stopped"}'
    else
      echo "$metadata"
    fi
  fi

  sleep 1
done
