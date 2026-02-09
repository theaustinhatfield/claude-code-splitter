```
   ╔═══════════════════════════════════════════════════════════════╗
   ║                                                               ║
   ║    ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗           ║
   ║   ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝           ║
   ║   ██║     ██║     ███████║██║   ██║██║  ██║█████╗             ║
   ║   ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝             ║
   ║   ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗           ║
   ║    ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝           ║
   ║                                                               ║
   ║             C O D E   S P L I T T E R                         ║
   ║         One Command. Infinite Agents.                         ║
   ║                                                               ║
   ╚═══════════════════════════════════════════════════════════════╝
```

One command to launch parallel AI agents in a tiled terminal.
Install once, then spawn swarms like `claude4` or `opencode4` from any repo.

If you find this useful, please [star the repo](https://github.com/theaustinhatfield/claude-code-splitter) on GitHub.

```
  ┌─────────────────────────────────────────────────────────────┐
  │                                                             │
  │    $ curl -sSL https://raw.githubusercontent.com/           │
  │      theaustinhatfield/claude-code-splitter/                │
  │      main/install.sh | bash                                 │
  │                                                             │
  └─────────────────────────────────────────────────────────────┘
```

```bash
curl -sSL https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/install.sh | bash
```

```
  ┌──────────── claude ────────────┬──────────── aider ─────────────┐
  │                                │                                │
  │  > Building the auth module    │  > Fixing the login bug        │
  │    ...                         │    ...                         │
  │                                │                                │
  ├────────── opencode ────────────┼──────────── qwen ──────────────┤
  │                                │                                │
  │  > Writing unit tests          │  > Updating the docs           │
  │    ...                         │    ...                         │
  │                                │                                │
  └────────────────────────────────┴────────────────────────────────┘
                      Click any pane  ·  Drag to resize
```

---

```
  ╦ ╦╦ ╦╦ ╦ ╔═╗
  ║║║╠═╣╚╦╝ ╠═╝
  ╚╩╝╩ ╩ ╩  ╩
```

Most AI coding agents are single-threaded. Waiting for one task to finish before starting the next is a bottleneck. **Claude Code Splitter** fixes this by spawning parallel agents in one terminal, and it's compatible with every major AI CLI.

```
  ┌─ Multi-CLI ──────── Compatible with Claude, Aider, OpenCode,
  │                      GitHub CLI, Qwen, Gemini, and Codex.
  │
  ├─ Mixed Swarms ───── Run claude2 gh2 to spawn both in one layout.
  │
  ├─ Infinity Mode ──── Spawn 4, 16, or 100+ agents with one command.
  │
  └─ Max Velocity ───── Parallelize across your favorite AI models.
```

---

```
  ╔═╗ ╦ ╦ ╦ ╔═╗ ╦╔═  ╔═╗ ╔╦╗ ╔═╗ ╦═╗ ╔╦╗
  ║═╬╗║ ║ ║ ║   ╠╩╗  ╚═╗  ║  ╠═╣ ╠╦╝  ║
  ╚═╝╚╚═╝ ╩ ╚═╝ ╩ ╩  ╚═╝  ╩  ╩ ╩ ╩╚═  ╩
```

Copy, paste, done:

```bash
curl -sSL https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/install.sh | bash
```

```
  ┌──────────────────────────────────────────────┐
  │  The installer:                              │
  │                                              │
  │    [1]  Installs tmux (if needed)            │
  │    [2]  Checks for compatible AI CLIs        │
  │    [3]  Configures your shell                │
  │                                              │
  │  That's it. No third-party CLIs installed.   │
  │  You bring the agents, we bring the grid.    │
  └──────────────────────────────────────────────┘
```

---

```
  ╦ ╔╗╔ ╔═╗ ╔╦╗ ╔═╗ ╦  ╦    ╦ ╦ ╔═╗ ╦ ╦ ╦═╗
  ║ ║║║ ╚═╗  ║  ╠═╣ ║  ║    ╚╦╝ ║ ║ ║ ║ ╠╦╝
  ╩ ╝╚╝ ╚═╝  ╩  ╩ ╩ ╩═╝╩═╝   ╩  ╚═╝ ╚═╝ ╩╚═
       A G E N T S
```

The splitter is agent-agnostic — install whichever CLIs you want to use.
Copy/paste the official install command for each:

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                                                                 │
  │  CLAUDE CODE                                                    │
  │  curl -fsSL https://claude.ai/install.sh | bash                │
  │                                                                 │
  │  Alt: brew install --cask claude-code                           │
  │  Docs: https://docs.anthropic.com/en/docs/claude-code          │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  OPENCODE                                                       │
  │  curl -fsSL https://opencode.ai/install | bash                 │
  │                                                                 │
  │  Alt: npm install -g opencode-ai                                │
  │       brew install anomalyco/tap/opencode                       │
  │  Docs: https://opencode.ai                                     │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  AIDER                                                          │
  │  pip install aider-chat                                         │
  │                                                                 │
  │  Docs: https://aider.chat                                      │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  GEMINI CLI                                                     │
  │  npm install -g @google/gemini-cli                              │
  │                                                                 │
  │  Docs: https://github.com/google-gemini/gemini-cli             │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  QWEN CODE                                                      │
  │  npm install -g @qwen-code/qwen-code@latest                    │
  │                                                                 │
  │  Alt: brew install qwen-code                                    │
  │  Docs: https://qwen-code.github.io                             │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  OPENAI CODEX                                                   │
  │  npm install -g @openai/codex                                   │
  │                                                                 │
  │  Alt: brew install codex                                        │
  │  Docs: https://github.com/openai/codex                         │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  GITHUB CLI                                                     │
  │  brew install gh                                                │
  │                                                                 │
  │  Alt: sudo apt install gh                                       │
  │  Docs: https://cli.github.com                                  │
  │                                                                 │
  └─────────────────────────────────────────────────────────────────┘
```

Once any agent is installed, the swarm commands work automatically.

---

```
  ╔═╗ ╦ ╦ ╔═╗ ╔═╗ ╔═╗ ╦═╗ ╔╦╗ ╔═╗ ╔╦╗
  ╚═╗ ║ ║ ╠═╝ ╠═╝ ║ ║ ╠╦╝  ║  ║╣   ║║
  ╚═╝ ╚═╝ ╩   ╩   ╚═╝ ╩╚═  ╩  ╚═╝ ═╩╝
       A G E N T S
```

```
  ┌────────────┬────────────────┬──────────────────────────────────┐
  │  Agent     │  Command       │  Description                     │
  ├────────────┼────────────────┼──────────────────────────────────┤
  │  Claude    │  claude4       │  Anthropic's Claude Code CLI     │
  │  Aider     │  aider4        │  AI pair programming, any model  │
  │  Gemini    │  gemini4       │  Google's Gemini CLI             │
  │  GitHub    │  gh4           │  GitHub CLI (Copilot, PRs)       │
  │  Qwen      │  qwen4         │  Alibaba's Qwen CLI             │
  │  Codex     │  codex4        │  OpenAI Codex CLI                │
  │  OpenCode  │  opencode4     │  Open source coding assistant    │
  └────────────┴────────────────┴──────────────────────────────────┘
```

### Mix and Match

```bash
claude4          # 4 Claude agents
claude2 aider2   # 2 Claude + 2 Aider agents
aider2 gh2       # 2 Aider + 2 GitHub CLI
gemini8          # 8 Gemini agents
opencode2 qwen2  # 2 OpenCode + 2 Qwen
```

---

```
  ╦ ╔╗╔ ╔═╗ ╦ ╔╗╔ ╦ ╔╦╗ ╦ ╦
  ║ ║║║ ╠╣  ║ ║║║ ║  ║  ╚╦╝
  ╩ ╝╚╝ ╩   ╩ ╝╚╝ ╩  ╩   ╩
       M O D E
```

Spawn any number of agents instantly:

```
  ┌──────────────────────────────────────────────┐
  │                                              │
  │  $ claude4     →  4 agents in a 2x2 grid    │
  │  $ claude16    →  16 agents, tiled           │
  │  $ claude100   →  100 agents (good luck!)    │
  │                                              │
  └──────────────────────────────────────────────┘
```

---

```
  ╔╗╔ ╔═╗ ╦  ╦ ╦ ╔═╗ ╔═╗ ╔╦╗ ╦ ╔═╗ ╔╗╔
  ║║║ ╠═╣ ╚╗╔╝ ║ ║ ╦ ╠═╣  ║  ║ ║ ║ ║║║
  ╝╚╝ ╩ ╩  ╚╝  ╩ ╚═╝ ╩ ╩  ╩  ╩ ╚═╝ ╝╚╝
```

```
  ┌───────────────────┬────────────────────────────────────────┐
  │  Action           │  Keys                                  │
  ├───────────────────┼────────────────────────────────────────┤
  │  Select pane      │  Click with mouse                      │
  │  Navigate         │  Ctrl+B then arrow keys                │
  │  Fullscreen       │  Ctrl+B then Z                         │
  │  Resize           │  Drag pane borders                     │
  │  Detach           │  Ctrl+B then D                         │
  │  Close pane       │  Type exit or Ctrl+D                   │
  │  Reattach         │  tmux attach -t claude-swarm           │
  │  Kill all         │  tmux kill-session -t claude-swarm     │
  │  Set todo title   │  todo "fix tests"                      │
  └───────────────────┴────────────────────────────────────────┘
```

---

```
  ╦ ╦ ╔═╗ ╦ ╦   ╦ ╔╦╗   ╦ ╦ ╔═╗ ╦═╗ ╦╔═ ╔═╗
  ╠═╣ ║ ║ ║║║   ║  ║    ║║║ ║ ║ ╠╦╝ ╠╩╗ ╚═╗
  ╩ ╩ ╚═╝ ╚╩╝   ╩  ╩    ╚╩╝ ╚═╝ ╩╚═ ╩ ╩ ╚═╝
```

The script uses `tmux` to create a tiled grid of terminal panes. Each pane runs an independent agent process. They share your authentication but operate independently.

```
  ┌──────────────┬──────────────────────────────────────────────┐
  │  Component   │  Purpose                                     │
  ├──────────────┼──────────────────────────────────────────────┤
  │  tmux        │  Terminal multiplexer. Creates the grid.     │
  │  Agent CLI   │  Any supported AI coding assistant.          │
  │  Cloud API   │  The AI backend. Runs in the cloud.          │
  └──────────────┴──────────────────────────────────────────────┘
```

---

```
  ╦ ╦ ╔═╗ ╔═╗   ╔═╗ ╔═╗ ╔═╗ ╔═╗ ╔═╗
  ║ ║ ╚═╗ ║╣    ║   ╠═╣ ╚═╗ ║╣  ╚═╗
  ╚═╝ ╚═╝ ╚═╝   ╚═╝ ╩ ╩ ╚═╝ ╚═╝ ╚═╝
```

```
  ┌─ Frontend / Backend ─── Parallel debugging both sides of the stack.
  │
  ├─ TDD ────────────────── One agent writes tests, another implements.
  │
  ├─ Documentation ──────── Generate docs side-by-side with code changes.
  │
  └─ Research ───────────── One agent reads docs while others code.
```

---

```
  ╔═╗ ╔═╗ ╔═╗
  ╠╣  ╠═╣ ║═╬╗
  ╩   ╩ ╩ ╚═╝╚
```

**Do I need to be online?**
Yes. AI agents call their cloud APIs.

**Can all agents work at once?**
Yes. They're independent processes running simultaneously.

**Do I need multiple API keys?**
No. One login, infinite agents (bounded by your hardware).

**Can I use more than four?**
Yes! That's Infinity Mode. Type `claude8`, `claude16`, etc.

**Platform support?**
Works on Mac, Linux, and Windows (via WSL). Requires `tmux`.

---

```
  ╔╦╗ ╦═╗ ╔═╗ ╦ ╦ ╔╗  ╦  ╔═╗ ╔═╗ ╦ ╦ ╔═╗ ╔═╗ ╔╦╗
   ║  ╠╦╝ ║ ║ ║ ║ ╠╩╗ ║  ║╣  ╚═╗ ╠═╣ ║ ║ ║ ║  ║
   ╩  ╩╚═ ╚═╝ ╚═╝ ╚═╝ ╩═╝╚═╝ ╚═╝ ╩ ╩ ╚═╝ ╚═╝  ╩
```

**"tmux: command not found"**

The installer handles this, but manually:
```bash
brew install tmux          # Mac
sudo apt-get install tmux  # Ubuntu/Debian
```

**"duplicate session: claude-swarm"**

```bash
tmux attach -t claude-swarm        # reattach
tmux kill-session -t claude-swarm  # or kill it
```

**"claude: command not found" (or any agent)**

1. Install the agent using the commands in the **Install Your Agents** section above.
2. Run `source ~/.bashrc` (or `source ~/.zshrc`) to reload your shell.
3. If agents still aren't found, try `export PATH="$PATH:$HOME/.local/bin"` or restart your terminal.

**Security & Protection**

Claude Code Splitter uses an internal whitelist to ensure only authorized AI CLI tools are executed. It also includes recursion protection to prevent accidental nested swarms from exhausting system resources.

---

```
  ╦  ╦ ╔═╗ ╔═╗ ╔╗╔ ╔═╗ ╔═╗
  ║  ║ ║   ║╣  ║║║ ╚═╗ ║╣
  ╩═╝╩ ╚═╝ ╚═╝ ╝╚╝ ╚═╝ ╚═╝
```

MIT

---

```
  ┌─────────────────────────────────────────────────────────────┐
  │                                                             │
  │   Created by @theaustinhatfield                             │
  │   https://github.com/theaustinhatfield                     │
  │                                                             │
  │   Bug reports welcome via Issues.                           │
  │   https://github.com/theaustinhatfield/                    │
  │     claude-code-splitter/issues                             │
  │                                                             │
  └─────────────────────────────────────────────────────────────┘
```


