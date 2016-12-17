
if [[ $OSTYPE == linux* ]]; then
    alias ls="ls --color"
else
    alias ls="ls"
fi

alias ll="ls -l"
alias la="ls -lah"

alias rm="rm -i"

alias c='clear'

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=exfxdxDxcxhxhxhxhxExEx
