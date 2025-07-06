#!/bin/bash

get_type() {
  interface=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
  if nmcli device show "$interface" | grep -q "GENERAL.TYPE:.*wifi"; then
    echo "wifi"
  else
    echo "wired"
  fi
}

update() {
  signal=$(nmcli -f in-use,signal dev wifi | rg "\*" | awk '{ print $2 }')
  essid=$(nmcli -t -f NAME connection show --active | head -n1 | sed 's/\"/\\"/g')
  type=$(get_type)
  echo '{"essid": "'"$essid"'", "signal": "'"$signal"'", "type": "'"$type"'"}'
}

# invia un primo stato iniziale
update

# monitora i cambiamenti di connessione con nmcli
nmcli monitor | while read -r _; do
  update
done
