#!/usr/bin/env bash

workspace_id="$1"

if [[ "$workspace_id" == "-99" ]]; then
  hyprctl dispatch togglespecialworkspace
else
  hyprctl dispatch workspace "$workspace_id"
fi
