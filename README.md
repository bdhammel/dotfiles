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

For High Sierra (might not be needed):

~~~
brew install reattach-to-user-namespace
~~~
