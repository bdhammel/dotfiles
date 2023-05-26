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

Plugin 'ojroques/vim-oscyank', {'branch': 'main'}
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'

Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'

" Plugin 'scrooloose/nerdtree'
" Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'stephpy/vim-yaml'
Plugin 'rust-lang/rust.vim'
Plugin 'gabrielelana/vim-markdown'

Plugin 'ctrlpvim/ctrlp.vim'

" Python
Plugin 'nvie/vim-flake8'

" Plugin 'integralist/vim-mypy'
Plugin 'vim-scripts/indentpython.vim'

if has('nvim')
    Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plugin 'dense-analysis/ale'
    Plugin 'github/copilot.vim'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =============================================================================== "
" VIM config
" =============================================================================== "

set encoding=utf-8

" Make backspace behave more consistently across systems / ssh
set backspace=indent,eol,start

" Set the backup director for swap files director
set noswapfile

" Reload files changed outside vim
set autoread

" do not start in folded mode
au BufRead * normal zR

" Copy / Paste
set clipboard^=unnamed,unnamedplus

let g:oscyank_max_length = 1000000
let g:oscyank_term = 'tmux'

" Move by screen lines
nnoremap j gj
nnoremap k gk

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

" set spell
" hi clear SpellBad
" hi SpellBad cterm=underline ctermfg=red

set nospell


" =============================================================================== "
" Finder
" =============================================================================== "

" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" autocmd vimenter * NERDTree
" autocmd Vimenter * wincmd p
" let g:nerdtree_tabs_open_on_console_startup = 1
" let g:NERDTreeDirArrowExpandable="+"
" let g:NERDTreeDirArrowCollapsible="~"
"
" if &diff
"     autocmd vimenter * NERDTreeClose
" endif

let g:netrw_banner=0

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/venv/*

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }

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

" Help opens help in a vertical split
autocmd FileType help wincmd L


"=============================================================================
" Diff
"=============================================================================

" Use Patience Diff if we don't have xdiff built in
if !has("patch-8.1.0360")
    if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    endif
endif

" Fixes E474 on Catalina+ MacOS, where Apple removed xdiff
if has('mac') && $VIM == '/usr/share/vim'
    set diffopt-=internal
elseif has('patch-8.1.0360') || has('nvim-0.3.2')
    " vim: https://github.com/vim/vim/commit/e828b7621cf9065a3582be0c4dd1e0e846e335bf
    " nvim: https://github.com/neovim/neovim/commit/20620bae76deddd892df2d33f9e745efd5d8598b
    set diffopt+=algorithm:patience
endif

" Better diff line matching
if has('nvim-0.9.0')
    " nvim: https://github.com/neovim/neovim/commit/04fbb1de4488852c3ba332898b17180500f8984e
    set diffopt+=linematch:60
endif

" =============================================================================== "
" Macros
" =============================================================================== "
noremap <leader>s = :SyntasticToggleMode<CR>
imap jj <esc>
" Toggle paste
nnoremap <Leader>p :set invpaste paste?<CR>
" Find merge conflict markers
nnoremap <Leader>mc /\v^[<\|=>]{7}( .*\|$)<CR>

" In normal mode, <leader>c is an operator that will copy the given text to the clipboard.
nmap <leader>c <Plug>OSCYankOperator
" In normal mode, <leader>cc will copy the current line.
nmap <leader>cc <leader>c_
" In visual mode, <leader>c will copy the current selection.
vmap <leader>c <Plug>OSCYankVisual

autocmd TextYankPost *
    \ if v:event.operator is 'y' && v:event.regname is '+' |
    \ execute 'OSCYankRegister +' |
    \ endif

