#!/bin/bash

# --- Configurazione ---
EWW_BIN="eww" # Assicurati che eww sia nel tuo PATH o specifica il percorso completo
base_dir="$HOME/.config/eww"
default_art_url_path="file://${base_dir}/default_album_art.png"
image_file_eww_link="${base_dir}/eww_album_art_current" # Un link simbolico

# Assicurati che la directory base esista
mkdir -p "$base_dir"

# --- Funzione per formattare i secondi in MM:SS ---
format_time() {
  local total_seconds=$1
  if [[ -z "$total_seconds" || "$total_seconds" -lt 0 ]]; then # Corretto -lt 0
    echo "0:00"
    return
  fi
  local minutes=$((total_seconds / 60))
  local seconds=$((total_seconds % 60))
  printf "%d:%02d" "$minutes" "$seconds"
}

# --- Loop principale ---
while true; do
  player_name=$(playerctl metadata -f "{{playerName}}" 2>/dev/null)

  if [[ -z "$player_name" ]]; then
    "$EWW_BIN" update mpris_data='{"name": "N/A", "title": "Nessuna Riproduzione", "artist": "", "artUrl": "'"$default_art_url_path"'", "status": "Offline", "length": 0, "lengthStr": "0:00", "position": 0, "positionStr": "0:00"}'
    sleep 5 # Controlla meno frequentemente se non c'è nulla
    continue
  fi

  title=$(playerctl metadata -f "{{title}}" 2>/dev/null)
  artist=$(playerctl metadata -f "{{artist}}" 2>/dev/null)
  status=$(playerctl metadata -f "{{status}}" 2>/dev/null)
  raw_art_url=$(playerctl metadata -f "{{mpris:artUrl}}" 2>/dev/null)

  current_art_for_eww="$default_art_url_path"
  if [[ -n "$raw_art_url" ]]; then
    if [[ "$raw_art_url" == file://* ]]; then
      actual_file_path="${raw_art_url/file:\/\//}"
      if [[ -f "$actual_file_path" ]]; then
        # Crea o aggiorna un link simbolico all'immagine corrente
        # Questo evita problemi di Eww che non ricarica l'immagine se il percorso URL rimane lo stesso
        ln -sf "$actual_file_path" "$image_file_eww_link"
        current_art_for_eww="file://${image_file_eww_link}?$(date +%s%N)" # Cache busting
      fi
    else
      # Per URL http(s), potresti scaricarli qui se vuoi. Per ora, usa il fallback.
      :
    fi
  fi

  length_micros=$(playerctl metadata -f "{{mpris:length}}" 2>/dev/null)
  length_seconds=0
  if [[ -n "$length_micros" && "$length_micros" -gt 0 ]]; then
    length_seconds=$(( (length_micros + 500000) / 1000000 ))
  fi

  position_float=$(playerctl position 2>/dev/null)
  position_seconds=0
  if [[ -n "$position_float" ]]; then
    position_seconds=$(printf "%.0f" "$position_float")
    # Assicura che la posizione non superi la lunghezza
    if [[ "$length_seconds" -gt 0 && "$position_seconds" -gt "$length_seconds" ]]; then
        position_seconds=$length_seconds
    fi
    # Assicura che la posizione non sia negativa
    if [[ "$position_seconds" -lt 0 ]]; then
        position_seconds=0
    fi
  fi

  length_str=$(format_time $length_seconds)
  position_str=$(format_time $position_seconds)

  [[ -z "$title" ]] && title="Traccia Sconosciuta"
  [[ -z "$artist" ]] && artist="Artista Sconosciuto"
  [[ -z "$status" ]] && status="N/A"

  json_output=$(jq -n \
    --arg name "$player_name" \
    --arg title "$title" \
    --arg artist "$artist" \
    --arg artUrl "$current_art_for_eww" \
    --arg status "$status" \
    --argjson length "$length_seconds" \
    --arg lengthStr "$length_str" \
    --argjson position "$position_seconds" \
    --arg positionStr "$position_str" \
    '{name: $name, title: $title, artist: $artist, artUrl: $artUrl, status: $status, length: $length, lengthStr: $lengthStr, position: $position, positionStr: $positionStr}')

  "$EWW_BIN" update mpris_data="$json_output"

  # Determina l'intervallo di sleep in base allo stato
  # Aggiorna più velocemente se in riproduzione per la barra di avanzamento
  if [[ "$status" == "Playing" ]]; then
    sleep 0.5 # Intervallo breve per la barra di avanzamento
  else
    sleep 1   # Intervallo standard
  fi
done