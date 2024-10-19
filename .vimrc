:filetype plugin on
:syntax on
:set number
:set bg=dark
:set relativenumber
:set spell
:set hlsearch
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'haya14busa/incsearch.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'

call plug#end()

colorscheme gruvbox
