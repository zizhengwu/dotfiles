#!/bin/bash
DOTFILES_PATH="$HOME/git/dotfiles/" 
SHARED="tmux mpv fig blaze bin lvim zsh kitty ssh astronvim goobuntu_backups"
for target in $SHARED; do
    (cd $DOTFILES_PATH; stow --adopt --no-folding --target=$HOME $target)
done
