#!/bin/bash

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "Claude Code not found. Installing..."
    if command -v npm &> /dev/null; then
        npm install -g @anthropic-ai/claude-code
    else
        echo "Error: npm is not installed. Please install Node.js and npm to continue."
        exit 1
    fi
fi

# Verify installation
if ! command -v claude &> /dev/null; then
    echo "Error: Failed to install Claude Code. Please install manually: npm i -g @anthropic-ai/claude-code"
    exit 1
fi

echo "Claude Code is ready."


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
