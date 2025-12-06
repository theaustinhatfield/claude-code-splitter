#!/bin/bash

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "Claude Code not found. Installing..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Verify installation
if ! command -v claude &> /dev/null; then
    echo "Error: Failed to install Claude Code. Please install manually: curl -fsSL https://claude.ai/install.sh | bash"
    exit 1
fi

echo "Claude Code is ready."

# Check for tmux
if ! command -v tmux &> /dev/null; then
    echo "tmux not found. Installing..."
    if command -v brew &> /dev/null; then
        brew install tmux
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y tmux
    else
        echo "Error: tmux is not installed and could not be installed automatically. Please install tmux."
        exit 1
    fi
fi


# Configuration
SESSION="claude_grid"
AGENT_COUNT=4

# Check if session exists
if tmux has-session -t $SESSION 2>/dev/null; then
    echo "Session $SESSION already exists. Attaching..."
    tmux attach -t $SESSION
    exit 0
fi

# Create new session
tmux new-session -d -s $SESSION

# Set options
tmux set -g mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-format " #T "

# Create agents
# Agent 1 is already created with the session
tmux select-pane -t 0 -T "Agent-1"
tmux send-keys -t 0 'claude' C-m

# Create remaining agents
for i in $(seq 2 $AGENT_COUNT); do
    tmux split-window -t $SESSION
    tmux select-layout tiled
    tmux select-pane -T "Agent-$i"
    tmux send-keys "claude" C-m
done

# Final layout adjustment
tmux select-layout tiled
tmux attach -t $SESSION
