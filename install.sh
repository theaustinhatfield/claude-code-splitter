#!/bin/bash

# ============================================================
#  CLAUDE CODE SPLITTER - ONE-CLICK INSTALLER
#  https://github.com/theaustinhatfield/claude-code-splitter
#  
#  Installs: tmux, Claude CLI, OpenCode CLI
#  Then launches your first swarm automatically!
# ============================================================

clear
printf "\033c" 2>/dev/null || true
echo ""
echo "  ╔═══════════════════════════════════════════════════════╗"
echo "  ║                                                       ║"
echo "  ║      C L A U D E   C O D E   S P L I T T E R         ║"
echo "  ║                                                       ║"
echo "  ║         One Command. Infinite Agents.                 ║"
echo "  ║                                                       ║"
echo "  ╚═══════════════════════════════════════════════════════╝"
echo ""
echo "  Installing all AI coding agents..."
echo ""

INTERACTIVE=0
if [ -t 0 ] && [ -t 1 ]; then
    INTERACTIVE=1
fi

# Detect OS
OS="linux"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
fi

PROFILE="$HOME/.bashrc"
[ -n "$ZSH_VERSION" ] && PROFILE="$HOME/.zshrc"
[ -f "$HOME/.zshrc" ] && [ -z "$BASH_VERSION" ] && PROFILE="$HOME/.zshrc"

LOGIC_FILE="$HOME/.claude-code-splitter.sh"
export PATH="$HOME/.local/bin:$PATH"

# ============================================================
# STEP 1: TMUX
# ============================================================
echo "[1/7] tmux (terminal multiplexer)..."
if command -v tmux &>/dev/null; then
    echo "      ✓ Already installed"
else
    if [ "$OS" = "mac" ]; then
        brew install tmux 2>/dev/null && echo "      ✓ Installed" || echo "      ⚠ Install manually: brew install tmux"
    else
        APT_DEFAULT_SOURCES=0
        if ! sudo apt-get update -qq 2>/dev/null; then
            # Retry using only the default sources.list to bypass broken third-party repos.
            APT_DEFAULT_SOURCES=1
            sudo apt-get -o Dir::Etc::sourceparts="-" -o Dir::Etc::sourcelist="/etc/apt/sources.list" update -qq 2>/dev/null || true
        fi
        if [ "$APT_DEFAULT_SOURCES" -eq 1 ]; then
            sudo apt-get -o Dir::Etc::sourceparts="-" -o Dir::Etc::sourcelist="/etc/apt/sources.list" install -y tmux &>/dev/null
        else
            sudo apt-get install -y tmux &>/dev/null
        fi
        if command -v tmux &>/dev/null; then
            if [ "$APT_DEFAULT_SOURCES" -eq 1 ]; then
                echo "      ✓ Installed (default sources only)"
            else
                echo "      ✓ Installed"
            fi
        else
            echo "      ⚠ Install failed. If apt has a bad repo (e.g., yarn), fix it and retry."
            echo "        Then run: sudo apt-get update && sudo apt-get install -y tmux"
            echo "        Hint: check /etc/apt/sources.list.d for broken repos."
        fi
    fi
fi

# ============================================================
# STEP 2: CLAUDE CLI (Anthropic)
# ============================================================
echo "[2/7] Claude Code (Anthropic)..."
if command -v claude &>/dev/null || [ -f "$HOME/.local/bin/claude" ]; then
    echo "      ✓ Already installed"
else
    curl -fsSL https://claude.ai/install.sh -o /tmp/claude-install.sh 2>/dev/null
    bash /tmp/claude-install.sh &>/dev/null && echo "      ✓ Installed" || echo "      ⚠ Install manually: curl -fsSL https://claude.ai/install.sh | bash"
    rm -f /tmp/claude-install.sh
fi

# ============================================================
# STEP 3: OPENCODE CLI (Anomaly)
# ============================================================
echo "[3/7] OpenCode (Anomaly)..."
if command -v opencode &>/dev/null || [ -f "$HOME/.local/bin/opencode" ]; then
    echo "      ✓ Already installed"
else
    curl -fsSL https://opencode.ai/install -o /tmp/opencode-install.sh 2>/dev/null
    if bash /tmp/opencode-install.sh &>/dev/null; then
        echo "      ✓ Installed"
    else
        if command -v npm &>/dev/null; then
            npm install -g opencode-ai &>/dev/null && echo "      ✓ Installed (npm)"
        elif command -v pnpm &>/dev/null; then
            pnpm install -g opencode-ai &>/dev/null && echo "      ✓ Installed (pnpm)"
        elif command -v yarn &>/dev/null; then
            yarn global add opencode-ai &>/dev/null && echo "      ✓ Installed (yarn)"
        elif command -v bun &>/dev/null; then
            bun install -g opencode-ai &>/dev/null && echo "      ✓ Installed (bun)"
        else
            echo "      ⚠ Install manually: curl -fsSL https://opencode.ai/install | bash"
        fi
    fi
    rm -f /tmp/opencode-install.sh
fi

# ============================================================
# STEP 4-6: Optional Agents
# ============================================================
echo "[4/7] Skipping optional agents (Gemini, Aider, gh, Qwen, Codex)..."
echo "      (Install them manually to use 'gemini4', 'aider2', etc.)"

# ============================================================
# STEP 6: SPLITTER LOGIC
# ============================================================
echo "[7/7] Configuring splitter..."

cat << 'SPLITTER_LOGIC' > "$LOGIC_FILE"
#!/bin/bash
# Claude Code Splitter - Core Engine

export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

claude_split() {
    local session="claude-swarm"
    local whitelist="claude|qwen|gemini|codex|opencode|aider|gh"
    
    # Validate tools
    local missing=()
    for arg in "$@"; do
        local tool="${arg%%[0-9]*}"
        if ! echo "$tool" | grep -qE "^($whitelist)$"; then
            echo "Blocked: '$tool' not authorized"; return 1
        fi
        if ! command -v "$tool" &>/dev/null && [ ! -x "$HOME/.local/bin/$tool" ]; then
            missing+=("$tool")
        fi
    done
    
    [ ${#missing[@]} -gt 0 ] && { echo "Missing: ${missing[*]}"; return 1; }
    
    # Recursion guard
    [ -n "$TMUX" ] && [ "$(tmux display-message -p '#S' 2>/dev/null)" = "$session" ] && {
        echo "Already in swarm"; return 1
    }
    
    # Launch
    tmux kill-session -t "$session" 2>/dev/null || true
    tmux new-session -d -s "$session"
    tmux set -t "$session" mouse on
    tmux set -t "$session" allow-rename off
    tmux set -t "$session" pane-border-status top
    tmux set -t "$session" pane-border-format " #[fg=black,bg=white,bold] #T #[default] "
    
    local first=1
    for arg in "$@"; do
        local tool="${arg%%[0-9]*}"
        local count="${arg##*[!0-9]}"; count="${count:-1}"
        for ((i=1; i<=count; i++)); do
            if [ "$first" -eq 1 ]; then
                tmux send-keys -t "$session" "$tool" C-m
                tmux select-pane -t "$session" -T "$tool"
                first=0
            else
                tmux split-window -t "$session"
                tmux send-keys -t "$session" "$tool" C-m
                tmux select-pane -T "$tool"
                tmux select-layout -t "$session" tiled
            fi
        done
    done
    tmux attach -t "$session"
}

swarm_todo() {
    if [ -z "$TMUX" ]; then
        echo "Not in a swarm session"; return 1
    fi
    local current title tool
    current=$(tmux display-message -p '#T')
    tool="${current%% | *}"
    if [ -z "$*" ]; then
        title="$tool"
    else
        title="$tool | $*"
    fi
    tmux select-pane -T "$title"
}

# Hook for magic commands like "claude4"
if [ -n "$BASH_VERSION" ]; then
    command_not_found_handle() {
        if echo "$1" | grep -qE "^(claude|qwen|gemini|codex|opencode|aider|gh)[0-9]*$"; then
            claude_split "$@"; return $?
        fi
        echo "bash: $1: command not found"; return 127
    }
elif [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        if echo "$1" | grep -qE "^(claude|qwen|gemini|codex|opencode|aider|gh)[0-9]*$"; then
            claude_split "$@"; return $?
        fi
        echo "zsh: command not found: $1"; return 127
    }
fi

# Aliases
for n in 1 2 3 4 5 6 7 8 9 10 12 16 20; do
    for t in claude aider qwen gh gemini codex opencode; do
        alias "${t}${n}=claude_split ${t}${n}"
    done
done
alias todo=swarm_todo
SPLITTER_LOGIC

chmod 600 "$LOGIC_FILE"

# Register with shell
sed -i '/claude-code-splitter/d' "$PROFILE" 2>/dev/null || true
echo "" >> "$PROFILE"
echo "# Claude Code Splitter" >> "$PROFILE"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$PROFILE"
echo "source \"$LOGIC_FILE\"" >> "$PROFILE"

# Activate NOW
export PATH="$HOME/.local/bin:$PATH"
source "$LOGIC_FILE"

# Count what's ready
READY_COUNT=0
READY_TOOLS=""
command -v claude &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS claude"
command -v aider &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS aider"
command -v gh &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS gh"
command -v gemini &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS gemini"
command -v opencode &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS opencode"
command -v qwen &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS qwen"
command -v codex &>/dev/null && READY_COUNT=$((READY_COUNT+1)) && READY_TOOLS="$READY_TOOLS codex"

echo ""
echo "  ╔═══════════════════════════════════════════════════════╗"
echo "  ║                                                       ║"
echo "  ║   ✓  INSTALLATION COMPLETE                           ║"
echo "  ║                                                       ║"
echo "  ╠═══════════════════════════════════════════════════════╣"
echo "  ║                                                       ║"
echo "  ║   Ready agents:$READY_TOOLS"
echo "  ║                                                       ║"
echo "  ║   Usage:                                              ║"
echo "  ║     claude4        → 4 Claude agents                 ║"
echo "  ║     aider2 gh2     → Mixed swarm                     ║"
echo "  ║     gemini4        → 4 Gemini agents                 ║"
echo "  ║                                                       ║"
echo "  ║   Navigation:                                         ║"
echo "  ║     • Click any pane to select                       ║"
echo "  ║     • Drag borders to resize                         ║"
echo "  ║     • Ctrl+B Z to fullscreen                         ║"
echo "  ║     • Ctrl+B D to detach                             ║"
echo "  ║     • todo \"fix tests\" (title hint)                ║"
echo "  ║                                                       ║"
echo "  ╚═══════════════════════════════════════════════════════╝"
echo ""

# Auto-launch with first available agent
if [ "$READY_COUNT" -gt 0 ]; then
    FIRST_TOOL=$(echo $READY_TOOLS | awk '{print $1}')
    echo "Launching ${FIRST_TOOL}4 swarm in 3 seconds..."
    echo "(Press Ctrl+C to cancel)"
    sleep 3
    if [ "$INTERACTIVE" -eq 1 ] && command -v tmux &>/dev/null; then
        claude_split "${FIRST_TOOL}4"
    else
        if [ "$INTERACTIVE" -ne 1 ]; then
            echo "Not running in a TTY. Open a terminal and run:"
            echo "  claude4"
        else
            echo "tmux is not installed yet. Install tmux, then run:"
            echo "  claude4"
        fi
    fi
else
    echo "No agents installed yet. After installing one, run:"
    echo "  source ~/.bashrc"
    echo "  claude4"
fi

echo "\nTip: If new commands like opencode4 are not found, run:"
echo "  source ~/.bashrc"
