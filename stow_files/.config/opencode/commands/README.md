# OpenCode Custom Commands

This directory contains custom slash commands for OpenCode.

The `/reflect` workflow has been moved to `~/.agents/skills/reflect/` as an [Agent Skills](https://agentskills.io) skill, shared across all compliant agents (pi, Claude Code, etc.).

## Creating New Commands

To add a new command, create a markdown file in this directory:

```markdown
---
description: Brief description shown in TUI
agent: general
---

Your command prompt here.
Use !`command` for shell output.
Use @filename for file references.
Use $ARGUMENTS or $1, $2, etc. for arguments.
```

The filename becomes the command name. For example, `mycommand.md` creates `/mycommand`.

See the [OpenCode commands documentation](https://opencode.ai/docs/commands/) for more details.
