
if [[ $OSTYPE == linux* ]]; then
    alias ls="ls --color"
    alias grep="grep --color=auto"
else
    alias ls="ls"
    export GREP_OPTIONS='--color=auto'
    export CLICOLOR=1
fi

alias ll="ls -lh"
alias la="ll -a"

alias rm="rm -i"

alias c='clear'
alias h='history'

export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
export GREP_COLOR='1;32'

export EDITOR=vim
export VISUAL=vim

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\h \[\033[34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
