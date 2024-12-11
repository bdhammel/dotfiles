#!/usr/bin/env bash

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=("bash_aliases" "vimrc" "vim" "tmux.conf" "gitignore_global" "inputrc" "zsh_aliases") # list of files/folders to symlink in homedir

create_backup() {
    # Create dotfiles_old in homedir
    echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
    mkdir -p "$olddir" && echo "done" || echo "failed"
}

install_vim_plug() {
    echo -n "Installing Plug ..."
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs \
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" && echo "done" || echo "failed"
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
    cd "$dir" || exit
    install_vim_plug
    cd ~ || exit
    move_and_link_files
    cd ~ || exit
    setup_new_files
    setup_git
    echo "Remember to install vim packages with :PlugInstall"
}


main "$@"
