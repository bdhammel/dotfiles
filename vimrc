" =============================================================================== "
" VIM Plugins
" =============================================================================== "

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'

Plugin 'fcpg/vim-osc52'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'gabrielelana/vim-markdown'

Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-surround'

Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'
Plugin 'nvie/vim-flake8'

Plugin 'stephpy/vim-yaml'
Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =============================================================================== "
" VIM config
" =============================================================================== "

set encoding=utf-8

" Copy / Paste
set clipboard^=unnamed,unnamedplus
xmap <F9> y:call SendViaOSC52(getreg('"'))<cr>

"Allows you to click around the text editor with your mouse to move the cursor
set mouse=r

" Make backspace behave more consistently across systems / ssh
set backspace=indent,eol,start

" Set the backup director for swap files directory
set swapfile
set backupdir=~/.vim_tmp
set directory=~/.vim_tmp

" Reload files changed outside vim
set autoread

" =============================================================================== "
" VIM appearance 
" =============================================================================== "

set background=dark

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

syntax on

" Set line numbers
set nu

" Set the commend height
set cmdheight=2

" Show current vim mode
set showmode

" Show current command
let g:lightline = {'colorscheme': 'solarized'}

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" VIM colors, make vim match tmux status bar
hi TabLine      gui=bold ctermfg=231 ctermbg=234 cterm=bold
hi TabLineSel   gui=none ctermfg=254 ctermbg=238 cterm=none
hi TabLineFill  gui=bold ctermfg=231 ctermbg=234 cterm=bold

hi StatusLine      gui=none ctermfg=231 ctermbg=234 cterm=bold
hi StatusLineNC    gui=bold ctermfg=231 ctermbg=234 cterm=none

" =============================================================================== "
" Spell Check
" =============================================================================== "

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
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" =============================================================================== "
" Full stack
" =============================================================================== "

set softtabstop=4 shiftwidth=4 expandtab 

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au BufNewFile,BufRead *.{js,html,css,json};
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

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

autocmd FileType python se nowrap

"Draw a boarder at the limit of 79 characters if using python 
" autocmd FileType python let &colorcolumn="80,".join(range(120,999),",")
autocmd FileType python let &colorcolumn=join(range(120,999),",")

let python_highlight_all=1

" Set python linting
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=['flake8']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_flake8_args='--ignore=E501,W503,E226,E402'

" =============================================================================== "
" Searching
" =============================================================================== "

"Ignore case
set ignorecase

"Try to be smart about case when searching
set smartcase

"search results are highlighted 
set hlsearch

" =============================================================================== "
" Tab complete
" =============================================================================== "

let g:jedi#popup_on_dot = 0
let g:jedi#force_py_version=3

" =============================================================================== "
" set Vim Diff 
" =============================================================================== "
if &diff
    autocmd FileType python let &colorcolumn=""
    highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
    autocmd Syntax c,cpp,vim,xml,html,xhtml,python setlocal foldmethod=syntax
    autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,python normal zR
endif

" =============================================================================== "
" Macros
" =============================================================================== "
noremap \c = :%s/\s\+$//e
noremap \s = :SyntasticToggleMode<CR>
noremap \t  :se invnumber<CR> :NERDTreeTabsToggle<CR>
imap jj <esc>
