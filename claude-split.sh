#!/bin/bash

# --- Claude Code Splitter (Standalone) ---
# GitHub: https://github.com/theaustinhatfield/claude-code-splitter

# Force PATH for newly installed agents
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

SESSION="claude-swarm"

if ! command -v tmux &>/dev/null; then
    echo "Error: tmux is required."
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Usage: ./claude-split.sh claude4"
    echo "       ./claude-split.sh opencode4"
    echo "       ./claude-split.sh claude2 aider2"
    exit 1
fi

parse_arg() {
    local arg="$1"
    local tool="${arg%%[0-9]*}"
    local count="${arg#"$tool"}"

    case "$tool" in
        claude|qwen|gemini|codex|opencode|aider|gh) ;;
        *) return 1 ;;
    esac

    case "$count" in
        *[!0-9]*) return 1 ;;
    esac

    count="${count:-1}"
    [ "$count" -ge 1 ] 2>/dev/null || return 1

    TOOL="$tool"
    COUNT="$count"
    return 0
}

MISSING=()
for arg in "$@"; do
    if ! parse_arg "$arg"; then
        echo "Invalid swarm argument: '$arg'"
        exit 1
    fi
    command -v "$TOOL" &>/dev/null || MISSING+=("$TOOL")
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo -e "\033[1;33m⚠️  Binary Missing:\033[0m ${MISSING[*]}"
    exit 1
fi

# Recursion guard
if [ -n "$TMUX" ] && [ "$(tmux display-message -p '#S' 2>/dev/null)" = "$SESSION" ]; then
    echo "Already in swarm"
    exit 1
fi

# Launch in the directory the command was run from
tmux kill-session -t "$SESSION" 2>/dev/null || true
tmux new-session -d -s "$SESSION" -c "$PWD" || {
    echo "Error: failed to start tmux session."
    exit 1
}

tmux set-option -t "$SESSION" mouse on
WIN=$(tmux display-message -p -t "$SESSION" '#{window_id}' 2>/dev/null)
if [ -n "$WIN" ]; then
    tmux set-option -w -t "$WIN" allow-rename off
    tmux set-option -w -t "$WIN" pane-border-status top
    tmux set-option -w -t "$WIN" pane-border-format " #[fg=black,bg=white,bold] #T #[default] "
fi

FIRST=1
for arg in "$@"; do
    parse_arg "$arg" || continue
    for ((i=1; i<=COUNT; i++)); do
        if [ "$FIRST" -eq 1 ]; then
            FIRST=0
        else
            tmux split-window -t "$SESSION" -c "$PWD"
            tmux select-layout -t "$SESSION" tiled
        fi
        tmux send-keys -t "$SESSION" "$TOOL" C-m
        tmux select-pane -t "$SESSION" -T "$TOOL"
    done
done

tmux attach -t "$SESSION"
