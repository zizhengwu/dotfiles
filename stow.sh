#!/bin/bash
DOTFILES_PATH="$HOME/git/dotfiles/" 
SHARED="tmux mpv fig"
for target in $SHARED; do
    (cd $DOTFILES_PATH; stow --target=$HOME $target)
done
