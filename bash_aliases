
if [[ $OSTYPE == linux* ]]; then
    alias ls="ls --color"
    alias grep="grep --color=always"
else
    alias ls="ls"
    export GREP_OPTIONS='--color=auto'
    export CLICOLOR=1
fi

alias ll="ls -l"
alias la="ls -lah"

alias rm="rm -i"

alias c='clear'

export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
export GREP_COLOR='1;32'



