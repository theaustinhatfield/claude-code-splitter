# Claude Code Splitter

```text
  ____  _                  _   _     _                               
 / ___|| |_ __ _ _ __     | |_| |__ (_)___    _ __ ___ _ __   ___  
 \___ \| __/ _` | '__|    | __| '_ \| / __|  | '__/ _ \ '_ \ / _ \ 
  ___) | || (_| | |       | |_| | | | \__ \  | | |  __/ |_) | (_) |
 |____/ \__\__,_|_|        \__|_| |_|_|___/  |_|  \___| .__/ \___/ 
                                                      |_|          
```
```
> If you're enjoying this, please star this repo!

![Demo Video](Demovideo.mov)

## Like 4x Coding Velocity.

Claude Code is brilliant, but single-threaded. **Claude Code Splitter** transforms your terminal into a multi-agent command center.



## Get Started

**Step 1: Install Claude Code**
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Step 2: Connect Account**
```bash
claude
```
*(Follow the prompts to login)*

**Step 3: Launch the Grid**
```bash
bash <(curl -s https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/launch.sh?v=3)
```

## Advanced Usage

Want more power? You can customize the number of agents by setting the `AGENT_COUNT` environment variable before running the script.

**Example: Launch 8 Agents**
```bash
export AGENT_COUNT=8
bash <(curl -s https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/launch.sh?v=3)
```

## Overview

We use `tmux` to run 4 independent Claude sessions in parallel.

| Component | Purpose |
|-----------|---------|
| **tmux** | Robust window manager. |
| **Claude Code** | The intelligence. |
| **You** | The orchestrator. |

## Why Parallelism?

Your brain is multi-threaded. Your tools should be too.

*   **Agent 1:** Refactor frontend.
*   **Agent 2:** Write backend tests.
*   **Agent 3:** Optimize SQL.
*   **Agent 4:** Update docs.

**4x the throughput.**

## Documentation

*   [**System Prompts**](prompt_guide.md)
*   [**Contributing**](CONTRIBUTING.md)

## FAQ

**Do I need 4 API keys?**
No. One key rules them all.

**Why not just open 4 tabs?**
Context switching kills flow. A grid keeps you in the zone.

## Support

If this saves you time, **star the repo**.

[![Star this repo](https://img.shields.io/github/stars/theaustinhatfield/claude-code-splitter?style=social)](https://github.com/theaustinhatfield/claude-code-splitter)

## License

[MIT](LICENSE)


