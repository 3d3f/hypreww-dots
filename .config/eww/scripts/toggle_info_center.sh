#!/bin/bash
state=$(eww get open_info_center)

case $1 in
    close)
        eww update open_info_center=false
        eww close info_center
        eww close cornerinfo-left
        eww close cornerinfo-right
        eww close info_center-closer
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_info_center=false
        eww close info_center
        eww close cornerinfo-left
        eww close cornerinfo-right
        eww close info_center-closer
        ;;
    false)
        eww update open_info_center=true
        eww open info_center-closer
        eww open info_center &
        #eww open cornerinfo-right &
        #eww open cornerinfo-left
        ;;
esac

