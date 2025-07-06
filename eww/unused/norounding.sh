#!/bin/bash

eww close barcorner-left
eww close barcorner-right
hyprctl --batch "keyword general:gaps_in 3"
hyprctl --batch "keyword decoration:shadow:enabled true"
hyprctl --batch "keyword general:gaps_out 6"
hyprctl --batch "keyword general:border_size 1"
hyprctl --batch "keyword decoration:rounding 0"

