# Claude Code Splitter

<p align="center">
  <a href="https://github.com/theaustinhatfield/claude-code-splitter">
    <img src="https://img.shields.io/github/stars/theaustinhatfield/claude-code-splitter?style=for-the-badge&logo=github&label=Star%20This%20Repo" alt="Star this repo">
  </a>
</p>

## Like 4x Coding Velocity.

Claude Code is brilliant, but single-threaded. **Claude Code Splitter** transforms your terminal into a multi-agent command center.

![Demo](/Users/austin/.gemini/antigravity/brain/14c4bcf5-4533-4bd6-9e4d-08299ae6b116/verify_layout_refinement_1765049853099.webp)

## Get Started

Run this command to launch your grid:

```bash
bash <(curl -s https://raw.githubusercontent.com/theaustinhatfield/claude-code-splitter/main/launch.sh)
```

> **Note:** Requires `npm i -g @anthropic-ai/claude-code`

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


