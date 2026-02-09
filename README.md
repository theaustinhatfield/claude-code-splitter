# Claude Code Splitter

One command to launch parallel AI coding agents in a tiled terminal.

```bash
curl -sSL https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/install.sh | bash
```

Then type `claude4`, `opencode4`, `aider2 gh2`, or any combo to start.

---

```
  ╦ ╔╗╔ ╔═╗ ╔╦╗ ╔═╗ ╦  ╦    ╦ ╦ ╔═╗ ╦ ╦ ╦═╗    ╔═╗ ╔═╗ ╔═╗ ╔╗╔ ╔╦╗ ╔═╗
  ║ ║║║ ╚═╗  ║  ╠═╣ ║  ║    ╚╦╝ ║ ║ ║ ║ ╠╦╝    ╠═╣ ║ ╦ ║╣  ║║║  ║  ╚═╗
  ╩ ╝╚╝ ╚═╝  ╩  ╩ ╩ ╩═╝╩═╝   ╩  ╚═╝ ╚═╝ ╩╚═    ╩ ╩ ╚═╝ ╚═╝ ╝╚╝  ╩  ╚═╝
```

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                                                                 │
  │  CLAUDE CODE                                                    │
  │  curl -fsSL https://claude.ai/install.sh | bash                │
  │  Alt: brew install --cask claude-code                           │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  OPENCODE                                                       │
  │  curl -fsSL https://opencode.ai/install | bash                 │
  │  Alt: npm install -g opencode-ai                                │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  AIDER                                                          │
  │  pip install aider-chat                                         │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  GEMINI CLI                                                     │
  │  npm install -g @google/gemini-cli                              │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  QWEN CODE                                                      │
  │  npm install -g @qwen-code/qwen-code@latest                    │
  │  Alt: brew install qwen-code                                    │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  OPENAI CODEX                                                   │
  │  npm install -g @openai/codex                                   │
  │  Alt: brew install codex                                        │
  │                                                                 │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                 │
  │  GITHUB CLI                                                     │
  │  brew install gh                                                │
  │  Alt: sudo apt install gh                                       │
  │                                                                 │
  └─────────────────────────────────────────────────────────────────┘
```

---

```
  ╦ ╦ ╔═╗ ╔═╗ ╔═╗ ╔═╗
  ║ ║ ╚═╗ ╠═╣ ║ ╦ ║╣
  ╚═╝ ╚═╝ ╩ ╩ ╚═╝ ╚═╝
```

```bash
claude4              # 4 Claude agents
claude2 aider2       # 2 Claude + 2 Aider
opencode8            # 8 OpenCode agents
gemini2 qwen2 gh2   # mixed swarm
claude100            # infinity mode
```

```
  ┌──────────── claude ────────────┬──────────── aider ─────────────┐
  │                                │                                │
  │  > Building the auth module    │  > Fixing the login bug        │
  │                                │                                │
  ├────────── opencode ────────────┼──────────── qwen ──────────────┤
  │                                │                                │
  │  > Writing unit tests          │  > Updating the docs           │
  │                                │                                │
  └────────────────────────────────┴────────────────────────────────┘
```

---

```
  ╔╗╔ ╔═╗ ╦  ╦ ╦ ╔═╗ ╔═╗ ╔╦╗ ╦ ╔═╗ ╔╗╔
  ║║║ ╠═╣ ╚╗╔╝ ║ ║ ╦ ╠═╣  ║  ║ ║ ║ ║║║
  ╝╚╝ ╩ ╩  ╚╝  ╩ ╚═╝ ╩ ╩  ╩  ╩ ╚═╝ ╝╚╝
```

```
  ┌───────────────────┬────────────────────────────────────────┐
  │  Select pane      │  Click with mouse                      │
  │  Navigate         │  Ctrl+B then arrow keys                │
  │  Fullscreen       │  Ctrl+B then Z                         │
  │  Resize           │  Drag pane borders                     │
  │  Detach           │  Ctrl+B then D                         │
  │  Close pane       │  exit or Ctrl+D                        │
  │  Reattach         │  tmux attach -t claude-swarm           │
  │  Kill all         │  tmux kill-session -t claude-swarm     │
  │  Set todo         │  todo "fix tests"                      │
  └───────────────────┴────────────────────────────────────────┘
```

---

```
  ╔╗  ╔═╗ ╔═╗ ╔╦╗    ╔═╗ ╦═╗ ╔═╗ ╔═╗ ╔╦╗ ╦ ╔═╗ ╔═╗ ╔═╗
  ╠╩╗ ║╣  ╚═╗  ║     ╠═╝ ╠╦╝ ╠═╣ ║    ║  ║ ║   ║╣  ╚═╗
  ╚═╝ ╚═╝ ╚═╝  ╩     ╩   ╩╚═ ╩ ╩ ╚═╝  ╩  ╩ ╚═╝ ╚═╝ ╚═╝
```

```
  ┌─ Be specific ────────── "fix the login bug" > "fix the bug"
  │
  ├─ One task per agent ─── Each pane = one focused job
  │
  ├─ Use todo titles ────── todo "auth module" to label panes
  │
  ├─ Mix models ─────────── claude2 aider2 for different strengths
  │
  ├─ Start small ────────── 4 agents first, scale up as needed
  │
  └─ Detach & reattach ─── Ctrl+B D to background, come back later
```

---

```
  ╔╦╗ ╦═╗ ╔═╗ ╦ ╦ ╔╗  ╦  ╔═╗ ╔═╗ ╦ ╦ ╔═╗ ╔═╗ ╔╦╗
   ║  ╠╦╝ ║ ║ ║ ║ ╠╩╗ ║  ║╣  ╚═╗ ╠═╣ ║ ║ ║ ║  ║
   ╩  ╩╚═ ╚═╝ ╚═╝ ╚═╝ ╩═╝╚═╝ ╚═╝ ╩ ╩ ╚═╝ ╚═╝  ╩
```

**tmux: command not found**
```bash
brew install tmux          # Mac
sudo apt-get install tmux  # Ubuntu/Debian
```

**duplicate session: claude-swarm**
```bash
tmux kill-session -t claude-swarm
```

**agent: command not found**
1. Install the agent from the table above.
2. Run `source ~/.bashrc` (or `source ~/.zshrc`).
3. Still missing? `export PATH="$PATH:$HOME/.local/bin"` or restart terminal.

**Security** — Only whitelisted CLIs can run. Recursion guard prevents nested swarms.

**Platform** — Mac, Linux, Windows (WSL). Requires `tmux`.

---

```
  ┌─────────────────────────────────────────────────────────────┐
  │                                                             │
  │   MIT License                                               │
  │                                                             │
  │   Created by @theaustinhatfield                             │
  │   github.com/theaustinhatfield/claude-code-splitter         │
  │                                                             │
  └─────────────────────────────────────────────────────────────┘
```


