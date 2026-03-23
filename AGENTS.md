# AGENTS.md - Dotfiles Repository Guidelines

## Repository Overview

Personal dotfiles for Arch Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/). The `stow_files/` directory contains all configuration files that get symlinked into `~`.

## Build/Test/Lint Commands

### Stow Commands (Primary Workflow)
```bash
# Apply all dotfiles (symlink into ~)
stow -t ~ stow_files

# Remove symlinks
stow -D -t ~ stow_files

# Adopt existing files (first-time setup on a machine)
stow -t ~ stow_files --adopt

# Restow after changes (recreates symlinks)
stow -R -t ~ stow_files
```

### Testing Changes
There's no automated test framework. Test manually:
1. Apply changes: `stow -R -t ~ stow_files`
2. Reload shell: `source ~/.bash_profile` or open a new terminal
3. Verify the config is loaded correctly
4. Check for errors in the shell startup

For scripts, run them directly and verify output:
```bash
bash -x scripts/keyboard_remap.sh  # Debug mode
```

### Linting (Recommended Tools)
```bash
# Install shellcheck for shell script linting
sudo pacman -S shellcheck

# Install shfmt for shell formatting
sudo pacman -S shfmt

# Run shellcheck on a script
shellcheck scripts/keyboard_remap.sh

# Format with shfmt
shfmt -i 2 -w scripts/*.sh
```

### Setup Script
`my-arch-setup` is an interactive installer. Use flags to run specific steps:
```bash
./my-arch-setup --help              # Show all flags
./my-arch-setup --setup-nvim        # Install Neovim
./my-arch-setup --setup-i3          # Setup i3 window manager
./my-arch-setup --install-pacman-packages  # Install base packages
```

## Adding New Dotfiles

1. Create the file in `stow_files/` mirroring its home directory structure
2. Use `stow -R -t ~ stow_files` to apply the new symlink
3. Commit the file to the repo

**Example:** To add `~/.config/tool/config.toml`:
```bash
mkdir -p stow_files/.config/tool
vim stow_files/.config/tool/config.toml
stow -R -t ~ stow_files
git add stow_files/.config/tool/config.toml
git commit -m "Add tool config"
```

## Shell Script Conventions

### Shebang & Error Handling
```bash
#!/usr/bin/env bash
set -euo pipefail
```

### Colors and Output
```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err() { echo -e "${RED}[ERROR]${NC} $*" >&2; }
```

### Command Existence Check
```bash
cmd_exists() { command -v "$1" &>/dev/null; }
```

### Quoting & Arrays
- Always quote variables: `"$variable"`
- Quote command substitutions: `"$(command)"`
- Use arrays: `local packages=(pkg1 pkg2 pkg3); sudo pacman -S "${packages[@]}"`

## Code Style

### Bash
- Indent with 2 spaces
- Use `local` for function variables
- Prefer `$(command)` over backticks
- Use meaningful UPPER_CASE variable names for globals/env vars
- Chain dependent commands with `&&`
- Add comments for non-obvious logic

### Lua (Neovim Config)
- Indent with 2 or 4 spaces (match existing file)
- Use descriptive variable names
- Group related mappings/plugins together
- Add desc for keymaps: `{ desc = "[D]escription" }`

### Git Commit Messages
- Use imperative mood: "Add feature", "Fix bug"
- Keep under 72 characters
- Prefix with context when useful: `[nvim]`, `[tmux]`, `[shell]`

**Examples:**
```
Add supermaven, markdown preview
[nvim] Helper cmd to copy current path to clipboard
Update git completions
Remove work-specific references and hardcoded paths
```

## Repository Structure

```
dotfiles/
├── AGENTS.md                    # This file
├── README.md                    # Project documentation
├── my-arch-setup               # Arch Linux setup script (interactive)
├── my-ubuntu-setup             # Ubuntu setup script
├── scripts/                    # Utility scripts
│   ├── keyboard_remap.sh       # Keyboard remapping daemon
│   ├── pactl_volume.sh         # Volume control helper
│   └── rofi-*/                 # Rofi launcher scripts
└── stow_files/                 # All dotfiles (stow source)
    ├── .aliases                # Shell aliases
    ├── .bash_profile           # Bash profile (loads other files)
    ├── .bashrc                 # Bash RC
    ├── .exports                # Environment variables
    ├── .functions              # Shell functions
    ├── .path                   # PATH additions
    ├── .bash_prompt            # PS1 prompt
    ├── .gitconfig              # Git configuration
    ├── .git-completion.bash    # Git completions
    ├── .claude/                # Claude Code config (symlinked to opencode)
    ├── .config/
    │   ├── nvim/               # Neovim (Lua config)
    │   ├── tmux/               # tmux configuration
    │   ├── opencode/           # OpenCode config (canonical)
    │   ├── i3/                 # i3 window manager
    │   ├── alacritty/          # Terminal emulator
    │   └── ...
    └── bin/                    # Scripts in PATH
```

## AI Tool Config

Claude Code and OpenCode share the same instruction file and commands via stow symlinks:
- `~/.claude/CLAUDE.md` → `stow_files/.claude/CLAUDE.md` (symlink) → `stow_files/.config/opencode/AGENTS.md`
- `~/.claude/commands` → `stow_files/.claude/commands` (symlink) → `stow_files/.config/opencode/commands/`

Edit the canonical files in `stow_files/.config/opencode/` and both tools see the changes.

## Git Configuration

Local git config overrides go in `~/.gitconfig.local` (gitignored). Never commit secrets or machine-specific settings to the main `.gitconfig`.

## Notes

- Keep `~/.extra` for API keys (GPG-encrypt, never commit)
- Use `git submodule init && git submodule update` after cloning
- The `my-arch-setup` script requires an Arch-based system with `yay` available
