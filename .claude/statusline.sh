#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
# レート制限の使用率（定額プランのみ・最初のAPIレスポンス後に出現、各ウィンドウは独立して欠落し得る）
RATE_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
RATE_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Show git branch if in a git repo
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH=" | ⎇ $BRANCH"
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

# レート制限の使用率バーを組み立てる。引数: ラベル, used_percentage(0〜100)
# 80%超で ⚠️、100%以上（超過）で 🚨 を末尾に付ける
format_rate() {
    local label="$1"
    local pct="$2"
    [ -z "$pct" ] && return
    awk -v label="$label" -v pct="$pct" 'BEGIN {
        # 5目盛りのバーを組み立てる
        filled = int(pct / 20 + 0.5)
        if (filled > 5) filled = 5
        if (filled < 0) filled = 0
        bar = ""
        for (i = 0; i < filled; i++) bar = bar "▓"
        for (i = filled; i < 5; i++) bar = bar "░"
        # しきい値に応じた警告記号
        icon = ""
        if (pct >= 100)     icon = " 🚨"
        else if (pct >= 80) icon = " ⚠️"
        printf " | %s %s %d%%%s", label, bar, int(pct + 0.5), icon
    }'
}

PERCENT_USED=0
CURRENT_TOKENS=0
if [ "$USAGE" != "null" ]; then
    # Calculate current context from current_usage fields
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
fi

RATE_DISPLAY="$(format_rate "5h" "$RATE_5H")$(format_rate "7d" "$RATE_7D")"

TILDE="~"
echo "[$MODEL_DISPLAY] Context: ${PERCENT_USED}% ($(format_tokens "$CURRENT_TOKENS")/$(format_tokens "$CONTEXT_SIZE"))$RATE_DISPLAY | ⌂ ${CURRENT_DIR/$HOME/$TILDE}$GIT_BRANCH"
