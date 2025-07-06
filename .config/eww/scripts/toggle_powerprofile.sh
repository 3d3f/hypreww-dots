#!/bin/bash
state=$(eww get open_powerprofile)

case $1 in
    close)
        eww update open_powerprofile=false
        eww close powerprofile
        eww close powerprofile-closer
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_powerprofile=false
        eww close powerprofile
        eww close powerprofile-closer
        ;;
    false)
        eww update open_powerprofile=true
        eww open powerprofile-closer
        eww open powerprofile &
        ;;
esac
