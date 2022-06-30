"-------- General -------"
" disable compatibility to old-time vi
set nocompatible
" Speed up scrolling in Vim
set ttyfast
" enable spell check (may need to download language package)
" set spell

"-------- UI -------"

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" show matching 
set showmatch
" case insensitive 
set ignorecase
" highlight search 
set hlsearch
" incremental search
set incsearch
" add line numbers
"  set number
" highlight current cursorline
set cursorline
"  hi CursorLine cterm=NONE ctermbg=242

"-------- Tabs & indentation -------"
" number of columns occupied by a tab 
set tabstop=4
" see multiple spaces as tabstops so <BS> does the right thing
set softtabstop=4
" converts tabs to white space
set expandtab
" width for autoindents
set shiftwidth=4
" indent a new line the same amount as the line just typed
set autoindent
" get bash-like tab completions
set wildmode=longest,list
" allow auto-indenting depending on file type
filetype plugin indent on

"-------- Colors an fonts -------"
" syntax highlighting
syntax on

"-------- Files -------"

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"-------------- Plugins ------------"

filetype plugin on

call plug#begin()
Plug 'MTDL9/vim-log-highlighting'
Plug 'vim-airline/vim-airline'
call plug#end()
