#!/bin/bash
set -euo pipefail

LOG_FILE="/tmp/keyboard_remap.log"
DEBOUNCE_SECONDS=10
last_remap_time=0

# Create log file if it doesn't exist and set permissions
touch "$LOG_FILE"

info () {
  echo -e "$@" >> "$LOG_FILE"
}

# Function to remap keyboard
remap_keyboard() {
    current_time=$(date +%s)
    time_diff=$((current_time - last_remap_time))

    if [ "$time_diff" -lt "$DEBOUNCE_SECONDS" ]; then
        return
    fi
    info "Remapping keyboard ctrl/caps"
    sleep 2
    setxkbmap -option "ctrl:swapcaps" -option "altwin:swap_lalt_lwin"
    last_remap_time=$current_time
}


LOCK_FILE="/tmp/keyboard_remap.lock"

# Check if script is already running using lock file
if [ -f "$LOCK_FILE" ]; then
    pid=$(cat "$LOCK_FILE")
    if ps -p "$pid" > /dev/null; then
        info "Script already running with PID $pid"
        exit 0
    else
        # Remove stale lock file
        rm "$LOCK_FILE"
    fi
fi

# Create lock file with current PID
echo $$ > "$LOCK_FILE"

# Cleanup lock file on exit
trap 'rm -f "$LOCK_FILE"' EXIT

# Log script startup
info "Keyboard remapping script started"

# Initial setup
remap_keyboard

# Watch for changes in input devices
info "Starting inotify watch on /dev/input"
# Watch for changes in input devices
inotifywait -m -e create,delete /dev/input |
    while read -r _directory _events filename; do
      if [[ "$filename" =~ ^event ]] && grep -q "kbd" "/proc/bus/input/devices"; then
        remap_keyboard
      fi
    done

info "script terminated"
