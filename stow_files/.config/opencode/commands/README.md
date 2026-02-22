# OpenCode Custom Commands

This directory contains custom slash commands for OpenCode.

## Available Commands

### `/reflect` - Continuous Improvement Loop

A meta-command that implements a "reflect and improve" practice for AI-assisted coding.

**When to use:**
- After completing a major task or feature
- At the end of a coding session
- When you want to improve your AI workflow

**What it does:**
1. Reviews recent chat and commit history
2. Asks what went well and what was frustrating
3. Reflects on instruction clarity and workflow gaps
4. Proposes actionable improvements (new commands, skills, or documentation)
5. Implements agreed-upon improvements immediately

**Example usage:**
```
/reflect
```

This creates a continuous improvement loop where your AI-assisted coding workflow gets better every week.

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
