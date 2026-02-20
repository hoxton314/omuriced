#!/bin/bash
# Auto-resize Godot debug controls window (class=Godot, title contains DEBUG)
# to ~772px wide when it opens, keeping dwindle tiled layout.

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

nc -U "$SOCKET" | while read -r line; do
    if [[ "$line" == openwindow* ]] && [[ "$line" == *"Godot"* ]]; then
        sleep 0.5
        addr=$(hyprctl clients -j | jq -r '.[] | select(.class == "Godot" and (.title | test("DEBUG"))) | .address')
        if [ -n "$addr" ]; then
            current_w=$(hyprctl clients -j | jq -r --arg a "$addr" '.[] | select(.address == $a) | .size[0]')
            if [ -n "$current_w" ] && [ "$current_w" -gt 772 ] 2>/dev/null; then
                diff=$((current_w - 772))
                prev=$(hyprctl activewindow -j | jq -r '.address')
                hyprctl dispatch focuswindow "address:$addr"
                sleep 0.1
                hyprctl dispatch resizeactive "$diff" 0
                sleep 0.1
                [ -n "$prev" ] && hyprctl dispatch focuswindow "address:$prev"
            fi
        fi
    fi
done
