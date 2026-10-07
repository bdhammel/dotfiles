#!/usr/bin/env bash
# install.sh - dead simple dotfile installer

set -e

DOTFILES="$HOME/dotfiles"

detect_shell() {
    basename "$SHELL"
}

detect_os() {
    case "$(uname)" in
        Darwin)
            echo "macos"
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                # shellcheck disable=SC1091
                . /etc/os-release
                case "$ID" in
                    ubuntu) echo "ubuntu" ;;
                    rhel|centos) echo "redhat" ;;
                    *) echo "linux" ;;
                esac
            else
                echo "linux"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

os_specific_setup() {
    local os_name
    os_name=$(detect_os)
    case "$os_name" in
        macos)
            echo "macOS detected"
            if command -v brew >/dev/null 2>&1; then
                xargs brew install < "$DOTFILES/brew_requirements.txt"
            fi
            ;;
        ubuntu)
            echo "Ubuntu detected"
            if command -v apt-get >/dev/null 2>&1; then
                sudo apt-get update
            fi
            ;;
        redhat)
            echo "RedHat detected"
            if command -v yum >/dev/null 2>&1; then
                sudo yum update -y
            fi
            ;;
        *)
            echo "OS $os_name not specifically handled"
            ;;
    esac
}

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
)

# Link the rc file for the login shell
case "$(detect_shell)" in
    zsh) links+=("zshrc:.zshrc") ;;
    *) links+=("bashrc:.bashrc") ;;
esac

# ~/.claude/rules holds one symlink per rule file, because rules come from two repos:
# this one and the claude_skills repo. Replace an older whole-directory symlink with a
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

# Link the worked writing examples from the claude_skills repo. They quote work code and
# documents, so they stay in that internal repo rather than this public one.
EXAMPLES_SRC="$HOME/dev/primer/benhammel/claude_skills/rules/writing-examples.md"
if [[ -e "$EXAMPLES_SRC" ]]; then
    ln -sfn "$EXAMPLES_SRC" "$HOME/.claude/rules/writing-examples.md"
    echo "Linked: .claude/rules/writing-examples.md"
else
    echo "Skip: .claude/rules/writing-examples.md (claude_skills repo not found)"
fi

# Create vim temp directory
mkdir -p ~/.vim_tmp

os_specific_setup

echo "Done. Run ./git-setup.sh to configure git (one-time setup)."
