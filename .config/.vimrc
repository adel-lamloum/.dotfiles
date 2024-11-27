" Enable filetype detection and plugin loading
filetype plugin on

" Enable syntax highlighting
syntax on

" Show line numbers
set number

" Set background to dark
set bg=dark

" Enable mouse support
set mouse=a

" Enable mouse copying in clipboard
set clipboard=unnamedplus

" Enable mouse selection in visual mode (redundant with mouse=a)
" set mouse=v

" Set colorscheme to solarized
colorscheme solarized

" Set nocompatible mode
set nocompatible

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Enable current line highlighting
set cursorline

" Respect modeline in files
set modeline
set modelines=4

" Enable relative line numbers
set relativenumber

" Set GUI font
set guifont=JetBrains\ Mono

" Set encoding to UTF-8
set encoding=utf-8

" Enable bidirectional text support
set termbidi

" Enable spell checking
set spell

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Show the cursor position
set ruler

" Initialize vim-plug
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'haya14busa/incsearch.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-speeddating'
Plug 'preservim/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'jceb/vim-orgmode'
Plug 'plasticboy/vim-markdown'

" End vim-plug initialization
call plug#end()

" Clear search highlights with Ctrl+L
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Disable relativenumber and cursorline in large files
autocmd BufReadPre * if getfsize(expand("%")) > 1000000 | setlocal norelativenumber nocursorline | endif
