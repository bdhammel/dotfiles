# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing shell configurations (bash/zsh), vim/neovim, git, tmux, and related development tools.

## Setup Commands

```bash
# Full installation - creates symlinks for all dotfiles
./install.sh

# One-time git configuration (run after install.sh)
./git-setup.sh

# Minimal setup for remote/shared machines (downloads basic vimrc and tmux.conf)
./quick_setup.sh

# Install brew packages on macOS
xargs brew install < ~/dotfiles/brew_requirements.txt
```

## File Structure

- **install.sh** - Creates symlinks from `~/dotfiles/*` to `~/*` (backs up existing files)
- **git-setup.sh** - Configures global git settings (editor, aliases, diff tools)
- **quick_setup.sh** - Lightweight setup for remote machines without cloning the full repo

### Configuration Files

- `.aliases` - Shared shell aliases and functions (sourced by both bash and zsh)
- `.bash_aliases` / `.zsh_aliases` - Shell-specific aliases
- `.vimrc` - Traditional vim config
- `nvim/` - Neovim config (lua-based, uses lazy.nvim for plugin management)
- `.tmux.conf` - tmux configuration
- `.pdbrc` / `.pdbrc.py` - Python debugger configuration

### Neovim Structure

The neovim config at `nvim/` is modular:
- `init.lua` - Entry point, loads other modules
- `lua/lazy_manager.lua` - Plugin manager setup
- `lua/settings.lua` - Editor settings
- `lua/appearance.lua` - Theme/UI settings
- `lua/plugins/*.lua` - Individual plugin configurations

## Key Conventions

- Default editor is neovim (`vim` is aliased to `nvim`)
- `cd` is aliased to `pushd` for directory stack navigation; use `up` to pop
- Python virtualenvs are required (`PIP_REQUIRE_VIRTUALENV=true`)
- Git worktree helper: `gwt <branch-name>` creates a worktree and opens in new tmux window
