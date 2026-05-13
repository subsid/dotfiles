#!/usr/bin/env bash
# Claude Code status line command

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // "?"')
dir=$(basename "$cwd")

total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Model info
model_id=$(echo "$input" | jq -r '.model // empty')
case "$model_id" in
    *opus*4*7*)   model_short="opus-4.7" ;;
    *opus*4*6*)   model_short="opus-4.6" ;;
    *sonnet*4*6*) model_short="sonnet-4.6" ;;
    *haiku*4*5*)  model_short="haiku-4.5" ;;
    "")           model_short="" ;;
    *)            model_short="$model_id" ;;
esac

# Effort level from settings
effort=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)

# Approximate cost: Sonnet 4 pricing: $3/MTok input, $15/MTok output
cost=$(echo "$total_input $total_output" | awk '{printf "%.4f", ($1 * 3 + $2 * 15) / 1000000}')

# Format token display
total_tokens=$((total_input + total_output))
if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
    ctx_k=$((ctx_size / 1000))
    total_k=$(echo "$total_tokens" | awk '{printf "%.1f", $1 / 1000}')
    token_str="${total_k}k / ${ctx_k}k"
else
    total_k=$(echo "$total_tokens" | awk '{printf "%.1f", $1 / 1000}')
    token_str="${total_k}k tokens"
fi

# Build left section
left=" ${dir} | tokens: ${token_str}"
[ -n "$used_pct" ] && left="${left} ($(printf '%.0f' "$used_pct")% used)"
left="${left} | cost: \$${cost}"

# Build right section (model + effort)
right=""
[ -n "$model_short" ] && right="${model_short}"
[ -n "$effort" ] && right="${right:+${right} | }effort: ${effort}"

# Right-align using terminal width
if [ -n "$right" ]; then
    width=${COLUMNS:-$(tput cols 2>/dev/null || echo 120)}
    left_len=${#left}
    right_len=${#right}
    padding=$((width - left_len - right_len - 1))
    if [ "$padding" -gt 1 ]; then
        printf "%s%*s%s" "$left" "$padding" "" "$right"
    else
        printf "%s | %s" "$left" "$right"
    fi
else
    printf "%s" "$left"
fi
