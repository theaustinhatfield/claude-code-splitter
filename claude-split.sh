#!/bin/bash

# --- Claude Code Splitter (Standalone) ---
# GitHub: https://github.com/theaustinhatfield/claude-code-splitter

# Force Path for newly installed agents
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

LOG_FILE="$HOME/.claude-code-splitter.log"
SESSION="claude-swarm"
ALLOWED_TOOLS="^(claude|qwen|gemini|codex|opencode|aider|gh)$"

if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is required."
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Usage: ./claude-split.sh claude4"
    exit 1
fi

# Tool validation with Path fallbacks
MISSING=()
for arg in "$@"; do
    METHOD=$(echo "$arg" | sed -E "s/^([a-z-]+)([0-9]*)$/\1/")
    [[ ! "$METHOD" =~ $ALLOWED_TOOLS ]] && exit 1
    
    if ! command -v "$METHOD" &> /dev/null; then
        if [ ! -f "$HOME/.local/bin/$METHOD" ]; then
            MISSING+=("$METHOD")
        fi
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo -e "\033[1;33m⚠️  Binary Missing:\033[0m ${MISSING[*]}"
    exit 1
fi

# Launch
tmux kill-session -t "$SESSION" 2>/dev/null
tmux new-session -d -s "$SESSION"

tmux set -g mouse on
tmux set -g allow-rename off
tmux set -g pane-border-status top
tmux set -g pane-border-format " #[fg=black,bg=white,bold] #T #[default] "

FIRST=1
for arg in "$@"; do
    M=$(echo "$arg" | sed -E "s/^([a-z-]+)([0-9]*)$/\1/")
    C=$(echo "$arg" | sed -E "s/^([a-z-]+)([0-9]*)$/\2/")
    C=${C:-1}
    for ((i=1; i<=C; i++)); do
        if [ "$FIRST" -eq 1 ]; then
            tmux send-keys -t "$SESSION" "$M" C-m
            tmux select-pane -t "$SESSION" -T "$M"
            FIRST=0
        else
            tmux split-window -t "$SESSION"
            tmux send-keys -t "$SESSION" "$M" C-m
            tmux select-pane -T "$M"
            tmux select-layout -t "$SESSION" tiled
        fi
    done
done

tmux attach -t "$SESSION"
