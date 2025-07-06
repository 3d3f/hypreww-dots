#!/bin/bash

# Percorsi origine e destinazione
QT5_SRC="$HOME/.config/hypr/scripts/theme/qtsettings/qt5ct.conf"
QT6_SRC="$HOME/.config/hypr/scripts/theme/qtsettings/qt6ct.conf"
QT5_DEST="$HOME/.config/qt5ct/qt5ct.conf"
QT6_DEST="$HOME/.config/qt6ct/qt6ct.conf"

# Creazione directory di destinazione se non esistono
mkdir -p "$(dirname "$QT5_DEST")"
mkdir -p "$(dirname "$QT6_DEST")"

# Copia dei file
cp "$QT5_SRC" "$QT5_DEST" && echo "Copiato qt5ct.conf in $QT5_DEST"
cp "$QT6_SRC" "$QT6_DEST" && echo "Copiato qt6ct.conf in $QT6_DEST"
