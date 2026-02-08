# Claude Code Splitter

If you find this useful, please [star the repo](https://github.com/theaustinhatfield/claude-code-splitter) on GitHub.

```
+---------------------------+---------------------------+
|                           |                           |
|         Claude2           |         Aider2            |
|                           |                           |
|   "Building features"     |   "Fixing bugs"           |
|                           |                           |
+---------------------------+---------------------------+
|                           |                           |
|         OpenCode2         |         Qwen2             |
|                           |                           |
|   "Writing tests"         |   "Updating docs"         |
|                           |                           |
+---------------------------+---------------------------+
              Click any pane to select
```

---

## Why?

Most AI coding agents are single-threaded. Waiting for one task to finish before starting the next is a bottleneck. **Claude Code Splitter** fixes this by spawning parallel agents in one terminal, and it's compatible with every major AI CLI.

- **Multi-CLI Support:** Compatible with Claude Code, Aider, OpenCode, GitHub CLI (`gh`), Qwen Code, Gemini CLI, and OpenAI Codex.
- **Mixed Swarms:** Run `claude2 gh2` to spawn both simultaneously in a single tiled layout.
- **Infinity Mode:** Spawn 4, 16, or 100+ agents with one command.
- **Max Velocity:** Parallelize your workflow across your favorite AI models.

---

## Quick Start

### One Command Install
Copy, paste, done. This installs the **Claude Code Splitter** and launches your first swarm.

```bash
curl -sSL https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/install.sh | bash
```

That's it. The installer:
1. Installs `tmux` (if needed)
2. Installs the official Claude CLI (if needed)
3. Configures your shell
4. Launches a 4-agent Claude swarm immediately

### Supported Agents
Other agents are supported but require manual installation. Once installed, the commands below will work automatically.

| Agent | Command | Description |
|-------|---------|-------------|
| Claude | `claude4` | Anthropic's Claude Code CLI |
| Aider | `aider4` | AI pair programming with any model |
| Gemini | `gemini4` | Google's Gemini CLI |
| GitHub | `gh4` | GitHub CLI (Copilot, issues, PRs) |
| Qwen | `qwen4` | Alibaba's Qwen CLI |
| Codex | `codex4` | OpenAI Codex CLI |
| OpenCode | `opencode4` | Open source coding assistant |

### Mix and Match
```bash
claude4          # 4 Claude agents
claude2 aider2   # 2 Claude + 2 Aider agents
aider2 gh2       # 2 Aider + 2 GitHub CLI
gemini8          # 8 Gemini agents
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
| Set todo title | `todo "fix tests"` |

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

1. Run Step 1 again to install the official CLI.
2. The Claude Code Splitter installer automatically tries to manage your PATH, but if agents still aren't found, try running `export PATH="$PATH:$HOME/.local/bin"` or restarting your terminal.
3. If you are using a mixed swarm (e.g., `qwen2`), ensure the `qwen` CLI is installed and available.

**Security & Protection**

Claude Code Splitter uses an internal whitelist to ensure only authorized AI CLI tools are executed. It also includes recursion protection to prevent accidental nested swarms from exhausting system resources.

**Logging & Debugging**

All activities are logged to `~/.claude-code-splitter.log`. If you encounter an issue, please include the contents of this log file when opening a [GitHub Issue](https://github.com/theaustinhatfield/claude-code-splitter/issues).

---

## License

MIT

---

## About

Created and maintained by [@theaustinhatfield](https://github.com/theaustinhatfield).

This is a personal project. Bug reports welcome via [Issues](https://github.com/theaustinhatfield/claude-code-splitter/issues).


