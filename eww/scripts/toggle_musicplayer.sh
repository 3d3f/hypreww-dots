#!/bin/bash
state=$(eww get open_musicplayer)

case $1 in
    close)
        eww update open_musicplayer=false
        eww close recordplayer
        eww close musicplayer-closer
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_musicplayer=false
        eww close recordplayer
        eww close musicplayer-closer
        ;;
    false)
        eww update open_musicplayer=true
        eww open musicplayer-closer
        eww open recordplayer &
        ;;
esac
