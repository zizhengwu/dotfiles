#!/bin/bash
DOTFILES_PATH="$HOME/git/dotfiles/" 
SHARED="tmux mpv"
for target in $SHARED; do
    (cd $DOTFILES_PATH; stow --target=$HOME $target)
done
