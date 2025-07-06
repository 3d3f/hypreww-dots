#!/bin/bash

BRIGHTNESS_STEP=5  # Incremento in percentuale
BRIGHT=$(eww get br)  # Ottiene la luminosità corrente

case "$1" in
  --up)
    brightnessctl set +${BRIGHTNESS_STEP}%
    ;;
  --down)
    brightnessctl set ${BRIGHTNESS_STEP}%- 
    ;;
  *)
    echo "Usa: $0 --up | --down"
    exit 1
    ;;
esac

# Se l'OSD è chiuso, aprilo
if [[ $(eww get open_bright_osd) == "false" ]]; then
  eww update open_bright_osd=true
  eww open bright_osd
  #eww open cornerbright-right
  #eww open cornerbright-left
fi

# Loop per chiudere l'OSD dopo inattività
while true; do
  sleep 2
  NEW_BRIGHT=$(eww get br)

  if [[ "$BRIGHT" != "$NEW_BRIGHT" ]]; then
    BRIGHT="$NEW_BRIGHT"
  else
    NEWEST_BRIGHT=$(eww get br)
    if [[ "$BRIGHT" == "$NEWEST_BRIGHT" && $(eww get open_bright_osd) == "true" ]]; then
      eww update open_bright_osd=false
      eww close bright_osd
      eww close cornerbright-right
      eww close cornerbright-left
      pkill -f toggle_brightness.sh
      exit
    fi
  fi
done