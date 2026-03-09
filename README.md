Inspired by https://github.com/mathiasbynens/dotfiles

Personal dotfiles for Arch Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- **Shell**: bash config, prompt, aliases, functions, exports, path
- **Editor**: Neovim (Lua config with LSP, treesitter, fzf) and Emacs (org-mode, org-roam)
- **Terminal**: Alacritty, tmux (with sessionizer script)
- **WM**: i3 with py3status, dunst, rofi
- **Git**: gitconfig with aliases and diff tooling
- **AI**: Claude Code (`~/.claude/`) and opencode (`~/.config/opencode/`) config and AGENTS.md

## Setup

### 1. Stow dotfiles

The managed files live in `stow_files/`. To symlink them into `~`:

```bash
stow -t ~ stow_files
```

Use `--adopt` when setting up for the first time on a machine that already has some of these files — this pulls the existing files into the stow directory first. Be careful: it will overwrite files already in `stow_files/`.

```bash
stow -t ~ stow_files --adopt
```

### 2. Arch Linux setup script

`./my-arch-setup` is an interactive script that installs and configures everything from scratch. Run with no arguments for the full setup, or pass a specific flag to run just one step.

```
./my-arch-setup --help
```

Notable setup commands:

| Flag | Description |
|---|---|
| `--setup-i3` | i3 window manager + py3status + brightness controls |
| `--setup-nvim` | Neovim (pacman or nightly from AUR) |
| `--setup-emacs` | Emacs (pacman or build from source) |
| `--setup-rofi` | rofi launcher + AUR extensions |
| `--setup-sound` | PipeWire + Bluetooth |
| `--setup-gpg` | GPG key setup instructions |
| `--setup-fzf` | fzf fuzzy finder |
| `--setup-rustup` | Rust toolchain via rustup |
| `--setup-ledger` | ledger-cli (AUR or from source) |
| `--install-pacman-packages` | Base + dev packages |
| `--install-aur-packages` | AUR packages via yay |
| `--install-cargo-packages` | Rust tools (alacritty, ripgrep, fd, dust) |
| `--install-flatpak-packages` | Flatpak apps (NewsFlash, Foliate, Flameshot) |
| `--manual-setup-packages` | Instructions for Docker, JDK, Dropbox, Conda, etc. |

No arguments runs the full interactive setup from top to bottom.

## Notes

- Keep `~/.gitconfig.local` (gitignored) for machine-specific git config (signing key, etc.)
- Store API keys in `~/.extra` — GPG-encrypt it, do not commit it
- i3 config has a `$home` variable — update it if your username changes
- Init git submodules before running the setup script: `git submodule init && git submodule update`
