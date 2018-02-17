# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"
# Customize the train
BULLETTRAIN_CONTEXT_BG=white
BULLETTRAIN_DIR_EXTENDED=2

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gitfast alias-tips zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# bindkey
bindkey '^R' history-incremental-search-backward

# alias
alias vim='nvim'
alias rm='rmtrash'
bindkey '^[[Z' reverse-menu-complete

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# nvm
source $HOME/.nvm/nvm.sh

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# ls with color
eval `gdircolors ~/.dir_colors`
alias ls='gls --color'
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

# vim 256 Colors
export TERM='xterm-256color'

# zaw
source /Users/zizheng/git/dotfiles/zaw/zaw.zsh
bindkey '^R' zaw-history
zstyle ':filter-select' hist-find-no-dups yes
