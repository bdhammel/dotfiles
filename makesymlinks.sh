#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=("bash_aliases" "vimrc" "vim" "gitignore_global" "inputrc" "zsh_aliases" "pdbrc" "pdbrc.py") # list of files/folders to symlink in homedir

create_backup() {
    # Create dotfiles_old in homedir
    echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
    mkdir -p "$olddir" && echo "done" || echo "failed"
}

move_and_link_files() {
    for file in "${files[@]}"; do # Use "${files[@]}" to loop over array items
        local src="${HOME}/.${file}"
        local dest="$dir/$file"
        if [ -e "$src" ]; then
            echo "Moving existing dotfile $file from ~ to $olddir"
            mv "$src" "$olddir"
        fi
        echo "Creating symlink to $file in home directory."
        ln -s "$dest" "$src"
    done

    if [ ! -d ~/.config/htop/ ]; then
        echo "making .htoprc"
        mkdir -p ~/.config/htop
    fi

    if [ ! -d ~/.config/nvim/ ]; then
        echo "Creating symlink for nvim config"
        ln -s "$dir/nvim" ~/.config/nvim
    fi
}

setup_tmux_config() {
    local src="${HOME}/.tmux.conf"
    local tmux_conf_file="tmux.conf_2"  # default to version 2 config
    
    # Check if tmux is installed
    if command -v tmux >/dev/null 2>&1; then
        # Get tmux version and extract major version number
        local tmux_version_output
        tmux_version_output=$(tmux -V 2>/dev/null || echo "tmux 2.0")
        local major_version
        major_version=$(echo "$tmux_version_output" | sed -n 's/tmux \([0-9]*\).*/\1/p')
        
        if [[ "$major_version" =~ ^[0-9]+$ ]] && [ "$major_version" -gt 3 ]; then
            tmux_conf_file="tmux.conf_3"
            echo "Detected tmux version $major_version (>3), using tmux.conf_3"
        else
            echo "Detected tmux version $major_version (<=3), using tmux.conf_2"
        fi
    else
        echo "tmux not found, defaulting to tmux.conf_2"
    fi
    
    # Handle existing .tmux.conf file
    if [ -e "$src" ]; then
        echo "Moving existing .tmux.conf from ~ to $olddir"
        mv "$src" "$olddir"
    fi
    
    # Create symlink to appropriate tmux config
    local dest="$dir/$tmux_conf_file"
    echo "Creating symlink to $tmux_conf_file in home directory."
    ln -s "$dest" "$src"
}

setup_git() {
    echo "Setting git settings"
    git config --global core.excludesfile ~/.gitignore_global
    git config --global diff.tool nvimdiff
    git config --global difftool.prompt false
    git config --global merge.tool vimdiff
    git config --global merge.tool nvimdiff
    git config --global mergetool.keepBackup false
    git config --global init.defaultBranch main
    git config --global rerere.enabled true
    git config --global rerere.autoUpdate true
    git config --global branch.sort -committerdate
    git config --global alias.blame "blame -w -C -C -C"
    git config --global alias.graph "log --oneline --branches --graph --decorate"
    git config --global alias.fpush "push --force-with-lease"
    
    # Additional configurations
    git config --global color.ui auto
    git config --global core.editor nvim
    git config --global pull.rebase false
    git config --global fetch.prune true
    git config --global alias.st "status"
    git config --global alias.co "checkout"
    git config --global alias.ci "commit"
    git config --global alias.br "branch"
    git config --global alias.lg "log --oneline --graph --decorate --all"
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.visual "!gitk"
    git config --global push.default simple
}


setup_new_files() {
    ln -s $dir/htoprc ~/.config/htop/htoprc

    # Create a directory for vim temporary files 
    echo "making vim_tmp dir"
    mkdir -p ~/.vim_tmp

    # Set the global .gitignore script
    echo "Setting up ipython evn" 
    if [ ! -d ~/.ipython/profile_default/ ]; then
        echo "making .ipython dir"
        mkdir -p ~/.ipython/profile_default/startup/
    fi
    ln -s $dir/ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
    ln -s $dir/ipython/profile_default/startup/ipython_startup.py ~/.ipython/profile_default/startup/ipython_startup.py
}


main() {
    create_backup
    cd ~ || exit
    move_and_link_files
    setup_tmux_config
    cd ~ || exit
    setup_new_files
    setup_git
}


main "$@"
