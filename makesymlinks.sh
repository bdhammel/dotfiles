#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_aliases vimrc vim tmux.conf gitignore_global inputrc"    # list of files/folders to symlink in homedir

##########

# Create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

cd dotfiles
echo -n "Installing Vundle ..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim

# Change to the home directory
echo -n "Changing to home directory ..."
cd ~
echo "done"

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ -f ~/.$file ]; then
        echo "Moving existing dotfile, $file from ~ to $olddir"
        mv ~/.$file $olddir
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Create a directory for vim temporary files 
cd ~
echo -n "making vim_tmp dir"
mkdir -p ~/.vim_tmp

# Set the global .gitignore script
echo -n "Setting git settings"
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global mergetool.keepBackup false

# Set the global .gitignore script
echo -n "Setting up ipython evn" 
if [ ! -f ~/.ipython/profile_default/ ]; then
    echo -n "making .ipython dir"
    mkdir -p ~/.ipython/profile_default/startup/
fi
ln -s ~/$dir/ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -s ~/$dir/ipython/profile_default/startup/ipython_startup.py ~/.ipython/profile_default/startup/ipython_startup.py

source .bashrc
source .inputrc

echo "Remember to install vim packages with :PluginInstall"
