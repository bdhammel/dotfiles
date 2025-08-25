# ~/.bashrc

# Source global bash settings
if [ -f ~/dotfiles/bash_aliases ]; then
    source ~/dotfiles/bash_aliases
fi

# Load common aliases
if [ -f ~/dotfiles/aliases ]; then
    source ~/dotfiles/aliases
fi
