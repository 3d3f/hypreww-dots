#!/bin/bash

sudo systemctl restart bluetooth
sleep 0.1
bluetoothctl power off
sleep 0.1
bluetoothctl power on
sleep 0.1
blueman-manager
