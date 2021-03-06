set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=2

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-expand-region'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'flazz/vim-colorschemes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" basic config
syntax enable
set number

" encoding
set encoding=utf-8
set fileencoding=utf-8

" indent
set autoindent
set cindent
set smartindent

" tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" match
set showmatch

" colors
set t_Co=256
set background=light
let macvim_skip_colorscheme=1
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
colorscheme Tomorrow

" font
set guifont=Liberation\ Mono:h20

" cursor no blink
set gcr=a:blinkon0

" highlight the cursorline
set cursorline 

" set <leader>
let mapleader = ' '

" vim-airline
set laststatus=2

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = '~/.pyenv/shims/python'

" key Mappings for YouCompleteMe
nnoremap <Leader>di :YcmCompleter GoToDeclaration<Enter>
nnoremap <Leader>dd :YcmCompleter GoToDefinition<Enter>
nnoremap <Leader>dg :YcmCompleter GoTo<Enter>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" key Mappings for NERDTree
nnoremap <Leader><Leader>n :NERDTreeTabsToggle<CR>

" folding
set mouse=a

" gubbins
nmap ? /\<\><Left><Left>

" put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" quick copy all to system clipboard
nnoremap <Leader><Leader>c ggVG"+y

" make backspaces more powerfull
set backspace=indent,eol,start
