#!/bin/bash
DOTFILES_PATH="$HOME/git/dotfiles/" 
SHARED="tmux mpv fig blaze"
for target in $SHARED; do
    (cd $DOTFILES_PATH; stow --adopt --target=$HOME $target)
done
