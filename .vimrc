:filetype plugin on
:syntax on
:set number
:set bg=dark
:set relativenumber
:set guifont=JetBrains\ Mono
:set arabicshape
:set encoding=utf-8
:set arabicshape
:set termbidi
:set spell
:set hlsearch
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'haya14busa/incsearch.vim'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-speeddating'
Plug 'preservim/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'jceb/vim-orgmode'
Plug 'plasticboy/vim-markdown'
call plug#end()

colorscheme gruvbox
