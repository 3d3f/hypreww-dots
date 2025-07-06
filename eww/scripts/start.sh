#!/bin/bash

# kill
pkill eww
killall eww
pkill -f notifications.py
pkill -f notifications.sh
pkill -f nwg-dock-hyprland
pkill -f get-workspaces
pkill -f get-urgent-workspaces
pkill -f get-active-workspace
pkill -f volume.sh
pkill -f ~/.config/eww/scripts/notifications.py &
pkill -f ~/.config/eww/scripts/battery-alert.sh &
pkill -f ~/.config/eww/scripts/get_power_profile.sh &


# start
eww daemon
eww open bar
eww open barcorner-right
eww open barcorner-left
eww open notifications_popup
~/.config/eww/scripts/notifications.py &
~/.config/eww/scripts/battery-alert.sh &
~/.config/eww/scripts/get_power_profile.sh &

