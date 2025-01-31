# Colorizing and setting aliases
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# To use 256 colors, prefix with \e[38;5;#m  (for bg \e[48;5;#m)

export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
export GREP_COLOR='1;38;5;136'

export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\e[38;5;33m\]\h \[\e[38;5;64m\]\W\[\e[38;5;136m\]\$(parse_git_branch)\[\e[00m\] $ "

pyclean () {
    echo "Cleaning:"
    find . -type f -name "*.py[co]"
    find . -type d -name "__pycache__"
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
    echo "Need to Clean:"
    find . -type d -name ".pytest_cache"
} 2>/dev/null


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
export HISTIGNORE="ls:ps:h:rm*:ll:la:c:exit"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# pip
# export PIP_REQUIRE_VIRTUALENV=true

if [ -f ~/dotfiles/aliases ]; then
    source ~/dotfiles/aliases
fi
