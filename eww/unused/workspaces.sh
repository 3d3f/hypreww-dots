hyprctl workspaces -j | jq -c 'map({id, name, urgent})'

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  hyprctl workspaces -j | jq -c 'map({id, name, urgent}) | sort_by(.id)'
done
