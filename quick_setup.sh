#!/usr/bin/env bash
# Minimal setup for a machine you do not own: a basic vimrc, this repo's tmux config, and vi
# mode plus a few aliases in ~/.bashrc. It never overwrites an existing file, and a re-run
# adds nothing twice.
#
#   curl -fsSL https://raw.githubusercontent.com/bdhammel/dotfiles/master/quick_setup.sh | bash
set -u

RAW="https://raw.githubusercontent.com/bdhammel/dotfiles/master"

# fetch <repo path> <target>: download into a temp file and move it into place only when the
# download succeeds, so that a failed download never leaves an empty target.
fetch() {
    local tmp
    if [ -e "$2" ]; then
        echo "Skip: $2 exists"
        return 0
    fi
    tmp="$(mktemp)"
    if curl -fsSL "$RAW/$1" -o "$tmp" 2>/dev/null || wget -q "$RAW/$1" -O "$tmp" 2>/dev/null; then
        mv "$tmp" "$2"
        echo "Downloaded: $2"
    else
        rm -f "$tmp"
        echo "Failed: $RAW/$1"
    fi
}

fetch basic_vimrc "$HOME/.vimrc"

# .tmux.conf uses extended-keys and terminal-features, which need tmux 3.2 or later.
if command -v tmux >/dev/null 2>&1; then
    version="$(tmux -V | sed -E 's/[^0-9]*([0-9]+)\.([0-9]+).*/\1 \2/')"
    major="${version% *}"
    minor="${version#* }"
    if [ "$major" -gt 3 ] || { [ "$major" -eq 3 ] && [ "$minor" -ge 2 ]; }; then
        fetch .tmux.conf "$HOME/.tmux.conf"
    else
        echo "Skip: .tmux.conf (needs tmux 3.2 or later, found $(tmux -V))"
    fi
else
    echo "Skip: .tmux.conf (tmux is not installed)"
fi

marker="# >>> dotfiles quick_setup >>>"
if grep -qF "$marker" "$HOME/.bashrc" 2>/dev/null; then
    echo "Skip: ~/.bashrc already has the quick_setup block"
else
    cat >> "$HOME/.bashrc" <<EOF

$marker
set -o vi
alias grep="grep --color=auto"
alias ls="ls --color"
alias ll="ls -lhtU --time-style long-iso"
alias la="ll -a"
# <<< dotfiles quick_setup <<<
EOF
    echo "Added: vi mode and aliases to ~/.bashrc (open a new shell to use them)"
fi
