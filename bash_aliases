
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

alias python=python3
alias ipython=ipython3
alias pip=pip3

