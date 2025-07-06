#!/bin/bash

toggle() {
    STATUS="$(bluetoothctl show | grep Powered | awk '{print $2}')"
    if [ "$STATUS" == "yes" ]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

icon() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        if bluetoothctl devices Connected | grep -q 'Device'; then
            echo "󰂱"  # Icona quando connesso
        else
            echo "󰂯"  # Icona quando acceso ma non connesso
        fi
    else
        echo "󰂲"  # Icona quando spento
    fi
}

status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        if bluetoothctl devices Connected | grep -q 'Device'; then
            DEVICE=$(bluetoothctl devices Connected | head -n 1 | awk -F' ' '{ for (i=3; i<=NF; i++) printf $i " "; }')
            echo "$DEVICE"  # Nome del dispositivo connesso
        else
            echo "Bluetooth"
        fi
    else
        echo "Bluetooth"
    fi
}

if [[ $1 == "--status" ]]; then
    status
elif [[ $1 == "--icon" ]]; then
    icon
elif [[ $1 == "--toggle" ]]; then
    toggle
fi
