#!/bin/bash
state=$(eww get open_control_center)

case $1 in
    close)
        eww update open_control_center=false
        eww close control_center
        eww close centercorner-right
        eww close centercorner-left
        eww close control_center-closer
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_control_center=false
        eww close control_center
        eww close centercorner-right
        eww close centercorner-left
        eww close control_center-closer
        ;;
    false)
        eww update open_control_center=true
        eww open control_center-closer
        eww open control_center &
        #eww open centercorner-left &
        #eww open centercorner-right
        ;;
esac
