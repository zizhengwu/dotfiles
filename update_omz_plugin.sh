#!/bin/bash
ZPLUGINDIR=$HOME/.oh-my-zsh/custom/plugins

if [[ ! -d $ZPLUGINDIR/fast-syntax-highlighting ]]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi
