#!/bin/bash

# Percorso del file da controllare
file_check="$HOME/.config/hypr/scripts/theme/material/colors/wall.png"

# Controlla se il file esiste
if [ -f "$file_check" ]; then
    # Se il file esiste, esegui i due comandi con il wall personalizzato
    ~/.config/hypr/scripts/theme/material/material.py --image "$HOME/.config/hypr/scripts/theme/material/colors/wall.png"
    ~/.config/hypr/scripts/theme/themematerial.sh
else
    # Se il file non esiste, esegui i due comandi con il wall di default
    ~/.config/hypr/scripts/theme/material/material.py --image "$HOME/.config/hypr/scripts/theme/material/defaultwall/wall.png"
    ~/.config/hypr/scripts/theme/themematerial.sh
fi

