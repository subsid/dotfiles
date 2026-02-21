# Tmux Sessionizer

A smart tmux session manager with fuzzy finding.

Inspired by:
- [ThePrimeagen's tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer)
- [joshmedeski's sesh](https://github.com/joshmedeski/sesh)

## Features

- 🔍 Fuzzy search through existing sessions and project directories
- 🎯 Automatic session creation with 3 default windows (nvim, terminal, opencode)
- 📁 Support for base directories, individual projects, and custom paths
- 🏷️  Custom session naming with smart defaults
- 🧹 Session killing from the fuzzy finder
- 🐛 Debug mode for troubleshooting

## Usage

### Quick Start

- **From tmux**: Press `Ctrl-Space s`
- **From terminal**: Run `ts`

### Keybindings

- `Enter` - Connect to selected session/directory
- `Ctrl-x` - Kill selected session
- `Ctrl-r` - Enter custom path
- `Esc` - Exit

### Configuration

Edit `tmux-sessionizer.sh` to customize:

```bash
# Base directories to scan (one level deep)
BASE_DIRS=(
    "$HOME"
    "$HOME/workspace"
)

# Individual projects (full paths)
PROJECTS=(
    "$HOME/special-project"
    "/opt/my-app"
)
```

### Command Line Options

- `-d, --debug` - Enable debug output
- `-h, --help` - Show help message

### Examples

```bash
# Run normally
ts

# Run with debug output
~/.config/tmux/tmux-sessionizer.sh --debug

# Get help
~/.config/tmux/tmux-sessionizer.sh --help
```

## Testing

Run the test suite:

```bash
~/.config/tmux/test_tmux-sessionizer.sh
```

## How It Works

1. **Session List**: Shows existing tmux sessions (marked with `*`) and available project directories
2. **Session Creation**: New sessions automatically get 3 windows:
   - Window 1: `nvim` - Opens neovim
   - Window 2: `terminal` - Clean terminal
   - Window 3: `opencode` - Runs `opencode .`
3. **Session Naming**: 
   - Existing sessions: Connect immediately
   - New sessions: Prompt for name (default is directory basename)
   - Special characters (`.`, `:`, spaces) are sanitized to `_`

## Files

- `tmux-sessionizer.sh` - Main script
- `test_tmux-sessionizer.sh` - Test suite
- `README.md` - This file

## Tmux Configuration

The sessionizer is bound in `tmux.conf`:

```tmux
bind-key s display-popup -E -w 80% -h 80% "~/.config/tmux/tmux-sessionizer.sh"
```

Shell alias in `~/.aliases`:

```bash
alias ts="~/.config/tmux/tmux-sessionizer.sh"
```
