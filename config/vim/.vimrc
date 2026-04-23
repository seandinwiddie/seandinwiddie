source $VIMRUNTIME/defaults.vim

call plug#begin('~/.vim/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'preservim/nerdtree'
call plug#end()

"if  has( 'mouse' )
"  set mouse=a
"endif

set encoding=utf-8
"set fileencoding=utf-8

"set dg

"syntax enable
syntax on
"set syntax=whitespace
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set listchars=nbsp:☠,tab:▸␣

set autoindent
set expandtab
set shiftwidth=2

set nu
set cursorline

cd ~/documents/github
autocmd VimEnter * NERDTree | wincmd p

set termguicolors     " enable true colors support
let ayucolor="mirage" " for mirage version of theme
colorscheme ayu

set guifont=Dank\ Mono:h15

"if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
"  set lines=999 columns=999
"else
  " This is console Vim.
"  if exists("+lines")
    set lines=25
"  endif
"  if exists("+columns")
    set columns=110
"  endif
"endif

" IndentLine {{
"let g:indentLine_char = ''
"let g:indentLine_first_char = ''
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

"let g:airline_powerline_fonts = 1
let g:airline_theme='dark'


