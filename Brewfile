# The tools this repo's config calls, plus general command-line tools.
# bootstrap.sh runs: brew bundle install --no-upgrade --file Brewfile
# Work tools live in the Brewfile of the private claude_skills repo.

tap "dicklesworthstone/tap"

# Editor, terminal and shell
brew "neovim"
brew "tree-sitter-cli"   # nvim-treesitter's main branch compiles parsers with it
brew "tmux"
brew "fzf"        # key bindings and completion in .zsh_aliases
brew "fd"         # fzf path and directory candidates
brew "bat"        # fzf file preview
brew "tree"       # fzf preview for cd
brew "ripgrep"
brew "yank"       # the yank alias and sp
brew "htop"       # htoprc
brew "mosh"
brew "wget"
cask "font-fira-code-nerd-font"
cask "font-droid-sans-mono-nerd-font"

# Git and GitHub
brew "gh"
brew "git-lfs"

# Python and Node
brew "uv"         # sp and setup_venv
brew "fnm"        # Node versions; .aliases runs its shell hook, and copilot.vim needs Node

# Linters and data tools
brew "jq"         # Claude Code hooks and statusline.sh
brew "yq"
brew "shellcheck"
brew "shfmt"
brew "actionlint"
brew "yamllint"
brew "vale"       # prose lint
brew "cloc"
brew "datasette"
brew "ffmpeg"

# Bead tracker, its board, and beadwork's bd-tui
brew "beads"
brew "dicklesworthstone/tap/bv", trusted: true
