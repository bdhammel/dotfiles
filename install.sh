#!/usr/bin/env bash
# Link this repo's config into $HOME, hook ~/.zshrc, ~/.bashrc and ~/.gitconfig to it, and
# install the tmux plugin manager. Packages are bootstrap.sh's job, so this script never
# runs brew or sudo.
#
#   ./install.sh           link and hook; a second run changes nothing and prints nothing
#   ./install.sh --check   report what is missing or drifted and change nothing; exit 1 on
#                          any finding
#
# A real file in a link's place moves to <name>.bak.<timestamp>, so no backup overwrites
# another. The repo can live anywhere, because every path below is read from this file's
# location.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECK=0
case "${1-}" in
    --check) CHECK=1 ;;
    "") ;;
    *) echo "usage: $0 [--check]" >&2; exit 2 ;;
esac
findings=0

finding() {
    echo "$1"
    findings=$((findings + 1))
}

# repo path:path under $HOME (the second part defaults to the first)
links=(
    ".aliases"
    ".bash_aliases"
    ".zsh_aliases"
    ".gitignore_global"
    "gitattributes_global:.gitattributes_global"
    ".inputrc"
    ".pdbrc"
    ".pdbrc.py"
    ".tmux.conf"
    "nvim:.config/nvim"
    "cmux/settings.json:.config/cmux/settings.json"
    "ghostty/config:.config/ghostty/config"
    "htoprc:.config/htop/htoprc"
    "ipython/profile_default/ipython_config.py:.ipython/profile_default/ipython_config.py"
    "ipython/profile_default/startup/ipython_startup.py:.ipython/profile_default/startup/ipython_startup.py"
    "claude/rules/writing.md:.claude/rules/writing.md"
    "claude/keybindings.json:.claude/keybindings.json"
    "claude/statusline.sh:.claude/statusline.sh"
)

# Links that earlier versions of this repo created. Each one is removed only while it points
# into this repo or at nothing, so that a link of the same name owned by another repo, such
# as beadwork's ~/.claude/rules/beads.md, survives.
retired=(
    ".vimrc"
    ".vim"
    ".gitattributes"
    ".claude/rules/beads.md"
    ".claude/rules/writing-examples.md"
)

link() {
    local source="$DOTFILES/$1" target="$HOME/$2" backup
    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
        return 0
    fi
    if [[ ! -e "$source" ]]; then
        echo "Skip: $1 (not in the repo)"
        return 0
    fi
    if (( CHECK )); then
        if [[ -L "$target" ]]; then
            finding "Drift: ~/$2 points at $(readlink "$target")"
        elif [[ -e "$target" ]]; then
            finding "Drift: ~/$2 is a real file, not a link to $1"
        else
            finding "Missing: ~/$2"
        fi
        return 0
    fi
    if [[ -e "$target" && ! -L "$target" ]]; then
        backup="$target.bak.$(date +%Y%m%d-%H%M%S)"
        mv "$target" "$backup"
        echo "Backed up: ~/$2 -> ~${backup#"$HOME"}"
    fi
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "Linked: ~/$2"
}

# hook_rc <rc file under $HOME> <line> <text>: make the rc file run <line>, by adding it at
# the top when no line of the file contains <text>. The rc file stays a local file, so tool
# installers that append to it never write into this repo.
hook_rc() {
    local rc="$HOME/$1" tmp
    if [[ -f "$rc" ]] && grep -qF "$3" "$rc"; then
        return 0
    fi
    if (( CHECK )); then
        finding "Missing: ~/$1 does not source $3"
        return 0
    fi
    tmp="$(mktemp)"
    printf '%s\n' "$2" > "$tmp"
    if [[ -f "$rc" ]]; then
        printf '\n' >> "$tmp"
        cat "$rc" >> "$tmp"
    fi
    cat "$tmp" > "$rc"
    rm -f "$tmp"
    echo "Hooked: ~/$1 sources $3"
}

# ~/.claude/rules holds one link per rule file, because rules come from two repos: this one
# and beadwork, whose own install.sh links beads.md. Replace an older whole-directory link
# with a real directory, so that no link below writes through it into another repo.
if [[ -L "$HOME/.claude/rules" ]]; then
    if (( CHECK )); then
        finding "Drift: ~/.claude/rules is a link; run ./install.sh to make it a directory"
    else
        rm "$HOME/.claude/rules"
    fi
fi
if (( ! CHECK )); then
    mkdir -p "$HOME/.claude/rules"
fi

for item in "${links[@]}"; do
    link "${item%%:*}" "${item#*:}"
done

for path in "${retired[@]}"; do
    target="$HOME/$path"
    if [[ ! -L "$target" ]]; then
        continue
    fi
    if [[ "$(readlink "$target")" == "$DOTFILES/"* || ! -e "$target" ]]; then
        if (( CHECK )); then
            finding "Drift: ~/$path is a retired link; run ./install.sh to remove it"
        else
            rm "$target"
            echo "Removed: ~/$path"
        fi
    fi
done

# Shell rc files source the shared config through the links above.
if command -v zsh >/dev/null 2>&1; then
    hook_rc ".zshrc" '[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases' ".zsh_aliases"
fi
if [[ -f "$HOME/.bashrc" || "$(basename "${SHELL:-}")" == "bash" ]]; then
    hook_rc ".bashrc" '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' ".bash_aliases"
fi

# ~/.gitconfig includes git/config from its first line, so that any key set later in
# ~/.gitconfig, such as user.email or a one-off `git config --global`, overrides the
# shared value.
include="$DOTFILES/git/config"
includes="$(git config --global --get-all include.path 2>/dev/null || true)"
if ! grep -qxF "$include" <<< "$includes"; then
    if (( CHECK )); then
        finding "Missing: ~/.gitconfig does not include $include"
    else
        tmp="$(mktemp)"
        printf '[include]\n\tpath = %s\n' "$include" > "$tmp"
        if [[ -f "$HOME/.gitconfig" ]]; then
            printf '\n' >> "$tmp"
            cat "$HOME/.gitconfig" >> "$tmp"
        fi
        cat "$tmp" > "$HOME/.gitconfig"
        rm -f "$tmp"
        echo "Hooked: ~/.gitconfig includes git/config"
    fi
fi
if (( CHECK )) && [[ -f "$HOME/.gitconfig" ]]; then
    shadowed="$(comm -12 \
        <(git config --file "$HOME/.gitconfig" --name-only --list | grep -v '^include\.' | sort -u) \
        <(git config --file "$include" --name-only --list | sort -u))"
    for key in $shadowed; do
        finding "Drift: ~/.gitconfig sets $key, which overrides git/config"
    done
fi

# .tmux.conf loads its plugins through tpm. bootstrap.sh installs the plugins themselves,
# so that this script makes at most one network call.
tpm="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$tpm" ]]; then
    if (( CHECK )); then
        finding "Missing: ~/.tmux/plugins/tpm"
    elif git clone -q --depth 1 https://github.com/tmux-plugins/tpm "$tpm"; then
        echo "Cloned: ~/.tmux/plugins/tpm (press prefix + I in tmux, or run bootstrap.sh, to install plugins)"
    else
        echo "Skip: tpm (git clone failed; re-run when online)"
    fi
fi

if (( CHECK )); then
    if (( findings )); then
        echo "install.sh --check: $findings finding(s)"
        exit 1
    fi
    echo "install.sh --check: every link and hook is in place"
fi
