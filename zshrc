# ~/.zshrc

# Source custom zsh settings
if [ -f ~/dotfiles/zsh_aliases ]; then
    source ~/dotfiles/zsh_aliases
fi

# Load common aliases
if [ -f ~/dotfiles/aliases ]; then
    source ~/dotfiles/aliases
fi
