#!/bin/bash

bright="$(~/.config/eww/scripts/getBrightness br)"

if [[ $(eww get open_osd) == false ]]; then
  eww open bright_osd
  eww update open_bright_osd=true
fi

while true; do
  sleep 2.5

  new_bright=$(~/.config/eww/scripts/getBrightness br)

  if [ "$bright" != "$new_bright" ]; then
    bright="$new_bright"
  else
    newest_bright=$(~/.config/eww/scripts/getBrightness br)
    if [ "$bright" == "$newest_bright" ]; then
      if [[ $(eww get open_osd) == true ]];then
        eww close bright_osd
        eww update open_bright_osd=false
        exit
      fi
    fi
  fi
done