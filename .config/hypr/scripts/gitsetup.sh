#!/bin/bash

# Controlla se git è installato
if ! command -v git &> /dev/null; then
    echo "Git not installed. Installing now..."

    # Aggiorna il sistema e installa git usando pacman
    sudo pacman -Syu --noconfirm git
fi

# Configurazione iniziale di git
echo "Configuring git..."

# Impostare il nome e l'email globali
git config --global user.name "3d3f"
git config --global user.email "dbfside@gmail.com"

# Verifica della configurazione
echo "Setup complete:"
git config --global --list
