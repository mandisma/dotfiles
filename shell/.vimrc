"-------- Tabs & indentation -------"

filetype plugin indent on
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Round indent to nearest multiple of 4
set shiftround
" No line-wrapping
set nowrap

"-------------- Plugins ------------"

call plug#begin()
Plug 'MTDL9/vim-log-highlighting'
call plug#end()