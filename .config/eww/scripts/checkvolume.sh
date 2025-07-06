#!/bin/bash

vol="$(eww get volume)"

if [[ $(eww get open_osd) == false ]]; then
  eww open osd
  #eww open cornervolume-right
  #eww open cornervolume-left
  eww update open_osd=true
fi

while true; do
  sleep 2

  new_vol=$(eww get volume)

  if [ "$vol" != "$new_vol" ]; then
    vol="$new_vol"
  else
    newest_vol=$(eww get volume)
    if [ "$vol" == "$newest_vol" ]; then
      if [[ $(eww get open_osd) == true ]];then
        eww close osd
        eww close cornervolume-right
        eww close cornervolume-left
        eww update open_osd=false
        exit
      fi
    fi
  fi
done