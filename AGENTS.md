# AGENTS.md - dotfiles repository guidance

## Overview

This repo manages personal Arch Linux dotfiles using GNU Stow.
Most edits happen under `stow_files/`, then symlink into `~`.

- Stow source of truth: `stow_files/`
- Global OpenCode config: `stow_files/.config/opencode/`
- Global Claude config: `stow_files/.claude/` (symlinked to opencode files)

## Rules discovered in repo

- No `.cursorrules` found.
- No `.cursor/rules/` directory found.
- No `.github/copilot-instructions.md` found.

If any are added later, treat them as higher-priority constraints than this file.

## Build, lint, and test commands

## Core workflow (stow)

```bash
# Apply dotfiles into $HOME
stow -t ~ stow_files

# Recreate links after edits
stow -R -t ~ stow_files

# Remove links
stow -D -t ~ stow_files

# First-time setup on a machine with preexisting files
stow -t ~ stow_files --adopt
```

## Linting

```bash
# Shell lint (single file)
shellcheck scripts/keyboard_remap.sh

# Shell lint (all local scripts)
shellcheck scripts/*.sh

# Format shell scripts in place
shfmt -i 2 -w scripts/*.sh

# Fast syntax check for one script
bash -n stow_files/.config/tmux/tmux-sessionizer.sh
```

## Tests

There is no single global test runner for this repository.
Use file-specific/manual verification depending on what changed.

```bash
# Main tmux sessionizer test suite
bash stow_files/.config/tmux/test_tmux-sessionizer.sh

# "Single test" equivalent in this repo: run one script check directly
bash -n stow_files/.config/tmux/tmux-sessionizer.sh
shellcheck stow_files/.config/tmux/tmux-sessionizer.sh

# Debug-run one script
bash -x scripts/keyboard_remap.sh
```

Notes:
- `scripts/rofi*` directories are git submodules/upstream projects.
- Do not rewrite upstream test systems unless explicitly requested.

## Manual verification checklist

After changing dotfiles, run:

1. `stow -R -t ~ stow_files`
2. Reload shell (`source ~/.bash_profile`) or open a new terminal.
3. Verify the changed behavior in the target tool (bash, tmux, nvim, i3, etc.).
4. Check startup output for warnings/errors.

## Style guide

## General

- Keep changes minimal and scoped to the task.
- Prefer editing existing files over creating new ones.
- Keep machine-local secrets/settings out of tracked files.
- Do not commit credentials, tokens, or host-specific private paths.

## Bash style

- Shebang: `#!/usr/bin/env bash`
- Strict mode for scripts: `set -euo pipefail`
- Indentation: 2 spaces
- Function names: `snake_case`
- Global/env names: `UPPER_CASE`
- Local variables inside functions: `local var_name`
- Prefer `$(...)` over backticks
- Always quote variables: `"$var"`
- Use arrays for package lists and argument-safe iteration
- Add comments only for non-obvious behavior

Example patterns used in this repo:

```bash
cmd_exists() { command -v "$1" &>/dev/null; }
local packages=(git base-devel)
sudo pacman -S --needed "${packages[@]}"
```

## Lua (Neovim) style

- Match existing indentation in the file (2 or 4 spaces).
- Require/import modules at top-level locals when practical.
- Use descriptive names (`opts`, `map`, `plugin`, `tb`).
- Keep plugin config blocks grouped by feature.
- For keymaps, include `desc` when adding new mappings.

## Imports and dependencies

- Bash: use `source` only for known dotfiles or controlled script fragments.
- Lua: avoid adding new plugin dependencies unless requested.
- Prefer existing utilities/functions over introducing new abstractions.

## Types and data handling

- Bash has no static types: guard assumptions explicitly.
- Treat external command output as untrusted input; quote and sanitize.
- Avoid mixed/implicit formats when editing structured files (JSON/Lua).
- Keep JSON valid (double quotes, no trailing commas).

## Error handling

- Fail fast in scripts that automate setup (`set -euo pipefail`).
- Return non-zero on failures and print actionable error messages.
- Use small helper functions (`info`, `warn`, `err`) for consistent output.

## Naming conventions

- Scripts/files: lowercase with hyphen or underscore, consistent with directory.
- Bash functions: `verb_object` style when possible (`setup_php`, `cmd_exists`).
- Git commits: imperative mood, concise, optionally scoped (`[nvim]`, `[tmux]`).

## Git and change hygiene

- Check `git status` and `git diff` before committing.
- Keep unrelated changes in separate commits.
- Do not force-push or use `--no-verify` unless explicitly requested.
- Do not amend prior commits unless explicitly requested.

## Submodules and boundaries

Submodules configured in `.gitmodules` include rofi/rofi-emoji/rofi-pass/etc.

- Treat submodule code as upstream unless the task explicitly targets it.
- Prefer changes in `stow_files/` and first-party scripts.

## Key paths

- Repository guide (this file): `AGENTS.md`
- README: `README.md`
- Setup script: `my-arch-setup`
- Canonical OpenCode agent config: `stow_files/.config/opencode/AGENTS.md`
