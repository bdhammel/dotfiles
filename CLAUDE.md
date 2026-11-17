# CLAUDE.md

This repo is Ben's public dotfiles: shell, Neovim, tmux, git, terminal and Claude Code
config. The repo is public, so never commit work names, paths, hosts, identities or secrets here.
Work config belongs in the private `claude_skills` repo, and identity and secrets stay in
`~/.gitconfig` and `~/.zshrc.local`.

## Commands

Each command runs from the repo root and needs no venv.

```bash
./install.sh --check    # list missing or drifted links and hooks; exits 1 on any
./install.sh            # link and hook; a second run prints nothing
./bootstrap.sh --check  # install.sh --check, brew bundle check, and the sibling repos
```

Test a change to `install.sh` against a throwaway home, never the real one, because a run
from a worktree repoints every live link at that worktree:
`HOME=$(mktemp -d) ./install.sh`.

## Layout

| Path | Linked to | Role |
|---|---|---|
| `bootstrap.sh` | | New-machine entry point: Homebrew, `Brewfile`, `install.sh`, tmux plugins, beadwork, claude_skills, `:Lazy restore` |
| `install.sh` | | Links the files below, hooks `~/.zshrc`, `~/.bashrc` and `~/.gitconfig`, clones tpm |
| `quick_setup.sh` | | Minimal setup for a machine you do not own, fetched with curl |
| `Brewfile` | | General tools. The work tools are in claude_skills |
| `.aliases` | `~/.aliases` | Shared by bash and zsh: `DOTFILES`, `PATH` (Homebrew, `~/.local/bin`, nvm), aliases, `gwt` |
| `.zsh_aliases`, `.bash_aliases` | `~/` | Shell-specific setup. Each sources `~/.aliases`, and `.zsh_aliases` sources `~/.zshrc.local` last |
| `git/config` | included by `~/.gitconfig` | Shared git settings and aliases |
| `.gitignore_global`, `gitattributes_global` | `~/` | Read through `core.excludesfile` and `core.attributesfile` in `git/config` |
| `nvim/` | `~/.config/nvim` | Neovim with lazy.nvim. `lazy-lock.json` pins plugin versions, and `spell/` holds added words |
| `.tmux.conf` | `~/` | tmux, the daily driver, which renders the Claude Code progress bar from `@claude_progress` |
| `cmux/settings.json`, `ghostty/config` | `~/.config/` | cmux (kept working, not primary) and the Ghostty config it embeds |
| `claude/rules/writing.md` | `~/.claude/rules/` | Writing rules loaded in every session |
| `claude/keybindings.json`, `claude/statusline.sh` | `~/.claude/` | Claude Code key bindings and status line |

## Conventions

- `vim` is aliased to `nvim`. `basic_vimrc` is the only Vim config, for remote machines.
- `cd` is aliased to `pushd`, and `up` pops.
- Python needs a virtualenv (`PIP_REQUIRE_VIRTUALENV=true`).
- `gwt <name>` creates the worktree and branch `benh/<name>` next to the repo root and
  opens it through the `mux` shim, which claude_skills installs.
- A link that `install.sh` no longer creates goes in its `retired` list, so that old
  machines lose the link on their next run.
