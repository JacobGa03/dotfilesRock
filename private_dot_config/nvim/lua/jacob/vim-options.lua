-- set the leaderkey as space
vim.g.mapleader = " "
-- Disable compatibility with vi which can cause unexpected issues.
vim.cmd("set nocompatible")

-- Enable type file detection. Vim will be able to try to detect the type of file in use.
vim.cmd("filetype on")

-- Enable plugins and load plugin for the detected file type.
vim.cmd("filetype plugin on")

-- Load an indent file for the detected file type.
vim.cmd("filetype indent on")
-- Indent automatically based on file type
vim.cmd("filetype indent indent on")

-- Turn syntax highlighting on.
vim.cmd("syntax on")

-- Set tab width to 4 columns w/ spaces, not tabs.
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=4")
-- Indent to the same depth as previous line
vim.cmd("set autoindent")
vim.cmd("set smartindent")

-- Use space characters instead of tabs.
vim.cmd("set expandtab")

-- Do not wrap lines. Allow long lines to extend as far as the line goes.
vim.cmd("set nowrap")

-- Do not let cursor scroll below or above N number of lines when scrolling.
vim.cmd("set scrolloff=10")

-- Show partial command you type in the last line of the screen.
vim.cmd("set showcmd")

-- Show the mode you are on the last line.
vim.cmd("set showmode")

-- Show matching words during a search.
vim.cmd("set showmatch")

-- Use highlighting when doing a search.
vim.cmd("set hlsearch")
-- Use incremental search
vim.cmd("set incsearch")
-- When searching case doesn't matter
vim.cmd("set ignorecase")

-- Enable auto completion menu after pressing TAB.
vim.cmd("set wildmenu")

-- Make wildmenu behave like similar to Bash completion.
vim.cmd("set wildmode=list:longest")

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.cmd("set cursorline")

vim.cmd("set ttyfast")

-- There are certain files that we would never want to edit with Vim.
-- Wildmenu will ignore files with these extensions.
vim.cmd("set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx")

vim.cmd("autocmd FileType * set formatoptions-=r")

-- Use system clipboard
vim.cmd("set clipboard=unnamedplus")

vim.cmd("set cc=80")
