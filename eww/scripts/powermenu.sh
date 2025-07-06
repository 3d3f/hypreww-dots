#!/bin/bash

state=$(eww get open_powermenu)

open_powermenu() {
    if [[ -z $(eww list-windows | grep '*powermenu') ]]; then
        eww open powermenu
        #eww open powercorner-right
        #eww open powercorner-left
        eww open powermenu-closer
    fi
    eww update open_powermenu=true
}

close_powermenu() {
    eww update open_powermenu=false
    eww close powercorner-right
    eww close powercorner-left
    eww close powermenu
    eww close powermenu-closer
}

case $1 in
    close)
        close_powermenu
        exit 0;;
    open)
        open_powermenu
        exit 0;;
esac

case $state in
    true)
        close_powermenu
        exit 0;;
    false)
        open_powermenu
        exit 0;;
esac
