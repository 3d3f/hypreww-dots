#!/bin/bash

# Controlla se hyprsunset è già in esecuzione
if pgrep -x "hyprsunset" > /dev/null; then
    # Se è in esecuzione, uccidi il processo
    pkill hyprsunset
    eww update nightlight=false
else
    # Se non è in esecuzione, avvia hyprsunset
    hyprsunset -t 5000 &
    eww update nightlight=true
fi
