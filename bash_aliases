
if [[ $OSTYPE == linux* ]]; then
    alias ls="ls --color"
    alias grep="grep --color=always"
else
    alias ls="ls"
    export GREP_OPTIONS='--color=auto'
    export CLICOLOR=1
fi

alias ll="ls -lh"
alias la="ll -a"

alias rm="rm -i"

alias c='clear'

alias pip="pip3"
alias ipython="ipython3"
alias python="python3"

export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
export GREP_COLOR='1;32'



