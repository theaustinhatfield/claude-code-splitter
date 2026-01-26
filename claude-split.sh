#!/bin/bash

# Claude Code Splitter - Core Script
# Manages the tmux session for parallel Claude Code agents

SESSION="claude-swarm"

# Function to parse agent count
get_count() {
    local arg=$1
    if [[ $arg =~ ^claude([0-9]+)$ ]]; then
        echo "${BASH_REMATCH[1]}"
    elif [[ $arg =~ ^[0-9]+$ ]]; then
        echo "$arg"
    else
        echo "1"
    fi
}

COUNT=$(get_count "$1")

# Performance warning
if [ "$COUNT" -gt 20 ]; then
    echo "Warning: Spawning $COUNT agents may impact system performance."
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Kill existing session if it exists
tmux kill-session -t "$SESSION" 2>/dev/null

# Initialize tmux session
tmux new-session -d -s "$SESSION"
tmux set -g mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-format " #[fg=white,bg=blue,bold] #T #[default] "

# Spawn agents
FIRST=1
for ((i=1; i<=COUNT; i++)); do
    if [ $FIRST -eq 1 ]; then
        tmux send-keys -t "$SESSION" "claude" C-m
        tmux select-pane -t "$SESSION" -T "claude"
        FIRST=0
    else
        tmux split-window -t "$SESSION"
        tmux send-keys -t "$SESSION" "claude" C-m
        tmux select-pane -T "claude"
        tmux select-layout -t "$SESSION" tiled
    fi
done

# Navigation Cheat Sheet
clear
echo -e "\033[1;34mClaude Code Splitter - Infinity Mode\033[0m"
echo "------------------------------------------------"
echo "Spawning $COUNT Claude agents in '$SESSION' session."
echo ""
echo -e "\033[1;33mKeyboard Shortcuts:\033[0m"
echo -e "  \033[1mCtrl+B, Arrows\033[0m    - Move between agents"
echo -e "  \033[1mCtrl+B, Z\033[0m         - Zoom/Maximize one agent"
echo -e "  \033[1mCtrl+B, D\033[0m         - Detach (leave them running)"
echo -e "  \033[1mCtrl+D\033[0m            - Close current agent"
echo -e "  \033[1mMouse Click\033[0m       - Select agent"
echo -e "  \033[1mMouse Resize\033[0m      - Drag borders to resize"
echo ""
echo "Attaching to session..."
sleep 2

tmux attach -t "$SESSION"
