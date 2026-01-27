#!/bin/bash

# Get memory info
read -r total used available <<< $(free -b | awk '/^Mem:/ {print $2, $3, $7}')
percentage=$((used * 100 / total))

# Format memory values for display (pure bash, no bc)
format_bytes() {
    local bytes=$1
    local gb=$((bytes / 1073741824))
    local gb_rem=$(( (bytes % 1073741824) * 10 / 1073741824 ))
    local mb=$((bytes / 1048576))

    if ((gb >= 1)); then
        printf "%d.%dG" "$gb" "$gb_rem"
    else
        printf "%dM" "$mb"
    fi
}

used_fmt=$(format_bytes $used)
total_fmt=$(format_bytes $total)

# Get top memory-consuming processes
tooltip="Memory: ${used_fmt} / ${total_fmt} (${percentage}%)\n─────────────────────────\n"
tooltip+=$(ps axo rss,comm --no-headers | \
    awk '{mem[$2]+=$1} END {for(p in mem) print mem[p], p}' | \
    sort -rn | head -10 | \
    awk '{
        mb = $1/1024;
        if (mb >= 1024) {
            printf "%.1fG  %s\n", mb/1024, $2
        } else {
            printf "%.0fM  %s\n", mb, $2
        }
    }')

# Output JSON for waybar (escape newlines for valid JSON)
tooltip_escaped="${tooltip//$'\n'/\\n}"
printf '{"text": "󰘚  %s%%", "tooltip": "%s", "percentage": %d}\n' "$percentage" "$tooltip_escaped" "$percentage"
