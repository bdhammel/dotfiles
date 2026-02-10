# Colorizing and setting aliases
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# To use 256 colors, prefix with \e[38;5;#m  (for bg \e[48;5;#m)

parse_git_branch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " ($branch)"
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
export HISTIGNORE="ls:ps:h:ll:la:c:exit"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=100000

# pip
# export PIP_REQUIRE_VIRTUALENV=true

if [ -f ~/dotfiles/aliases ]; then
    source ~/dotfiles/aliases
fi
