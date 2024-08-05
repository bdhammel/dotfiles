" =============================================================================== "
" VIM Plugins
" =============================================================================== "

set nocompatible              " required
filetype off                  " required

let using_neovim = has('nvim')

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'tpope/vim-surround'
Plug 'chrisbra/vim-diff-enhanced'

Plug 'somini/pydoc.vim'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'vim-scripts/indentpython.vim'
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if using_neovim
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Plug 'github/copilot.vim'
endif

" All of your Plugins must be added before the following line
call plug#end()

" =============================================================================== "
" VIM config
" =============================================================================== "

filetype plugin indent on    " required

set encoding=utf-8

" Make backspace behave more consistently across systems / ssh
set backspace=indent,eol,start

" Set the backup director for swap files director
set noswapfile

" Reload files changed outside vim
set autoread

" do not start in folded mode
au BufRead * normal zR

" =============================================================================== "
" Copy / Paste
" =============================================================================== "
set clipboard^=unnamed,unnamedplus

" Toggle paste
nnoremap <Leader>p :set invpaste paste?<CR>

let g:oscyank_max_length = 1000000
let g:oscyank_term = 'tmux'

" In visual mode, <leader>c will copy the current selection.
vmap <leader>c <Plug>OSCYankVisual

autocmd TextYankPost *
    \ if v:event.operator is 'y' && v:event.regname is '+' |
    \ execute 'OSCYankRegister +' |
    \ endif


" =============================================================================== "
" Moveing
" =============================================================================== "
nnoremap j gj
nnoremap k gk
imap jj <esc>
" Find merge conflict markers
nnoremap <Leader>mc /\v^[<\|=>]{7}( .*\|$)<CR>

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

let g:netrw_banner=0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/venv/*     " MacOSX/Linux

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

let g:ale_linters_explicit = 1
let b:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_flake8_options = '--ignore=E501,W503,E226,E402' 
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 1

noremap <leader>s = :ALEToggle<CR>

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

"=============================================================================
" Aliases
"=============================================================================

ca tn tabnew
ca te Texp
ca e Exp
ca f Files
