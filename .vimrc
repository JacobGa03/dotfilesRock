" BASIC SETUP -------------------
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set relativenumber

" Set tab width to 4 columns.
set tabstop=3

" Use space characters instead of tabs.
set expandtab

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

autocmd FileType * set formatoptions-=r

colorscheme lunaperche 

" MAPPINGS ----------------------
" Remap 'jj' to enter Insert mode
inoremap jj <Esc>

" Make it so the cursors stays center when you page down
inoremap <c-d>  <c-d zz>

" Make it so the cursors stays center when you page up
inoremap <c-u>  <c-d zz>
