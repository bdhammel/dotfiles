#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_aliases vimrc vim gvimrc vim_tmp tmux.conf gitignore_global"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to home directory ..."
cd ~
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo -n "Installing vim bundle submodules"
git submodule init
git submodule update

echo -n "Adding bash_aliases to .bashrc"
echo "
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
" >> ~/.bashrc

echo -n "Setting global gitignore"
git config --global core.excludesfile ~/.gitignore_global
