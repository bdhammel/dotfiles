
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

alias cpu_venv="source ~/venvs/cpu_venv/bin/activate"
alias gpu_venv="source ~/venvs/gpu_venv/bin/activate"

alias gpustat='watch -n .5 --color gpustat --color -cpP'
