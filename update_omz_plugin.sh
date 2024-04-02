#!/bin/bash
ZPLUGINDIR=$HOME/.oh-my-zsh/custom/plugins
ZTHEMEDIR=$HOME/.oh-my-zsh/custom/themes
ZSH=$HOME/.oh-my-zsh

if cd $ZPLUGINDIR/fast-syntax-highlighting; then
    git pull
else
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZPLUGINDIR/fast-syntax-highlighting
fi

if cd $ZTHEMEDIR/powerlevel10k; then
    git pull
else
    git clone https://github.com/romkatv/powerlevel10k.git $ZTHEMEDIR/powerlevel10k
fi

if cd $ZPLUGINDIR/F-Sy-H; then git pull; else git clone https://github.com/z-shell/F-Sy-H.git $ZPLUGINDIR/F-Sy-H; fi

$ZSH/tools/upgrade.sh
