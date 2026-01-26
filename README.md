# Claude Code Splitter

If you find this useful, please [star the repo](https://github.com/theaustinhatfield/claude-code-splitter) on GitHub.

```
+---------------------------+---------------------------+
|                           |                           |
|         Agent-1           |         Agent-2           |
|                           |                           |
|   "Fix the login bug"     |   "Add unit tests"        |
|                           |                           |
+---------------------------+---------------------------+
|                           |                           |
|         Agent-3           |         Agent-4           |
|                           |                           |
|   "Refactor database"     |   "Update docs"           |
|                           |                           |
+---------------------------+---------------------------+
              Click any pane to select
```

---

## Why?

**Claude Code** is single-threaded. Waiting for one task to finish before starting the next is a bottleneck. **Claude Code Splitter** fixes this by spawning parallel agents in one terminal.

- **Parallel Workflows:** Refactor, test, and document simultaneously.
- **Infinity Mode:** Spawn 4, 16, or 100+ agents with one command.
- **Max Velocity:** Same API key, 4x+ throughput.

---

## Quick Start

### Step 1: Install Claude Code
Install the official Anthropic CLI if you haven't already.
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Step 2: Enable Infinity Mode
Paste the one-liner for your shell. This injects the `claude4` command logic into your profile and ensures `tmux` is installed.

**Bash:**
```bash
echo 'claude_split() { if ! command -v tmux &>/dev/null; then echo "Installing tmux..."; if [[ "$OSTYPE" == "linux-gnu"* ]]; then sudo apt-get update -y || true; sudo apt-get install -y tmux; elif [[ "$OSTYPE" == "darwin"* ]]; then brew install tmux; fi; fi; if ! command -v tmux &>/dev/null; then echo "tmux installation failed. Please install it manually."; return 1; fi; local s="claude-swarm"; tmux kill-session -t $s 2>/dev/null; tmux new-session -d -s $s; tmux set -g mouse on; tmux set -g pane-border-status top; tmux set -g pane-border-format " #[fg=white,bg=blue,bold] #T #[default] "; local f=1; for a in "$@"; do if [[ $a =~ ^(claude)([0-9]*)$ ]]; then local m="claude"; local c=$(echo $a | sed -E "s/(claude)([0-9]*)/\2/"); c=${c:-1}; if [ "$c" -gt 20 ]; then echo -n "Large swarm ($c). Continue? (y/n) "; read -n 1 -r REPLY; echo; if [[ ! $REPLY =~ ^[Yy]$ ]]; then return; fi; fi; for ((i=1; i<=c; i++)); do if [ $f -eq 1 ]; then tmux send-keys -t $s "$m" C-m; tmux select-pane -t $s -T "$m"; f=0; else tmux split-window -t $s; tmux send-keys -t $s "$m" C-m; tmux select-pane -T "$m"; tmux select-layout -t $s tiled; fi; done; fi; done; tmux attach -t $s; }; command_not_found_handle() { if [[ $1 =~ ^(claude)([0-9]+)$ ]]; then claude_split "$@"; else echo "bash: $1: command not found"; return 127; fi; }; for i in {1..20}; do alias claude$i="claude_split claude$i"; done; echo -e "\nClaude Code Splitter Installed!\nType \033[1;34mclaude4\033[0m, \033[1;34mclaude8\033[0m, or \033[1;34mclaudeX\033[0m (any number) to begin your swarm.\n"' >> ~/.bashrc && source ~/.bashrc
```

**Zsh:**
```bash
echo 'claude_split() { if ! command -v tmux &>/dev/null; then echo "Installing tmux..."; if [[ "$OSTYPE" == "linux-gnu"* ]]; then sudo apt-get update -y || true; sudo apt-get install -y tmux; elif [[ "$OSTYPE" == "darwin"* ]]; then brew install tmux; fi; fi; if ! command -v tmux &>/dev/null; then echo "tmux installation failed. Please install it manually."; return 1; fi; local s="claude-swarm"; tmux kill-session -t $s 2>/dev/null; tmux new-session -d -s $s; tmux set -g mouse on; tmux set -g pane-border-status top; tmux set -g pane-border-format " #[fg=white,bg=blue,bold] #T #[default] "; local f=1; for a in "$@"; do if [[ $a =~ ^(claude)([0-9]*)$ ]]; then local m="claude"; local c=$(echo $a | sed -E "s/(claude)([0-9]*)/\2/"); c=${c:-1}; if [ "$c" -gt 20 ]; then echo -n "Large swarm ($c). Continue? (y/n) "; read -n 1 -r REPLY; echo; if [[ ! $REPLY =~ ^[Yy]$ ]]; then return; fi; fi; for ((i=1; i<=c; i++)); do if [ $f -eq 1 ]; then tmux send-keys -t $s "$m" C-m; tmux select-pane -t $s -T "$m"; f=0; else tmux split-window -t $s; tmux send-keys -t $s "$m" C-m; tmux select-pane -T "$m"; tmux select-layout -t $s tiled; fi; done; fi; done; tmux attach -t $s; }; command_not_found_handler() { if [[ $1 =~ ^(claude)([0-9]+)$ ]]; then claude_split "$@"; else echo "zsh: command not found: $1"; return 127; fi; }; for i in {1..20}; do alias claude$i="claude_split claude$i"; done; echo -e "\nClaude Code Splitter Installed!\nType \033[1;34mclaude4\033[0m, \033[1;34mclaude8\033[0m, or \033[1;34mclaudeX\033[0m (any number) to begin your swarm.\n"' >> ~/.zshrc && source ~/.zshrc
```

### Step 3: Launch Your Swarm
Navigate to **any codebase** and run the command.
```bash
cd /your/project
claude4
```


---

## Infinity mode

Once installed, you can spawn any number of agents instantly.

```bash
$ claude4    # Spawns 4 agents
$ claude16   # Spawns 16 agents
$ claude100  # Spawns 100 agents (if your CPU can handle it!)
```

### Navigation Cheat-Sheet
- **Select Agent:** Click any pane or use `Ctrl+B, Arrows`
- **Zoom/Maximize:** `Ctrl+B, Z` (same to un-zoom)
- **Resize:** Drag pane borders with your mouse
- **Close Agent:** Type `exit` or `Ctrl+D`
- **Detach Swarm:** `Ctrl+B, D` (keeps agents running in background)


---

## How It Works

The script uses `tmux` to create a tiled grid of terminal panes. Each pane runs an independent `claude` process. They share your authentication but operate independently.

| Component | Purpose |
|-----------|---------|
| tmux | Terminal multiplexer. Creates the grid. |
| Claude Code | Anthropic's coding assistant CLI. |
| Anthropic API | The AI backend. Runs in the cloud. |

---

## Controls

| Action | Keys |
|--------|------|
| Select pane | Click with mouse |
| Navigate | `Ctrl+B` then arrow keys |
| Fullscreen | `Ctrl+B` then `Z` |
| Detach | `Ctrl+B` then `D` |
| Reattach | `tmux attach -t claude-swarm` |
| Kill all | `tmux kill-session -t claude-swarm` |

---

## Use Cases

- **Frontend/Backend:** Parallel debugging of both sides of the stack.
- **TDD:** One agent writing tests, another implementing features.
- **Documentation:** Generate docs side-by-side with code changes.
- **Research:** One agent researching docs while others code.

---

## FAQ

**Do I need to be online?**

Yes. Claude Code calls the Anthropic API. The intelligence lives in the cloud.

**Can all agents work at once?**

Yes. They're independent processes. Multiple conversations running simultaneously.

**Do I need multiple API keys?**

No. One login, infinite agents (bounded by your hardware).

**Can I use more than four?**

Yes! That's the power of Infinity Mode. Type `claude8`, `claude16`, etc. Just keep in mind your screen real estate and CPU.

**Platform support?**

Works on Mac, Linux, and Windows (via WSL). You need `tmux` installed.

---

## Troubleshooting

**"tmux: command not found"**

The installer should handle this, but you can install it manually:
```bash
# Mac (Homebrew)
brew install tmux

# Ubuntu/Debian
sudo apt-get install tmux
```

**"duplicate session: claude-swarm"**

The session already exists:
```bash
tmux attach -t claude-swarm
# or
tmux kill-session -t claude-swarm
```

**"claude: command not found"**

Run Step 1 again to install the official CLI:
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

---

## License

MIT

---

## Contributing

Issues and pull requests welcome.


