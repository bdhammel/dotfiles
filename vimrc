" =============================================================================== "
" VIM =============================================================================== "

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

Plugin 'tpope/vim-sensible'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'gabrielelana/vim-markdown'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'


set encoding=utf-8
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

filetype plugin on
syntax on

set clipboard=unnamed

"Allows you to click around the text editor with your mouse to move the cursor
set mouse=a

" Make backspaces more powerfull
set backspace=indent,eol,start

" Set the backup director for swap files directory
set backupdir=~/.vim_tmp
set swapfile
set directory=~/.vim_tmp

" Set line numbers
set nu

" Set the commend height
set cmdheight=2

" Show current vim mode
set showmode

" Show current command
let g:lightline = {'colorscheme': 'solarized'}

" VIM colors
hi TabLine      gui=bold ctermfg=231 ctermbg=234 cterm=bold
hi TabLineSel   gui=none ctermfg=254 ctermbg=238 cterm=none
hi TabLineFill  gui=bold ctermfg=231 ctermbg=234 cterm=bold

hi StatusLine      gui=none ctermfg=231 ctermbg=234 cterm=bold
hi StatusLineNC    gui=bold ctermfg=231 ctermbg=234 cterm=none


" Spell Check
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
" Full stack
" =============================================================================== "

set tabstop=2 |
set softtabstop=2 |
set shiftwidth=2


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


" =============================================================================== "
" Full stack
" =============================================================================== "

au BufNewFile,BufRead *.js, *.html, *.css, *.json, *.yaml;
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2


" =============================================================================== "
" Searching
" =============================================================================== "

"Ignore case
set ignorecase

"Try to be smart about case when searching
set smartcase

"search results are highlighted 
set hlsearch
