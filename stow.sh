#!/bin/bash
DOTFILES_PATH="$HOME/git/dotfiles/" 
SHARED="mpv fig blaze bin kitty ssh goobuntu_backups"
for target in $SHARED; do
    (cd $DOTFILES_PATH; stow --adopt --no-folding --target=$HOME $target)
done
