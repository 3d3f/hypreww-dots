#!/bin/bash

base_dir="$HOME/.config/eww/"
playerctl metadata -F -f '{{playerName}} {{title}} {{artist}} {{mpris:artUrl}} {{status}} {{mpris:length}}' | while read -r line; do
    name=$(playerctl metadata -f "{{playerName}}")
    title=$(playerctl metadata -f "{{title}}")
    artist=$(playerctl metadata -f "{{artist}}")
    artUrl=$(playerctl metadata -f "{{mpris:artUrl}}")
    status=$(playerctl metadata -f "{{status}}")
    length=$(playerctl metadata -f "{{mpris:length}}")
    if [[ -n $length ]]; then
        length=$(( (length + 500000) / 1000000 ))
    fi
    # Delete the image for the current song
    rm -f "${base_dir}image.jpg"
    # Download the album art for the current song as "image.jpg"
    cp "${artUrl/file:\/\//}" "${base_dir}image.jpg"
    lengthStr=$(playerctl metadata -f "{{duration(mpris:length)}}")

    JSON_STRING=$( jq -n \
                --arg name "$name" \
                --arg title "$title" \
                --arg artist "$artist" \
                --arg artUrl "${base_dir}image.jpg" \
                --arg status "$status" \
                --arg length "$length" \
                --arg lengthStr "$lengthStr" \
                '{name: $name, title: $title, artist: $artist, artUrl: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}' )
    echo $JSON_STRING
done

