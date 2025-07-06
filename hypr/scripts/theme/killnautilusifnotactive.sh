#!/bin/bash

# Conta il numero di finestre di Nautilus aperte
nautilus_windows=$(hyprctl clients | grep -i nautilus | wc -l)

if [ "$nautilus_windows" -gt 0 ]; then
    echo "Nautilus ha finestre aperte. Nessuna azione necessaria."
else
    echo "Nautilus non ha finestre aperte. Esecuzione di pkill nautilus."
    pkill nautilus
fi
