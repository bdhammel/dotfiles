# ensure we have correct locale set (this is mostly for MacOS)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# perform parameter expansion/command substitution in prompt
setopt PROMPT_SUBST

# editor/visual
alias vimdiff='nvim -d'
alias vim='nvim'
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export PAGER=less

# zsh will not beep
setopt no_beep

# make cd push the old directory onto the directory stack
setopt auto_pushd

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.1.0/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.1.0/gems/:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L$(brew --prefix xz)/lib $LDFLAGS"
export CPPFLAGS="-I$(brew --prefix xz)/include $CPPFLAGS"
export PKG_CONFIG_PATH="$(brew --prefix xz)/lib/pkgconfig:$PKG_CONFIG_PATH"

bindkey -v
# bindkey "^R" history-incremental-search-backward
#
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi
export PATH="/opt/homebrew/opt/mongodb-community@4.4/bin:$PATH"
