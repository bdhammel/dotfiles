# Colorizing and setting aliases
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# To use 256 colors, prefix with \e[38;5;#m  (for bg \e[48;5;#m)

if [[ $OSTYPE == linux* ]]; then
    alias ls="ls --color"
    alias grep="grep --color=auto"
	  alias ll="ls -lh  --time-style long-iso"
else
    alias ls="ls"
    export GREP_OPTIONS='--color=auto'
    export CLICOLOR=1
	  alias ll="ls -lht"
fi

alias la="ll -a"
alias rm="rm -i"
alias c='clear'
alias h='history'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
export GREP_COLOR='1;38;5;136'

export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR=vim

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

alias web_finder="python3 -m http.server --bind $HOSTNAME"
alias yank="yank-cli ~/dotfiles/osc52.sh"
