"
" PLUGINS IMPORT
""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle management bundle
Bundle 'gmarik/vundle'

Bundle 'The-NERD-Commenter'
Bundle 'vim-airline/vim-airline'
Bundle 'kien/ctrlp.vim'
"Bundle 'ervandew/supertab'
Bundle 'snipMate'
"Bundle 'preservevim/nerdtree'
Bundle 'voldikss/vim-floaterm'

filetype plugin indent on

"
" GLOBALS
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set t_Co=256
colorscheme elflord
set gfn=terminus
set go=

syntax on
set encoding=utf-8
set hidden
set showcmd
set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set shiftround
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak
set title
set visualbell
set noerrorbells
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set ttyfast
set mouse=
set nocompatible
"set backup
"set backupdir=~/.vim_backup
"set noswapfile
set fileformats=unix,dos,mac
set laststatus=2
"set expandtab
set softtabstop=8 tabstop=8 shiftwidth=4
set ruler
set nocompatible

"
" KEYBINDINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map cc <leader>c<space>
map # {v}! par 72<CR>
map & {v}! par 72j<CR>
map <F6> :setlocal spell! spelllang=en<CR>
map <F12> :set invhls<CR>
cmap <C-g> <C-u><ESC>
command! -bang W w<bang>

"
" PLUGINS CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:CommandTMaxFiles = 5000
let g:CommandTMaxHeight = 12

"
" SPECIFIC CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert date.
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
" What's my name?
iab xname Lionel Sambuc

" Acronyme
iab xac (LSU)

" Default printk
iab xpk printk("(LSU) %s:%i:%s ## %s\n", __FILE__, __LINE__, __func__, "msg");

" Enable folding by indentation
" Use: zc, zo, zC, zO, zR, zM
"set foldmethod=indent
"highlight Folded ctermfg=red
"highlight FoldColumn ctermfg=white
"set fillchars=fold:=


