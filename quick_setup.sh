#!/bin/bash

# Check if ~/.vimrc exists, if not, download it
if [ ! -f ~/.vimrc ]; then
    wget https://raw.githubusercontent.com/bdhammel/dotfiles/master/basic_vimrc -O ~/.vimrc
    echo "Downloaded .vimrc"
else
    echo ".vimrc already exists, skipping download."
fi

# Check tmux version and download appropriate config
if command -v tmux &> /dev/null; then
    tmux_version=$(tmux -V | grep -o -E '[0-9]+\.[0-9]+')
    if (( $(echo "$tmux_version >= 3.0" | bc -l) )); then
        wget https://raw.githubusercontent.com/bdhammel/dotfiles/refs/heads/master/tmux.conf_3 -O ~/.tmux.conf
        echo "Downloaded tmux.conf for tmux version 3 or higher"
    else
        wget https://raw.githubusercontent.com/bdhammel/dotfiles/refs/heads/master/tmux.conf_2 -O ~/.tmux.conf
        echo "Downloaded tmux.conf for tmux version less than 3"
    fi
else
    echo "tmux is not installed, skipping tmux configuration download."
fi

# Set vi key bindings for the current shell session
set -o vi
echo "Set vi key bindings."

# Ensure vi mode is set in future shell sessions by adding to ~/.bashrc
echo "set -o vi" >> ~/.bashrc

# Set up basic aliases
echo 'alias grep="grep --color=auto"' >> ~/.bashrc
echo 'alias ls="ls --color"' >> ~/.bashrc
echo 'alias ll="ls -lhtU --time-style long-iso"' >> ~/.bashrc
echo 'alias la="ll -a"' >> ~/.bashrc
echo "Added basic aliases to ~/.bashrc"
