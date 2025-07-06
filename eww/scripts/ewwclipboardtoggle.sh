#!/bin/bash

hyprctl keyword layerrule animation slide right, rofi

cliphist list | rofi -kb-cancel Escape,MouseSecondary -dmenu -display-columns 2 -theme ewwclipboard.rasi -show-icons | cliphist decode | wl-copy
