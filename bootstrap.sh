#!/usr/bin/env bash
# Set up a new machine from this repo: Homebrew and the Brewfile, the links and hooks from
# install.sh, then the installers of the two sibling repos. Safe to re-run.
#
#   ./bootstrap.sh           set up everything
#   ./bootstrap.sh --check   report what is missing and change nothing; exit 1 on any finding
#
# Sibling repos, each overridable by an environment variable:
#   BEADWORK       public, cloned when missing        (default ~/dev/beadwork)
#   CLAUDE_SKILLS  a directory of a private repo, used only once cloned
#                  (default ~/dev/primer/benhammel/claude_skills)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BEADWORK="${BEADWORK:-$HOME/dev/beadwork}"
CLAUDE_SKILLS="${CLAUDE_SKILLS:-$HOME/dev/primer/benhammel/claude_skills}"
CHECK=0
case "${1-}" in
    --check) CHECK=1 ;;
    "") ;;
    *) echo "usage: $0 [--check]" >&2; exit 2 ;;
esac

# Put an installed Homebrew on PATH for the rest of this script.
load_brew() {
    local brew_bin
    for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
        if [[ -x "$brew_bin" ]]; then
            eval "$("$brew_bin" shellenv)"
            return 0
        fi
    done
    return 1
}

if (( CHECK )); then
    status=0
    "$DOTFILES/install.sh" --check || status=1
    if load_brew; then
        brew bundle check --no-upgrade --file "$DOTFILES/Brewfile" || status=1
    else
        echo "Missing: Homebrew"
        status=1
    fi
    if [[ ! -L "$HOME/.claude/rules/beads.md" ]]; then
        echo "Missing: ~/.claude/rules/beads.md (run beadwork's install.sh)"
        status=1
    fi
    if [[ -x "$CLAUDE_SKILLS/install.sh" ]]; then
        "$CLAUDE_SKILLS/install.sh" --check || status=1
    else
        echo "Missing: claude_skills at $CLAUDE_SKILLS"
        status=1
    fi
    exit "$status"
fi

# 1. Homebrew, on macOS. On Linux, install the Brewfile's tools with the distro's package
#    manager or as binaries in ~/.local/bin, as the README describes.
if ! load_brew; then
    if [[ "$(uname)" == "Darwin" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        load_brew
    else
        echo "Skip: Homebrew (not macOS); install the tools in Brewfile by hand"
    fi
fi

# 2. Packages. --no-upgrade leaves every installed tool at its version, so that a re-run
#    never upgrades Neovim or anything else as a side effect.
if command -v brew >/dev/null 2>&1; then
    brew bundle install --no-upgrade --file "$DOTFILES/Brewfile" ||
        echo "Warn: some Brewfile entries failed; run brew bundle check --file $DOTFILES/Brewfile"
fi
# Node comes from fnm. The latest LTS release becomes the default, and a repo's .nvmrc picks
# its own version on cd.
if command -v fnm >/dev/null 2>&1 && [[ ! -e "${FNM_DIR:-$HOME/.local/share/fnm}/aliases/default" ]]; then
    fnm install --lts && fnm default lts-latest || echo "Warn: fnm could not install Node"
fi

# 3. Links and hooks from this repo, then the tmux plugins that .tmux.conf lists.
"$DOTFILES/install.sh"
if [[ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]] && command -v tmux >/dev/null 2>&1; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null ||
        echo "Warn: tmux plugins did not install; press prefix + I inside tmux"
fi

# 4. beadwork is public, so clone it over HTTPS when it is missing.
if [[ ! -d "$BEADWORK" ]]; then
    git clone -q https://github.com/bdhammel/beadwork.git "$BEADWORK" ||
        echo "Skip: beadwork (git clone failed)"
fi
if [[ -x "$BEADWORK/install.sh" ]]; then
    "$BEADWORK/install.sh"
fi

# 5. claude_skills is private, so it runs only once it is cloned.
if [[ -x "$CLAUDE_SKILLS/install.sh" ]]; then
    "$CLAUDE_SKILLS/install.sh" --packages
else
    echo "Skip: claude_skills (clone the private repo that holds it, so that it sits at $CLAUDE_SKILLS, then re-run)"
fi

# 6. Neovim plugins at the versions pinned in nvim/lazy-lock.json.
if command -v nvim >/dev/null 2>&1; then
    nvim --headless "+Lazy! restore" +qa || echo "Warn: :Lazy restore failed; run it inside nvim"
fi

# 7. The git identity stays out of this repo.
if [[ -z "$(git config --global user.email || true)" ]]; then
    echo "Next: git config --global user.name <name> && git config --global user.email <email>"
fi
