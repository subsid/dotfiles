#!/usr/bin/env bash
# Claude Code status line command

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // "?"')
dir=$(basename "$cwd")

total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

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

# Build status parts
parts=""
parts="${parts} ${dir}"
parts="${parts} | tokens: ${token_str}"
[ -n "$used_pct" ] && parts="${parts} ($(printf '%.0f' "$used_pct")% used)"
parts="${parts} | cost: \$${cost}"

printf "%s" "$parts"
