#!/bin/bash

status=$(playerctl status 2>/dev/null)
if [[ "$status" == "Playing" ]]; then
  title=$(playerctl metadata title)
  art=$(playerctl metadata mpris:artUrl | sed 's/^file:\/\///')

  echo "(set song_title \"$title\")"
  echo "(set album_art \"$art\")"
  echo "(set show_icon true)"
else
  echo "(set show_icon false)"
fi
