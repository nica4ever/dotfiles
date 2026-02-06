"Basic defaults
set nocompatible
syntax on
filetype plugin indent on

" Display
set number
set ruler
set showcmd
set wildmenu

" Search
set incsearch
set hlsearch

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" Auto completion
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Behavior
set backspace=indent,eol,start
set encoding=utf-8

" Netrw
set hidden

" Plug
call plug#begin()

" List your plugins here
Plug 'ghifarit53/tokyonight-vim'
Plug 'nordtheme/vim'
call plug#end()

" I am not sure if its a problem with my setup or vim in general
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "[38;2;%lu;%lu;%lum"
  let &t_8b = "[48;2;%lu;%lu;%lum"
endif
set termguicolors
hi! Normal ctermbg=NONE guibg=NONE
hi! Normal ctermbg=NONE guibg=NONE
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
colorscheme tokyonight

" Highlight comments
highlight Comment guifg=#808080

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
