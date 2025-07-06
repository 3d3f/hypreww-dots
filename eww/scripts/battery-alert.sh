#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
THRESHOLD=10
CHECK_INTERVAL=60

while true; do
  capacity=$(cat "$BATTERY_PATH/capacity")
  status=$(cat "$BATTERY_PATH/status")

  is_open=$(eww active-windows | grep -c "^battery-alert")
  alert_disabled=$(eww get alert_disabled 2>/dev/null || echo false)

  echo "Capacity=$capacity, Status=$status, IsOpen=$is_open, Disabled=$alert_disabled"

  # Se metti in carica, riabilita l'alert
  if [[ "$status" == "Charging" ]] && [[ "$alert_disabled" == "true" ]]; then
    eww update alert_disabled=false
    echo "Alert riabilitato perché in carica"
  fi

  if [[ "$alert_disabled" == "true" ]]; then
    # Alert disabilitato, chiudi finestra se aperta e non aprire nulla
    if (( is_open == 1 )); then
      eww close battery-alert
    fi
  else
    if (( capacity <= THRESHOLD )) && [[ "$status" != "Charging" ]]; then
      if (( is_open == 0 )); then
        eww open battery-alert
      fi
    else
      if (( is_open == 1 )); then
        eww close battery-alert
      fi
    fi
  fi

  sleep $CHECK_INTERVAL
done
