" =============================================================================== "
" VIM
" =============================================================================== "

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ------------------------------------------------------------------------ "

Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'


set encoding=utf-8
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

syntax on

set clipboard=unnamed


"Allows you to click around the text editor with your mouse to move the cursor
set mouse=a

"This makes the backspace key function like it does in other programs.
set backspace=2

" set the backup director for swap files directory
set backupdir=~/.vim_tmp
set swapfile
set directory=~/.vim_tmp

set nu

"set the commend height
set cmdheight=2

"show current vim mode
set showmode

"Show current command
set showcmd
set statusline+=%F\
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y\     "filetype
set statusline+=%{v:register} " active register
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" vim colors
hi TabLine      gui=bold ctermfg=231 ctermbg=234 cterm=bold
hi TabLineSel   gui=none ctermfg=254 ctermbg=238 cterm=none
hi TabLineFill  gui=bold ctermfg=231 ctermbg=234 cterm=bold

hi StatusLine      gui=none ctermfg=231 ctermbg=234 cterm=bold
hi StatusLineNC    gui=bold ctermfg=231 ctermbg=234 cterm=none


"Spell Check
set spell
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red


" =============================================================================== "
" NERD Tree
" =============================================================================== "
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

autocmd vimenter * NERDTree
autocmd Vimenter * wincmd p
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

map \t :NERDTreeTabsToggle<CR>"

" =============================================================================== "
" Python
" =============================================================================== "

au BufNewFile,BufRead *.py;
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

"Draw a boarder at the limit of 80 characters if using python 
autocmd FileType python let &colorcolumn="80,".join(range(120,999),",")

let python_highlight_all=1

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=['flake8']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_flake8_args='--ignore=E501'
" let g:syntastic_python_flake8_args='--ignore=E501,E225'



" =============================================================================== "
" Full stack
" =============================================================================== "

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/



" =============================================================================== "
" Searching
" =============================================================================== "

"Ignore case
set ignorecase

"Try to be smart about case when searching
set smartcase

"search results are highlighted 
set hlsearch

