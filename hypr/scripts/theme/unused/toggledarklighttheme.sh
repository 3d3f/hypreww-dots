#!/bin/bash

# Configurazione
INTERFACE="org.gnome.desktop.interface"
THEME=$(gsettings get $INTERFACE color-scheme | tr -d "'")

# Funzioni per impostare i temi
set_dark() {
  gsettings set $INTERFACE gtk-theme 'adw-gtk3-dark'
  gsettings set $INTERFACE color-scheme 'prefer-dark'
  gsettings set $INTERFACE icon-theme 'Papirus-Dark'
  sed -i 's/^background_opacity 1$/background_opacity 0.1/' ~/.config/kitty/kitty.conf
  ~/.config/hypr/scripts/theme/setcursor.sh
  kvantummanager --set KvGnomeDark
  cp -r ~/.config/wlogout/iconsLight/* ~/.config/wlogout/icons/
  echo "Tema scuro impostato."
}

set_light() {
  gsettings set $INTERFACE gtk-theme 'adw-gtk3'
  gsettings set $INTERFACE color-scheme 'default'
  gsettings set $INTERFACE icon-theme 'Papirus-Light'
  sed -i 's/^background_opacity 0.1$/background_opacity 1/' ~/.config/kitty/kitty.conf
  ~/.config/hypr/scripts/theme/setcursor.sh
  kvantummanager --set KvGnome
  cp -r ~/.config/wlogout/iconsDark/* ~/.config/wlogout/icons/
  echo "Tema chiaro impostato."
}

# Alternanza tra temi
if [ "$THEME" = "prefer-dark" ]; then
  set_light
elif [ "$THEME" = "default" ]; then
  set_dark
else
  echo "Tema non riconosciuto: $THEME"
  exit 1
fi

# comandi aggiuntivi
~/.config/hypr/scripts/theme/material/material.py --toggle
~/.config/hypr/scripts/theme/themematerial.sh
