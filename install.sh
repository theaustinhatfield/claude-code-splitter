#!/bin/bash

# ============================================================
#  CLAUDE CODE SPLITTER - ONE-CLICK INSTALLER
#  https://github.com/theaustinhatfield/claude-code-splitter
#  
#  Installs: tmux
#  Then configures the splitter for compatible AI CLIs
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
echo "  Installing Claude Code Splitter..."
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

# Pick the config for the user's login shell. The installer itself runs under
# bash even when the user's shell is zsh, so $ZSH_VERSION/$BASH_VERSION are
# unreliable here. $SHELL is the login shell.
SHELL_NAME=$(basename "${SHELL:-bash}")
case "$SHELL_NAME" in
    zsh)
        PROFILE="${ZDOTDIR:-$HOME}/.zshrc"
        ;;
    bash)
        if [ "$OS" = "mac" ]; then
            # macOS Terminal starts bash as a login shell.
            PROFILE="$HOME/.bash_profile"
        else
            PROFILE="$HOME/.bashrc"
        fi
        ;;
    *)
        PROFILE="$HOME/.profile"
        ;;
esac

LOGIC_FILE="$HOME/.claude-code-splitter.sh"
export PATH="$HOME/.opencode/bin:$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# ============================================================
# STEP 1: TMUX
# ============================================================
echo "[1/3] tmux (terminal multiplexer)..."
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
# STEP 2: Compatibility Check
# ============================================================
echo "[2/3] Checking for compatible agents..."
FOUND_AGENTS=()
for tool in claude aider gh gemini codex opencode qwen; do
    if command -v "$tool" &>/dev/null || [ -x "$HOME/.local/bin/$tool" ] || [ -x "$HOME/.opencode/bin/$tool" ]; then
        FOUND_AGENTS+=("$tool")
    fi
done
if [ ${#FOUND_AGENTS[@]} -gt 0 ]; then
    echo "      ✓ Found: ${FOUND_AGENTS[*]}"
else
    echo "      ⚠ None found (install any supported CLI to use swarms)"
fi

# ============================================================
# STEP 3: SPLITTER LOGIC
# ============================================================
echo "[3/3] Configuring splitter..."

cat << 'SPLITTER_LOGIC' > "$LOGIC_FILE"
#!/bin/bash
# Claude Code Splitter - Core Engine

# Include the default install locations for all supported CLIs.
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# Parse "opencode4" -> CLAUDE_SPLIT_TOOL=opencode, CLAUDE_SPLIT_COUNT=4
claude_split_parse_arg() {
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

    CLAUDE_SPLIT_TOOL="$tool"
    CLAUDE_SPLIT_COUNT="$count"
    return 0
}

claude_split() {
    local session="claude-swarm"
    local launch_dir="$PWD"
    local missing=()
    local arg tool count win i

    if ! command -v tmux &>/dev/null; then
        echo "tmux is required. Install it with: brew install tmux (macOS) or sudo apt-get install tmux (Linux)"
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        echo "Usage: claude4 | opencode4 | claude2 aider2 ..."
        return 1
    fi

    # Validate every argument before starting a session.
    for arg in "$@"; do
        if ! claude_split_parse_arg "$arg"; then
            echo "Invalid swarm argument: '$arg'"
            echo "Usage: claude4 | opencode4 | claude2 aider2 ..."
            return 1
        fi
        tool="$CLAUDE_SPLIT_TOOL"
        if ! command -v "$tool" &>/dev/null; then
            missing+=("$tool")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo "Missing: ${missing[*]}"
        return 1
    fi

    # Recursion guard
    if [ -n "$TMUX" ] && [ "$(tmux display-message -p '#S' 2>/dev/null)" = "$session" ]; then
        echo "Already in swarm"
        return 1
    fi

    # Launch in the directory the command was run from.
    tmux kill-session -t "$session" 2>/dev/null || true
    tmux new-session -d -s "$session" -c "$launch_dir" || {
        echo "Failed to start tmux session"
        return 1
    }

    tmux set-option -t "$session" mouse on
    win=$(tmux display-message -p -t "$session" '#{window_id}' 2>/dev/null)
    if [ -n "$win" ]; then
        tmux set-option -w -t "$win" allow-rename off
        tmux set-option -w -t "$win" pane-border-status top
        tmux set-option -w -t "$win" pane-border-format " #[fg=black,bg=white,bold] #T #[default] "
    fi

    local first=1
    for arg in "$@"; do
        claude_split_parse_arg "$arg" || continue
        tool="$CLAUDE_SPLIT_TOOL"
        count="$CLAUDE_SPLIT_COUNT"
        for ((i=1; i<=count; i++)); do
            if [ "$first" -eq 1 ]; then
                first=0
            else
                tmux split-window -t "$session" -c "$launch_dir"
                tmux select-layout -t "$session" tiled
            fi
            tmux send-keys -t "$session" "$tool" C-m
            tmux select-pane -t "$session" -T "$tool"
        done
    done
    tmux attach -t "$session"
}

swarm_todo() {
    if [ -z "$TMUX" ]; then
        echo "Not in a swarm session"
        return 1
    fi
    local current title tool
    current=$(tmux display-message -p '#T')
    tool="${current%%|*}"
    while [ "${tool% }" != "$tool" ]; do
        tool="${tool% }"
    done
    if [ "$#" -eq 0 ]; then
        title="$tool"
    else
        title="$tool | $*"
    fi
    tmux select-pane -T "$title"
}

# Hook for magic commands like "claude4" and "opencode4".
if [ -n "$BASH_VERSION" ]; then
    command_not_found_handle() {
        if claude_split_parse_arg "$1"; then
            claude_split "$@"
            return $?
        fi
        printf 'bash: %s: command not found\n' "$1" >&2
        return 127
    }
elif [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        if claude_split_parse_arg "$1"; then
            claude_split "$@"
            return $?
        fi
        printf 'zsh: command not found: %s\n' "$1" >&2
        return 127
    }
fi

# Aliases for the common counts (larger counts use the not-found hook).
for n in 1 2 3 4 5 6 7 8 9 10 12 16 20 32 50 100; do
    for t in claude aider qwen gh gemini codex opencode; do
        alias "${t}${n}=claude_split ${t}${n}"
    done
done
alias todo=swarm_todo
SPLITTER_LOGIC

chmod 600 "$LOGIC_FILE"

# Register with shell. Use awk instead of sed -i so this works with both
# GNU sed and BSD/macOS sed, and make repeated installs idempotent.
register_profile() {
    local profile="$1"
    local tmp
    [ -f "$profile" ] || : > "$profile"
    tmp=$(mktemp "${TMPDIR:-/tmp}/claude-splitter.XXXXXX") || return 1
    awk '!/Claude Code Splitter/ && !/claude-code-splitter/' "$profile" > "$tmp"
    {
        printf '\n# Claude Code Splitter\n'
        printf 'source "%s"\n' "$LOGIC_FILE"
    } >> "$tmp"
    cat "$tmp" > "$profile"
    rm -f "$tmp"
}
register_profile "$PROFILE"
echo "      ✓ Added to $PROFILE"

# Activate NOW
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
echo "  ║     Type claude4, claude8, or claudeX                ║"
echo "  ║     (any number) to begin your swarm.                ║"
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
    if [ "$INTERACTIVE" -eq 1 ] && command -v tmux &>/dev/null; then
        echo "Launching ${FIRST_TOOL}4 swarm in 3 seconds..."
        echo "(Press Ctrl+C to cancel)"
        sleep 3
        claude_split "${FIRST_TOOL}4"
    elif [ "$INTERACTIVE" -ne 1 ]; then
        echo "Open a new terminal and run one of:"
        echo "  claude4"
        echo "  opencode4"
    else
        echo "tmux is not installed yet. Install tmux, then run:"
        echo "  claude4"
    fi
else
    echo "No agents installed yet. After installing one, run:"
    echo "  source \"$PROFILE\""
    echo "  claude4"
fi

echo ""
echo "Tip: If new commands like opencode4 are not found, run:"
echo "  source \"$PROFILE\""
