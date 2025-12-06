#!/bin/bash
# Test script to verify tmux logic for 7 agents

SESSION="test_agents"
tmux kill-session -t $SESSION 2>/dev/null
sleep 0.5
tmux new-session -d -s $SESSION
tmux set -g pane-border-status top
tmux set -g pane-border-format " #T "

# Agent 1
tmux send-keys 'echo "Agent 1 ready"' C-m; tmux select-pane -T "Agent-1"

# Logic for 7 agents (max 3 cols)
# Cols = 3
# Create columns
tmux split-window -h
tmux send-keys 'echo "Agent 2 ready"' C-m; tmux select-pane -T "Agent-2"
tmux split-window -h
tmux send-keys 'echo "Agent 3 ready"' C-m; tmux select-pane -T "Agent-3"

# Go back to layout tiled?
tmux select-layout tiled

# Create remaining 4 agents
tmux split-window -v
tmux send-keys 'echo "Agent 4 ready"' C-m; tmux select-pane -T "Agent-4"
tmux split-window -v
tmux send-keys 'echo "Agent 5 ready"' C-m; tmux select-pane -T "Agent-5"
tmux split-window -v
tmux send-keys 'echo "Agent 6 ready"' C-m; tmux select-pane -T "Agent-6"
tmux split-window -v
tmux send-keys 'echo "Agent 7 ready"' C-m; tmux select-pane -T "Agent-7"

tmux select-layout tiled

# List panes to verify
tmux list-panes -t $SESSION -F "#{pane_index}: #{pane_title}"
