#!/bin/bash

# Check if ~/.vimrc exists, if not, download it
if [ ! -f ~/.vimrc ]; then
    wget https://raw.githubusercontent.com/bdhammel/dotfiles/master/basic_vimrc -O ~/.vimrc
    echo "Downloaded .vimrc"
else
    echo ".vimrc already exists, skipping download."
fi

# Set vi key bindings for the current shell session
set -o vi
echo "Set vi key bindings."

# Ensure vi mode is set in future shell sessions by adding to ~/.bashrc
if ! grep -q "set -o vi" ~/.bashrc; then
    echo "set -o vi" >> ~/.bashrc
    echo "Added vi key bindings to ~/.bashrc"
fi
