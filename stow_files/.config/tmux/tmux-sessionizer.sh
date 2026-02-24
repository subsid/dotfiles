#!/usr/bin/env bash
set -euo pipefail

# Configuration
DEBUG=false

# Parse command line flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--debug)
            DEBUG=true
            shift
            ;;
        -h|--help)
            echo "Usage: $(basename "$0") [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -d, --debug    Enable debug output"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Debug helper
debug() {
    if [[ "$DEBUG" == true ]]; then
        echo "DEBUG: $*" >&2
        sleep 1
    fi
}

BASE_DIRS=(
    "$HOME"
    "$HOME/workspace"
)

# Individual projects (add specific project paths here)
PROJECTS=(
    # Example: "$HOME/special-project"
    # Example: "/opt/my-app"
)

# Build the list of sessions and directories
build_list() {
    local existing_sessions
    existing_sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null || true)

    # 1. Existing tmux sessions (prefixed with *)
    while IFS= read -r session; do
        echo "* $session"
    done <<< "$existing_sessions"

    # 2. Individual projects
    for project in "${PROJECTS[@]}"; do
        # Expand tilde
        project="${project/#\~/$HOME}"

        [[ -d "$project" ]] || continue

        local name
        name="$(basename "$project")"

        # Skip if session already exists
        if ! echo "$existing_sessions" | grep -qx "$name"; then
            echo "$name"
        fi
    done

    # 3. Candidate directories from BASE_DIRS (skip those with existing sessions)
    for base_dir in "${BASE_DIRS[@]}"; do
        # Expand tilde
        base_dir="${base_dir/#\~/$HOME}"

        # Find directories one level deep
        for dir in "$base_dir"/*/; do
            [[ -d "$dir" ]] || continue

            local name
            name="$(basename "$dir")"

            # Skip if session already exists
            if ! echo "$existing_sessions" | grep -qx "$name"; then
                echo "$name"
            fi
        done
    done
}

# Get the session path from session name
get_session_path() {
    local session_name="$1"

    # Check if it's an existing session
    if tmux has-session -t "$session_name" 2>/dev/null; then
        # Get the path from the session
        tmux display-message -p -t "$session_name" -F "#{pane_current_path}"
        return
    fi

    # Check if it's a full path (starts with / or ~)
    if [[ "$session_name" == /* ]] || [[ "$session_name" == ~* ]]; then
        local expanded_path="${session_name/#\~/$HOME}"
        if [[ -d "$expanded_path" ]]; then
            echo "$expanded_path"
            return
        fi
    fi

    # Check individual projects
    for project in "${PROJECTS[@]}"; do
        project="${project/#\~/$HOME}"
        if [[ "$session_name" == "$(basename "$project")" ]]; then
            echo "$project"
            return
        fi
    done

    # Otherwise, search for the directory in BASE_DIRS
    for base_dir in "${BASE_DIRS[@]}"; do
        base_dir="${base_dir/#\~/$HOME}"

        if [[ "$session_name" == "$(basename "$base_dir")" ]]; then
            echo "$base_dir"
            return
        fi

        local candidate="$base_dir/$session_name"
        if [[ -d "$candidate" ]]; then
            echo "$candidate"
            return
        fi
    done

    # Default to current directory
    echo "$PWD"
}

# Sanitize session name (replace characters that tmux doesn't handle well)
sanitize_session_name() {
    local name="$1"
    # Replace dots, colons, and spaces with underscores
    echo "$name" | sed 's/[.: ]/_/g'
}

# Create a new session with default windows
create_session() {
    local session_name="$1"
    local session_path="$2"

    # Create session with first window (neovim)
    tmux new-session -d -s "$session_name" -c "$session_path" -n "nvim"
    tmux send-keys -t "$session_name:nvim" "nvim" C-m

    # Create second window (terminal)
    tmux new-window -t "$session_name:" -c "$session_path" -n "terminal"

    # Create third window (opencode)
    tmux new-window -t "$session_name:" -c "$session_path" -n "opencode"
    tmux send-keys -t "$session_name:opencode" "opencode ." C-m

    # Switch to first window
    tmux select-window -t "$session_name:nvim"
}

# Create or switch to a session
connect_session() {
    local choice="$1"
    local session_name="${choice#\* }"  # Remove "* " prefix if present
    local custom_name="${2:-}"  # Optional custom session name
    local custom_path="${3:-}"  # Optional custom path
    local session_path

    # Use custom path if provided, otherwise get it from session name
    if [[ -n "$custom_path" ]]; then
        session_path="$custom_path"
    else
        session_path=$(get_session_path "$session_name")
    fi

    # Use custom name if provided and sanitize it
    if [[ -n "$custom_name" ]]; then
        session_name=$(sanitize_session_name "$custom_name")
    fi

    # Create session if it doesn't exist
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        debug "Creating session '$session_name' at '$session_path'"
        create_session "$session_name" "$session_path"
    else
        debug "Session '$session_name' already exists"
    fi

    # Switch to the session
    debug "Switching to session '$session_name'"
    if [[ -n "${TMUX:-}" ]]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    fi
}

# Kill a session
kill_session() {
    local choice="$1"
    local session_name="${choice#\* }"

    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux kill-session -t "$session_name"
    fi
}

# Rename a session
rename_session() {
    local choice="$1"
    local old_name="${choice#\* }"

    # Only rename if it's an existing session
    if ! tmux has-session -t "$old_name" 2>/dev/null; then
        echo "Error: Session '$old_name' does not exist" >&2
        sleep 2
        return 1
    fi

    # Prompt for new name
    local new_name
    new_name=$(prompt_session_name "$old_name")

    # Sanitize the new name
    new_name=$(sanitize_session_name "$new_name")

    # Only rename if the name changed
    if [[ "$new_name" != "$old_name" ]]; then
        if tmux has-session -t "$new_name" 2>/dev/null; then
            echo "Error: Session '$new_name' already exists" >&2
            sleep 2
            return 1
        fi
        tmux rename-session -t "$old_name" "$new_name"
        debug "Renamed session '$old_name' to '$new_name'"
    fi
}

# Prompt for session name with default
prompt_session_name() {
    local default_name="$1"
    local custom_name

    # Clear screen and show prompt (redirect to stderr so it's not captured)
    clear >&2
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    printf "  Session name [\033[1;36m%s\033[0m]: " "$default_name" >&2

    # Open /dev/tty for reading
    exec 3</dev/tty
    read -r custom_name <&3
    exec 3<&-

    debug "prompt_session_name: read custom_name='$custom_name'"

    # Use default if nothing entered
    if [[ -z "$custom_name" ]]; then
        debug "Using default name '$default_name'"
        echo "$default_name"
    else
        debug "Using custom name '$custom_name'"
        echo "$custom_name"
    fi
}

# Prompt for arbitrary path
prompt_custom_path() {
    clear >&2
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    printf "  Enter directory path: " >&2

    # Open /dev/tty for reading
    exec 3</dev/tty
    read -r -e custom_path <&3
    exec 3<&-

    # Expand tilde
    custom_path="${custom_path/#\~/$HOME}"

    if [[ -n "$custom_path" ]] && [[ -d "$custom_path" ]]; then
        echo "$custom_path"
    else
        echo "" >&2
        echo "  Error: Directory does not exist" >&2
        sleep 2
        # Don't echo anything to stdout - return empty
    fi
}

# Main loop
while true; do
    selected=$(
        build_list | fzf \
            --reverse \
            --height 50% \
            --border rounded \
            --prompt "⚡ " \
            --header "^x: kill | ^r: custom path | ^e: rename | enter: connect | esc: exit" \
            --expect=ctrl-x,ctrl-r,ctrl-e \
            --preview 'echo {}' \
            --preview-window hidden
    )

    # Parse fzf output (first line is key, second is selection)
    key=$(echo "$selected" | head -n1)
    choice=$(echo "$selected" | tail -n1)

    case "$key" in
        ctrl-x)
            # Exit if nothing selected
            [[ -n "$choice" ]] || continue
            kill_session "$choice"
            ;;
        ctrl-e)
            # Exit if nothing selected
            [[ -n "$choice" ]] || continue
            
            # Only allow renaming existing sessions
            if [[ "$choice" == "* "* ]]; then
                rename_session "$choice"
            else
                echo "Error: Can only rename existing sessions (marked with *)" >&2
                sleep 2
            fi
            ;;
        ctrl-r)
            # Prompt for custom path
            custom_path=$(prompt_custom_path)
            debug "Got custom_path='$custom_path'"

            if [[ -n "$custom_path" ]]; then
                # Get default session name from directory basename
                dir_name="$(basename "$custom_path")"
                debug "dir_name='$dir_name'"

                # Prompt for session name
                session_name=$(prompt_session_name "$dir_name")
                debug "session_name='$session_name'"

                # Connect using the common function
                connect_session "" "$session_name" "$custom_path"
                exit 0
            else
                debug "Path is empty, continuing loop..."
            fi
            ;;
        *)
            # Exit if nothing selected
            [[ -n "$choice" ]] || exit 0

            # Check if it's an existing session (starts with *)
            if [[ "$choice" == "* "* ]]; then
                # Existing session - connect directly without prompting
                connect_session "$choice"
            else
                # New session - prompt for name with directory as default
                default_name="${choice#\* }"
                session_name=$(prompt_session_name "$default_name")
                connect_session "$choice" "$session_name"
            fi
            exit 0
            ;;
    esac
done
