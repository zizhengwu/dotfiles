#!/bin/bash
ZPLUGINDIR=$HOME/.oh-my-zsh/custom/plugins
ZTHEMEDIR=$HOME/.oh-my-zsh/custom/themes

if cd $ZPLUGINDIR/fast-syntax-highlighting; then git pull; else git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZPLUGINDIR/fast-syntax-highlighting; fi

if cd $ZTHEMEDIR/powerlevel10k; then git pull; else git clone https://github.com/romkatv/powerlevel10k.git $ZTHEMEDIR/powerlevel10k; fi

zsh -ic "omz update"
