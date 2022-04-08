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
Plugin 'vim-syntastic/syntastic'
Plugin 'chrisbra/vim-diff-enhanced'

Plugin 'ojroques/vim-oscyank'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'

Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'stephpy/vim-yaml'
Plugin 'rust-lang/rust.vim'
Plugin 'gabrielelana/vim-markdown'

" Python
Plugin 'nvie/vim-flake8'
" Plugin 'integralist/vim-mypy'
Plugin 'vim-scripts/indentpython.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =============================================================================== "
" VIM config
" =============================================================================== "

set encoding=utf-8

" Copy / Paste
set clipboard^=unnamed,unnamedplus
vmap <C-c> y:OSCYank<cr>
xmap <F7> y:OSCYank<cr>

let g:oscyank_max_length = 1000000
let g:oscyank_term = 'tmux'

" Make backspace behave more consistently across systems / ssh
set backspace=indent,eol,start

" Set the backup director for swap files directory
set noswapfile

" Reload files changed outside vim
set autoread

" do not start in folded mode
au BufRead * normal zR

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

hi CursorLineNR   gui=none ctermfg=238 ctermbg=232 cterm=none

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

au BufNewFile,BufRead *.{js,html,css,json,yaml,yml}
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" =============================================================================== "
" Python
" =============================================================================== "

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set foldmethod=manual |
    \ set fileformat=unix

autocmd FileType python se nowrap

"Draw a boarder at the limit of 79 characters if using python 
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
" Macros
" =============================================================================== "
noremap \c = :%s/\s\+$//e
noremap \s = :SyntasticToggleMode<CR>
noremap \t  :se invnumber<CR> :NERDTreeTabsToggle<CR>
imap jj <esc>
