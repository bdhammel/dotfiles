# Dotfiles set up

## Set up at new location

**import individual file**
~~~bash
$ cd ~
$ ln -s dotfiles/vim .vim
~~~

**one-line command**
~~~bash
cd ~ && ./dotfiles/makesymlinks.sh
~~~

For High Sierra:

~~~
brew install reattach-to-user-namespace
~~~

Ensure the following is set in .tmux.conf:

~~~
set -g default-shell $SHELL 
set -g default-command "reattach-to-user-namespace -l ${SHELL}"
~~~

In .vimrc or ~/.config/nvim/init.vim (I use Neovim):

~~~
set clipboard=unnamed
~~~

Now all is well and I can copy/paste between system <-> vim sessions using vim keybindings and/or system ctrl+c / ctrl+p.e

(SO question)[http://stackoverflow.com/questions/41197721/pathogen-bundles-not-being-saved-by-git?noredirect=1#comment69595122_41197721)
