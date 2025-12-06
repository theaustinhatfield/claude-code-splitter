# Claude Code Splitter

**Run 4 Claude Code agents in parallel.**

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

## The Problem

Claude Code is powerful, but it's single-threaded. You talk to one agent at a time. When you're working on a complex project, that becomes a bottleneck. You wait for one task to finish before starting another.

## The Solution

This tool splits your terminal into four independent Claude Code sessions. Each runs in parallel. You can work on the frontend in Agent-1 while Agent-2 writes tests, Agent-3 refactors the database, and Agent-4 updates documentation.

The result: 4x throughput. Same human, same API key, four times the work getting done.

---

## Quick Start

### Step 1: Install Claude Code

```bash
npm i -g @anthropic-ai/claude-code && claude
```

Complete the login. Exit with `Ctrl+C` when done.

### Step 2: Launch Four Agents

```bash
cat > /tmp/s.sh << 'EOF'
tmux kill-server 2>/dev/null; sleep 0.5
tmux new-session -d -s agents
tmux set -g mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-format " #T "
tmux send-keys 'claude' C-m; tmux select-pane -T "Agent-1"
tmux split-window -h; tmux send-keys 'claude' C-m; tmux select-pane -T "Agent-2"
tmux split-window -v; tmux send-keys 'claude' C-m; tmux select-pane -T "Agent-3"
tmux select-pane -t 0; tmux split-window -v; tmux send-keys 'claude' C-m; tmux select-pane -T "Agent-4"
tmux attach -t agents
EOF
bash /tmp/s.sh
```

That's it. Four agents, ready to work.

---

## How It Works

The script uses tmux to create a 2x2 grid of terminal panes. Each pane runs an independent Claude Code session. They share your authentication but otherwise operate independently.

```
+----------------------------------------------------------------+
|                         Your Terminal                           |
|  +------------------------------------------------------------+ |
|  |                        tmux                                | |
|  |  +-----------+  +-----------+  +-----------+  +-----------+| |
|  |  | Claude    |  | Claude    |  | Claude    |  | Claude    || |
|  |  | Code CLI  |  | Code CLI  |  | Code CLI  |  | Code CLI  || |
|  |  +-----+-----+  +-----+-----+  +-----+-----+  +-----+-----+| |
|  +--------|--------------|--------------|--------------+------+ |
+-----------|--------------|--------------|--------------|--------+
            |              |              |              |
            v              v              v              v
      +-----------------------------------------------------+
      |               Anthropic API (Cloud)                 |
      +-----------------------------------------------------+
```

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
| Fullscreen | `Ctrl+B` then `z` |
| Detach | `Ctrl+B` then `D` |
| Reattach | `tmux attach -t agents` |
| Kill all | `tmux kill-session -t agents` |

---

## Use Cases

**Parallel development:**
```
Agent-1: "Fix the authentication bug in login.py"
Agent-2: "Add unit tests for the user model"
Agent-3: "Refactor the database queries"
Agent-4: "Update the API documentation"
```

**Research and implementation:**
```
Agent-1: "Research caching best practices"
Agent-2: [implementing based on Agent-1's findings]
```

**Multi-repository:**
```
Agent-1: Working in /frontend
Agent-2: Working in /backend
Agent-3: Working in /mobile
Agent-4: Working in /infrastructure
```

---

## FAQ

**Do I need to be online?**

Yes. Claude Code calls the Anthropic API. The intelligence lives in the cloud.

**Can all four agents work at once?**

Yes. They're independent processes. Four conversations running simultaneously.

**Do I need four API keys?**

No. One login, four agents.

**Can I use more than four?**

Yes, but screen space becomes the limiting factor. Four fits well on most displays.

**Platform support?**

Works on Mac, Linux, and Windows (via WSL). You need tmux installed.

---

## Troubleshooting

**"tmux: command not found"**

Install it:
```bash
# Mac
brew install tmux

# Ubuntu/Debian
sudo apt-get install tmux

# Fedora
sudo dnf install tmux
```

**"duplicate session: agents"**

The session already exists:
```bash
tmux attach -t agents
# or
tmux kill-session -t agents
```

**"claude: command not found"**

Run Step 1 again:
```bash
npm i -g @anthropic-ai/claude-code && claude
```

**"server exited unexpectedly"**

Just run the script again:
```bash
bash /tmp/s.sh
```

---

## Quick Reference

```bash
# Install (once)
npm i -g @anthropic-ai/claude-code && claude

# Launch
bash /tmp/s.sh

# Reattach
tmux attach -t agents

# Kill
tmux kill-server
```

---

## Support

If this saves you time, star the repo. It takes 2 seconds and helps others find it.

[![Star this repo](https://img.shields.io/github/stars/theaustinhatfield/claude-code-splitter?style=social)](https://github.com/theaustinhatfield/claude-code-splitter)

---

## License

MIT

---

## Contributing

Issues and pull requests welcome.

