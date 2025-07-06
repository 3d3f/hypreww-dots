#!/bin/bash

if [[ "$(eww get bar_visible)" == "false" ]]; then
    eww open bar
    eww update bar_hover=true
    eww close hide-bar
else
    echo "Barra già visibile."
fi
