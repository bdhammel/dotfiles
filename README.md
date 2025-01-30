# Dotfiles set up

## Set up at new location

**one-line command**
~~~bash
cd ~ && ./dotfiles/makesymlinks.sh
~~~

**import individual file**
~~~bash
$ cd ~
$ ln -s dotfiles/vim .vim
~~~

## Setting up Git

https://help.github.com/articles/checking-for-existing-ssh-keys/

See http://stackoverflow.com/questions/7773181/git-keeps-prompting-me-for-password

> Make sure you are cloning your repos using ssh:
> 
> ssh://git@github.com/username/repo.git
> If you use https or git, you will always be asked for username/password:
> 
> https://github.com/username/repo.git
> git://github.com/username/repo.git

# Mac Setup

## brew

install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
xargs brew install < ~/dotfiles/brew_requirements.txt
```

## Mapping caps -> <kb>esc</kb>

```
system preferences > keyboard > keyboard > modifier keys
```


## Misc info

Ubuntu
```
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
```

## Very basic VIM

Download the very basic vimrc for using on other peoples computer

```
wget https://raw.githubusercontent.com/bdhammel/dotfiles/master/basic_vimrc -O ~/.vimrc
```


## VIM buffer reference

Switch between buffers `:bn` and `:bp` 	

list buffers `:ls`

open new file in buffer `:e <filename>`

delete buffer `:db`

### Splits

horizontal split `:sp <filename>`

vertical split `:vs <filename>`

Use Neovim as a git difftool
Just paste this into your ~/.gitconfig

```
[difftool]
    prompt = true
[diff]
    tool = nvimdiff
[difftool "nvimdiff"]
    cmd = "nvim -d \"$LOCAL\" \"$REMOTE\""
```

```
git maintenance start
```

https://blog.gitbutler.com/git-tips-2-new-stuff-in-git/

### Copy Pase

https://github.com/tmux/tmux/wiki/Clipboard#quick-summary

## Setting up without sudo?

install to location `/home/<user>/bin`

cite: https://medium.com/thelinux/the-correct-way-to-install-the-neovim-42f3076f9b88
```
cd /home/$(whoami)/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
```
to get tmux:
cite: https://github.com/nelsonenzo/tmux-appimage
```
curl -s https://api.github.com/repos/nelsonenzo/tmux-appimage/releases/latest \
| grep "browser_download_url.*appimage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - \
&& chmod +x tmux.appimage
```

## Installing packages w/o sudo

You can install into two different user `bin` locations
 - `/usr/bin`
 - `~/bin`

ensure `/usr/bin` is exported into `PATH`

```
   cd /usr/bin
   wget <url to binary>
   tar -zxvf download-pkg
   mv dowloaded-pkg/app app
```

Packages to install
 - [ripgrep](https://github.com/BurntSushi/ripgrep/releases)
 - [fzf]
 - [fd-find]
 - [yank](https://github.com/mptre/yank/releases)
 - [bat]

### Install NVIM

Get appimage from here: https://github.com/neovim/neovim-releases/releases
```
cd /usr/bin
wget <url to binary>
Run chmod u+x nvim.appimage
ln -s nvim.appimage nvim
```


## Quick setup

```
wget https://raw.githubusercontent.com/bdhammel/dotfiles/master/quick_setup.sh | bash
```

