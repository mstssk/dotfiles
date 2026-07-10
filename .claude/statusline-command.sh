#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
TOTAL_COST_USD=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Show git branch if in a git repo
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH=" | 🌿 $BRANCH"
    fi
fi

# トークン数を 12.3k / 1.2M のような読みやすい形式に変換する
format_tokens() {
    if [ "$1" -ge 1000000 ]; then
        awk -v t="$1" 'BEGIN { v = t / 1000000; printf (v == int(v)) ? "%dM" : "%.1fM", v }'
    elif [ "$1" -ge 1000 ]; then
        awk -v t="$1" 'BEGIN { v = t / 1000; printf (v == int(v)) ? "%dk" : "%.1fk", v }'
    else
        echo "$1"
    fi
}

PERCENT_USED=0
CURRENT_TOKENS=0
if [ "$USAGE" != "null" ]; then
    # Calculate current context from current_usage fields
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
fi

COST_DISPLAY=""
if [ -n "$TOTAL_COST_USD" ]; then
    COST_DISPLAY=" | 💰 \$$(awk -v c="$TOTAL_COST_USD" 'BEGIN { printf "%.2f", c }')"
fi

TILDE="~"
echo "[$MODEL_DISPLAY] Context: ${PERCENT_USED}% ($(format_tokens "$CURRENT_TOKENS")/$(format_tokens "$CONTEXT_SIZE"))$COST_DISPLAY | 📁 ${CURRENT_DIR/$HOME/$TILDE}$GIT_BRANCH"
