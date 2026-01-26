#!/bin/bash

# Claude Code Splitter - Installer
# Sets up "Infinity Mode" for Claude Code

set -e

# Colors for output
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Claude Code Splitter - Infinity Mode Installer${NC}"
echo "------------------------------------------------"

# Check for tmux
if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}tmux is not installed.${NC}"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Attempting to install tmux..."
        # Try to install directly, ignore update errors from broken external repos
        sudo apt-get update -y || true
        sudo apt-get install -y tmux || { echo -e "${YELLOW}Could not install tmux automatically. Please install it manually: sudo apt-get install tmux${NC}"; exit 1; }
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            echo "Attempting to install tmux via brew..."
            brew install tmux
        else
            echo -e "${YELLOW}Homebrew not found. Please install tmux manually: brew install tmux${NC}"; exit 1;
        fi
    else
        echo -e "${YELLOW}Please install tmux manually for your OS.${NC}"; exit 1;
    fi
fi

# Determine shell profile
SHELL_TYPE=$(basename "$SHELL")
PROFILE=""

if [ "$SHELL_TYPE" == "zsh" ]; then
    PROFILE="$HOME/.zshrc"
elif [ "$SHELL_TYPE" == "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
        PROFILE="$HOME/.bash_profile"
    fi
fi

if [ -z "$PROFILE" ]; then
    echo -e "${YELLOW}Could not detect shell profile (bash or zsh). Defaulting to ~/.bashrc${NC}"
    PROFILE="$HOME/.bashrc"
fi

echo -e "Installing to ${CYAN}$PROFILE${NC}..."

# Core logic for the shell
cat >> "$PROFILE" << 'EOF'

# --- Claude Code Splitter (Infinity Mode) ---
claude_split() {
    if ! command -v tmux &>/dev/null; then
        echo "Installing tmux..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get update && sudo apt-get install -y tmux
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install tmux
        fi
    fi
    local s="claude-swarm"
    tmux kill-session -t $s 2>/dev/null
    tmux new-session -d -s $s
    tmux set -g mouse on
    tmux set -g pane-border-status top
    tmux set -g pane-border-format " #[fg=white,bg=blue,bold] #T #[default] "
    
    local f=1
    for a in "$@"; do
        if [[ $a =~ ^(claude)([0-9]*)$ ]]; then
            local m="claude"
            local c=$(echo $a | sed -E "s/(claude)([0-9]*)/\2/")
            c=${c:-1}
            
            if [ "$c" -gt 20 ]; then
                echo "Safety limit: Spawning $c agents. Maximum recommended is 20."
                read -p "Are you sure? (y/n) " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then return; fi
            fi

            for ((i=1; i<=c; i++)); do
                if [ $f -eq 1 ]; then
                    tmux send-keys -t $s "$m" C-m
                    tmux select-pane -t $s -T "$m"
                    f=0
                else
                    tmux split-window -t $s
                    tmux send-keys -t $s "$m" C-m
                    tmux select-pane -T "$m"
                    tmux select-layout -t $s tiled
                fi
            done
        fi
    done
    tmux attach -t $s
}

# Command not found handler
if [ -n "$BASH_VERSION" ]; then
    command_not_found_handle() {
        if [[ $1 =~ ^(claude)([0-9]+)$ ]]; then
            claude_split "$@"
        else
            echo "bash: $1: command not found"
            return 127
        fi
    }
elif [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        if [[ $1 =~ ^(claude)([0-9]+)$ ]]; then
            claude_split "$@"
        else
            echo "zsh: command not found: $1"
            return 127
        fi
    }
fi

# Pre-defined aliases
for i in {1..20}; do
    alias "claude$i"="claude_split claude$i"
done

echo -e "\nClaude Code Splitter Installed!"
echo -e "Type \033[1;34mclaude4\033[0m, \033[1;34mclaude8\033[0m, or \033[1;34mclaudeX\033[0m (any number) to begin your swarm.\n"
# --------------------------------------------
EOF

echo -e "${GREEN}Success!${NC}"
echo -e "Please run ${YELLOW}source $PROFILE${NC} or restart your terminal."
echo -e "Then try typing ${CYAN}claude4${NC} to start your swarm!"
