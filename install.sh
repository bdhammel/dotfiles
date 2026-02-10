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
    "htoprc:.config/htop/htoprc"
    "ipython/profile_default/ipython_config.py:.ipython/profile_default/ipython_config.py"
    "ipython/profile_default/startup/ipython_startup.py:.ipython/profile_default/startup/ipython_startup.py"
)

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

# Create vim temp directory
mkdir -p ~/.vim_tmp

echo "Done. Run ./git-setup.sh to configure git (one-time setup)."
