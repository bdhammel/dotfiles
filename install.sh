#!/usr/bin/env bash
# install.sh - dead simple dotfile installer

set -e

DOTFILES="$HOME/dotfiles"

# Files to symlink (source:dest, dest defaults to ~/$source)
links=(
    ".aliases"
    ".bash_aliases"
    ".zsh_aliases"
    ".vimrc"
    ".gitignore_global"
    ".inputrc"
    ".pdbrc"
    ".pdbrc.py"
    ".tmux.conf"
    "vim:.vim"
    "nvim:.config/nvim"
    "cmux/settings.json:.config/cmux/settings.json"
    "ghostty/config:.config/ghostty/config"
    "htoprc:.config/htop/htoprc"
    "ipython/profile_default/ipython_config.py:.ipython/profile_default/ipython_config.py"
    "ipython/profile_default/startup/ipython_startup.py:.ipython/profile_default/startup/ipython_startup.py"
    "claude/rules/writing.md:.claude/rules/writing.md"
    "claude/rules/beads.md:.claude/rules/beads.md"
)

# ~/.claude/rules holds one symlink per rule file, because rules can come from more than
# one repo. Replace an older whole-directory symlink with a
# real directory, so the loop below never writes through it into another repo.
if [[ -L "$HOME/.claude/rules" ]]; then
    rm "$HOME/.claude/rules"
fi
mkdir -p "$HOME/.claude/rules"

for item in "${links[@]}"; do
    src="${item%%:*}"
    dest="${item#*:}"
    [[ "$dest" == "$src" ]] && dest="$src"

    target="$HOME/$dest"
    source="$DOTFILES/$src"

    # Skip if source doesn't exist
    if [[ ! -e "$source" ]]; then
        echo "Skip: $src (not found)"
        continue
    fi

    # Skip if already correctly linked
    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
        continue
    fi

    # Backup existing file (not symlink)
    if [[ -e "$target" && ! -L "$target" ]]; then
        mv "$target" "$target.bak"
        echo "Backed up: $dest"
    fi

    # Remove existing symlink pointing elsewhere
    [[ -L "$target" ]] && rm "$target"

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    # Create symlink
    ln -s "$source" "$target"
    echo "Linked: $dest"
done

# Link the `mux` multiplexer shim (tmux/cmux) from the claude_skills repo.
# Lives there, not here, so it stays versioned with the skills that call it.
MUX_SRC="$HOME/dev/primer/benhammel/claude_skills/bin/mux"
if [[ -e "$MUX_SRC" ]]; then
    mkdir -p "$HOME/.local/bin"
    ln -sfn "$MUX_SRC" "$HOME/.local/bin/mux"
    echo "Linked: .local/bin/mux"
else
    echo "Skip: .local/bin/mux (claude_skills repo not found)"
fi

# The worked writing examples load only when the writing-review skill in the claude_skills
# repo reviews a document, so every session loads just the core rules in writing.md. Remove
# the link that older installs created.
if [[ -L "$HOME/.claude/rules/writing-examples.md" ]]; then
    rm "$HOME/.claude/rules/writing-examples.md"
    echo "Removed: .claude/rules/writing-examples.md"
fi

# Create vim temp directory
mkdir -p ~/.vim_tmp

echo "Done. Run ./git-setup.sh to configure git (one-time setup)."
