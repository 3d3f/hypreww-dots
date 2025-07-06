#!/bin/bash

# Usa hyprpicker per selezionare un colore e copialo in automatico (-a)
COLOR=$(hyprpicker -a -f hex)

# Se l'utente ha annullato la selezione, esci
if [ -z "$COLOR" ]; then
    exit 1
fi

# Mostra notifica con preview del colore
#notify-send "$COLOR" \
 #   --icon=dialog-information \
  #  -h string:bgcolor:"$COLOR" \
   # -h string:fgcolor:"#ffffff" \
   # -h int:transient:1
