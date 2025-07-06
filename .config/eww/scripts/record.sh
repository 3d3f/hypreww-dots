#!/usr/bin/env bash
notify-send "Recording started"
destination="$(xdg-user-dir VIDEOS)/Recordings"
mkdir -p "$destination"
file="$destination/record_$(date '+%F_%T_%:::z').mp4"

# Prendi il default sink e usa il suo monitor
default_sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')
audio_source="${default_sink}.monitor"

# Controllo: se l’utente ha chiesto audio (in $1 o $2), abilita il flag
audio_flag=""
if [[ "$1" == "audio" || "$2" == "audio" ]]; then
  if pactl list short sources | grep -q "^.*${audio_source}"; then
    audio_flag="-a --audio=\"$audio_source\""
  else
    notify-send "⚠️ Monitor audio $audio_source non trovato, registro senza audio"
  fi
fi

# Controllo region
region_flag=""
if [[ "$1" == "region" || "$2" == "region" ]]; then
  region_flag="-g \"$(slurp)\""
fi

# Comando finale con qualità massima RGB
eval wf-recorder -f "\"$file\"" --codec libx264rgb -p preset=veryfast -p crf=23 $audio_flag $region_flag
