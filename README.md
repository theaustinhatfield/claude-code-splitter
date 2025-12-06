# 🔀 Claude Code Splitter

<p align="center">
  <strong>Run 4 Claude Code AI agents in parallel. Multiply your productivity.</strong>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> •
  <a href="#how-it-works">How It Works</a> •
  <a href="#controls">Controls</a> •
  <a href="#faq">FAQ</a> •
  <a href="#troubleshooting">Troubleshooting</a>
</p>

---

```
┌─────────────────────────────────────────────────────────────────┐
│                     CLAUDE CODE SPLITTER                        │
├────────────────────────────┬────────────────────────────────────┤
│                            │                                    │
│         Agent-1            │            Agent-2                 │
│                            │                                    │
│    "Fix the login bug"     │    "Add unit tests"                │
│                            │                                    │
├────────────────────────────┼────────────────────────────────────┤
│                            │                                    │
│         Agent-3            │            Agent-4                 │
│                            │                                    │
│    "Refactor database"     │    "Update docs"                   │
│                            │                                    │
└────────────────────────────┴────────────────────────────────────┘
                    🖱️ Click any pane to select
```

---

## ✨ Features

- **4 parallel agents** - Work on 4 different tasks simultaneously
- **Mouse support** - Click to select any agent
- **Labeled panes** - Each agent shows its name in the border
- **Persistent sessions** - Detach and reattach anytime
- **Zero config** - Just copy, paste, and code

---

## 🚀 Quick Start

### Step 1: Install Claude Code (one-time)

```bash
npm i -g @anthropic-ai/claude-code && claude
```

Complete the login process, then exit with `Ctrl+C`.

### Step 2: Launch 4 Agents

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

**That's it!** You now have 4 Claude Code agents ready to work.

---

## 🔧 How It Works

```
┌──────────────────────────────────────────────────────────────────┐
│                         Your Terminal                            │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                        tmux                                 │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────┐ │ │
│  │  │  Claude     │  │  Claude     │  │  Claude     │  │ ... │ │ │
│  │  │  Code CLI   │  │  Code CLI   │  │  Code CLI   │  │     │ │ │
│  │  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──┬──┘ │ │
│  └─────────┼────────────────┼────────────────┼────────────┼────┘ │
└────────────┼────────────────┼────────────────┼────────────┼──────┘
             │                │                │            │
             ▼                ▼                ▼            ▼
       ┌─────────────────────────────────────────────────────────┐
       │               Anthropic API (Cloud)                     │
       │                    Claude AI                            │
       └─────────────────────────────────────────────────────────┘
```

**Components:**

| Component | Description |
|-----------|-------------|
| **tmux** | Terminal multiplexer that creates the 2×2 grid |
| **Claude Code** | Anthropic's official AI coding assistant CLI |
| **Anthropic API** | Cloud AI that powers the responses |

---

## 🎮 Controls

| Action | Keys |
|--------|------|
| **Select pane** | 🖱️ Click |
| **Navigate** | `Ctrl+B` then `↑` `↓` `←` `→` |
| **Fullscreen toggle** | `Ctrl+B` then `z` |
| **Detach (keep running)** | `Ctrl+B` then `D` |
| **Reattach** | `tmux attach -t agents` |
| **Kill all** | `tmux kill-session -t agents` |
| **List sessions** | `tmux ls` |

---

## 💡 Use Cases

### Parallel Development
```
Agent-1: "Fix the authentication bug in login.py"
Agent-2: "Add unit tests for the user model"
Agent-3: "Refactor the database queries"
Agent-4: "Update the API documentation"
```

### Research + Implementation
```
Agent-1: "Research best practices for caching in Python"
Agent-2: *implementing the cache based on Agent-1's findings*
```

### Multi-Repository
```
Agent-1: Working in /frontend
Agent-2: Working in /backend
Agent-3: Working in /mobile
Agent-4: Working in /infrastructure
```

---

## ❓ FAQ

### Do I need to be online?
**Yes.** Claude Code uses the Anthropic API in the cloud. All responses come from Anthropic's servers.

### Can all 4 agents work simultaneously?
**Yes!** Each agent is independent. You can have 4 different conversations/tasks running at the same time.

### Do I need 4 API keys?
**No.** All 4 agents share your single Claude/Anthropic login.

### Can I have more than 4 agents?
Yes! Modify the script to add more `split-window` commands. However, screen space becomes limited.

### Does it work on Mac/Linux/Windows?
- **Mac**: ✅ Install tmux with `brew install tmux`
- **Linux**: ✅ Install tmux with `apt install tmux`
- **Windows**: ✅ Use WSL or Git Bash

### How do I switch repos per agent?
Click on a pane, then tell Claude:
```
Switch to working in /path/to/other/repo
```

Or exit (`Ctrl+C`), `cd /new/repo`, then `claude`.

---

## 🔧 Troubleshooting

### "tmux: command not found"

Install tmux:
```bash
# Mac
brew install tmux

# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y tmux

# Fedora
sudo dnf install tmux
```

### "duplicate session: agents"

Session already exists. Either attach to it or kill it:
```bash
# Attach to existing
tmux attach -t agents

# Or kill and restart
tmux kill-session -t agents
```

### "claude: command not found"

Claude Code isn't installed. Run Step 1:
```bash
npm i -g @anthropic-ai/claude-code && claude
```

### "server exited unexpectedly"

tmux server crashed. Just run the command again:
```bash
bash /tmp/s.sh
```

If `/tmp/s.sh` is gone (system reboot), paste Step 2 again.

### Agents are using wrong API key

Claude Code stores credentials in `~/.claude/`. All terminal sessions share this. To reset:
```bash
rm -rf ~/.claude
claude  # Re-login
```

### Mouse clicking doesn't work

Make sure mouse is enabled. Inside tmux:
```bash
tmux set -g mouse on
```

---

## 📋 Quick Reference

```bash
# Install (once)
npm i -g @anthropic-ai/claude-code && claude

# Launch 4 agents
bash /tmp/s.sh

# Reattach to session
tmux attach -t agents

# Kill all agents
tmux kill-server

# Check running sessions
tmux ls
```

---

## 🤝 Contributing

Contributions welcome! Feel free to:
- Open issues for bugs or feature requests
- Submit PRs for improvements
- Share your use cases

---

## 📄 License

MIT License - Use it however you like!

---

## ⭐ Star This Repo!

If this tool saves you time, please star the repo! It helps others discover it.

<p align="center">
  <a href="https://github.com/theaustinhatfield/claude-code-splitter">
    <img src="https://img.shields.io/github/stars/theaustinhatfield/claude-code-splitter?style=social" alt="GitHub stars">
  </a>
</p>

---

<p align="center">
  Made with ☕ for the Claude Code community
</p>
