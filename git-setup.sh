#!/usr/bin/env bash
# git-setup.sh - one-time git configuration
# Run this once per machine after install.sh

set -e

echo "Configuring git settings..."

# Core settings
git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor nvim
git config --global color.ui auto

# Diff/merge tools
git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global merge.tool nvimdiff
git config --global mergetool.keepBackup false

# Branch/pull behavior
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global fetch.prune true
git config --global push.default simple
git config --global branch.sort -committerdate

# Rerere (reuse recorded resolution)
git config --global rerere.enabled true
git config --global rerere.autoUpdate true

# Aliases
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.br "branch"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.graph "log --oneline --branches --graph --decorate"
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.fpush "push --force-with-lease"
git config --global alias.blame "blame -w -C -C -C"

echo "Git configured."
