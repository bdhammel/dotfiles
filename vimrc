""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    syntax highlighting,                   "
"                     window preferences,                   "
"                             &                             "
"                    general configuration                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the color encoding for vim
set term=xterm-256color

" load pathogen
execute pathogen#infect()

filetype on
filetype plugin on
filetype plugin indent on

syntax enable
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_args='--ignore=E501,E225'

set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized


" set the backup director for swap files directory
set backupdir=~/.vim_tmp
set swapfile
set directory=~/.vim_tmp

autocmd filetype crontab setlocal nobackup nowritebackup


"Spell Check
set spell
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

"copy and paste - use system clipboard
set clipboard=unnamed

set nowrap
set sidescroll=5

"Enables line numbering
set number

"Don't use vi compatibility
set nocompatible

"set the commend height
set cmdheight=2

"show current vim mode
set showmode

"Show current command
set showcmd

"Allows you to click around the text editor with your mouse to move the cursor
set mouse=a

"This makes the backspace key function like it does in other programs.
set backspace=2

"Draw a red boarder at the limit of 80 characters if using python 
autocmd FileType python set colorcolumn=81

set statusline+=%F\  
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
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

"Turn on modeline for recognizing hydra files
set modeline 
set modelines=3

au BufNewFile,BufRead *.html set filetype=htmldjango

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""    
"                      code completion                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Highlights matching brackets in programming languages
set showmatch

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype '' setlocal nospell

inoremap <C-space> <C-x><C-o>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      bracket completion                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap #    #x<C-h>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      NERD Tree                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd vimenter * NERDTree
autocmd Vimenter * wincmd p
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

map \t :NERDTreeTabsToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       indenting                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"If you're indented, new lines will also be indented
set autoindent

"How much space Vim gives to a tab
set tabstop=4
set shiftwidth=4

"expand tab into spaces
set expandtab

"Improves tabbing
set smarttab

"Set python indentation to google style 
au Filetype python setl et ts=2 sw=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       searching                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Ignore case
set ignorecase

"Try to be smart about case when searching
set smartcase

"search results are highlighted 
set hlsearch
