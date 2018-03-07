"================================================"
"                  Vim Config                    "
"              author: Zane Bilous               "
"           Last Modified: 03/07/2018            "
"                 Dependencies                   "
"      silverserver-ag: for the ack plugin       "
"      exuberant-ctags: for easytags plugin      "
"================================================"

"""""""""""""""""""""""""""""""""""
"            Plugins              "
"""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify' " fancy start page
Plug 'scrooloose/nerdtree' " filetree
Plug 'tomtom/tcomment_vim' " comment toggler
Plug 'easymotion/vim-easymotion' " jump to any word with ease
Plug 'ctrlpvim/ctrlp.vim' " fuzzyfinder
Plug 'mileszs/ack.vim' " search files for a pattern recursively
Plug 'vim-airline/vim-airline' "status line and tab bar
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes' " a bunch of colorschemes

" build and install autocompleter
"Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }
Plug 'ervandew/supertab' " tab for omnicompletion
Plug 'w0rp/ale' " linting
Plug 'xolox/vim-misc' " dependency for vim-easytags
Plug 'xolox/vim-easytags' " easy tag generation for jumping to definitions
Plug 'tpope/vim-surround' " easily change surrounding brackets, quotes, etc.
Plug 'octol/vim-cpp-enhanced-highlight' "additional cpp syntax support
Plug 'pangloss/vim-javascript' " javascript syntax support
Plug 'mxw/vim-jsx' " jsx syntax support for react
Plug 'rstacruz/sparkup' "html expander
Plug 'airblade/vim-gitgutter' "show added/deleted lines in gutter
Plug 'bronson/vim-trailing-whitespace' "show trailing whitespace as red bg

call plug#end()

"""""""""""""""""""""""""""""""""""
"         General Config          "
"""""""""""""""""""""""""""""""""""
filetype plugin indent on
set hidden                " buffers can be in the bg without having to be saved
set autoread              " autoreload changed files
set nobackup
set noswapfile            " I hate swp files sometimes, use at your own risk

set number                " line numbers
set relativenumber        " hybrid numbering

set cursorline            " underline current line
set nowrap                " don't wrap lines

set hlsearch              " highlight search hits
set incsearch             " show search hits as you type
set ignorecase            " ignore case when searching
set smartcase             " override ignore case if uppercase letters in pattern

set tabstop=4             " make tabs 4-spaces wide
set shiftwidth=4          " make indents correspond to one tab
set smartindent           " indent after brackets

set foldmethod=indent
set foldminlines=5        " min num of lines before a block is foldable
set foldlevelstart=12     " don't autofold unless there are 12 indents

set undodir=~/.vim/undodir
set undofile              " persistent undo

set pastetoggle=<F2>      " switch to paste mode to paste easily
set clipboard=unnamedplus " use system clipboard

set shellpipe=>           " hide ack searches from stdout

set visualbell            " visual bell

"""""""""""""""""""""""""""""""""""
"            Mappings             "
"""""""""""""""""""""""""""""""""""
let mapleader   = "," " remap leader to ,
let g:mapleader = ","
imap jk <Esc>
imap kj <Esc>
" easy command input
nnoremap ; :

" Disable navigation with up/down
nmap <Up> <nop>
nmap <Down> <nop>

" Quick Save/Quit
nmap <leader>w :w!<cr>
nmap <leader>wq :wq!<cr>
nmap <leader>q :q<cr>
nmap <leader>qq :q!<cr>

" Buffer navigation
map <leader>bd :bd<cr>
map <leader>bn :bn<cr>
map <leader>bb :bb<cr>

" Line navigation
nnoremap B ^
nnoremap E $

" Window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Search
nmap <space> /
nmap <silent> <leader><space> :nohlsearch<cr>

" Tabs
nnoremap <C-t> :tabnew<cr>
map <silent> <Left> :tabprevious<cr>
map <silent> <Right> :tabnext<cr>
map  <leader>tc :tabclose<cr>

" delete trailing whitespace
nmap <silent> <leader>dw :%s/\s\+$//<cr>

" move lines with Shift + Up/Down
nnoremap <silent> <S-Up> :m-2<cr>
nnoremap <silent> <S-Down> :m+<cr>
inoremap <silent> <S-Up> <Esc>:m-2<cr>i
inoremap <silent> <S-Down> <Esc>:m+<cr>i

" toggle line number type
nnoremap <silent> <F3> :call ToggleNumber()<cr>

" toggle folding
nnoremap <silent> <leader>f :call ToggleFold()<cr>

" use w!! to save as sudo
cmap w!! w !sudo tee % >/dev/nulli

" shifting in visual mode doesn't unselect
vnoremap < <gv
vnoremap > >gv

" copy component template into current file at cursor
nnoremap <silent> <leader>rnc :read ~/dotfiles/templates/component.js<cr>

" Plugin Mappings
noremap <silent> <leader>cc :TComment<cr>
map <leader>g :Ack! 
" close quickfix window
map <silent> <leader>gq :ccl<cr>

"""""""""""""""""""""""""""""""""""
"             Colors              "
"""""""""""""""""""""""""""""""""""
syntax on
"colorscheme Dark
hi Visual ctermfg=NONE ctermbg=241 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi Folded ctermbg=0
hi Search ctermfg=NONE ctermbg=241 cterm=NONE guibg=#44475a gui=NONE

"""""""""""""""""""""""""""""""""""
"      Compilation/Execution      "
"""""""""""""""""""""""""""""""""""
" C++
autocmd filetype cpp nnoremap <F4> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>
" Java
autocmd filetype java nnoremap <F4> :w<cr> :!javac %<cr>
" Rust
autocmd filetype rust nnoremap <F4> :w<cr> :!rustc % && ./%:r
" Python
autocmd filetype python nnoremap <F4> :w<cr> :!python %<cr>
" Ruby
autocmd filetype ruby nnoremap <F4> :w<cr> :!ruby %<cr>

"================================================"
"                 Plugin Config                  "
"================================================"

""""""""""""""""""""""""""""""""""
"              ack               "
""""""""""""""""""""""""""""""""""
if executable('ag')
	let g:ackprg = 'ag --vimgrep -U'
endif

"""""""""""""""""""""""""""""""""""
"            Airline              "
"""""""""""""""""""""""""""""""""""
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""
"              ale                "
"""""""""""""""""""""""""""""""""""
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1

"""""""""""""""""""""""""""""""""""
"             CtrlP               "
"""""""""""""""""""""""""""""""""""
let g:ctrlp_show_hidden = 1
" use ag
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" ignore node_modules et al
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

""""""""""""""""""""""""""""""""""
"           easytags             "
""""""""""""""""""""""""""""""""""
" store tags per project, do not use global
set tags=./tags;
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_include_members = 1
let g:easytags_events = ['BufWritePost']

"""""""""""""""""""""""""""""""""""
"            NERDTree             "
"""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
" start NERDTree if vim is opened with no arguments
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <C-n> :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""
"           Startify             "
""""""""""""""""""""""""""""""""""
let g:startify_custom_header = [
\ '             ___      ___ ___  _____ ______',
\ '            |\  \    /  /|\  \|\   _ \  _   \ ',
\ '            \ \  \  /  / | \  \ \  \\\__\ \  \ ',
\ '             \ \  \/  / / \ \  \ \  \\|__| \  \ ',
\ '              \ \    / /   \ \  \ \  \    \ \  \',
\ '               \ \__/ /     \ \__\ \__\    \ \__\',
\ '                \|__|/       \|__|\|__|     \|__|',
\ ]

"""""""""""""""""""""""""""""""""""
"          YouCompleteMe          "
"""""""""""""""""""""""""""""""""""
" let g:ycm_server_python_interpreter = '/usr/bin/python'
" let g:ycm_python_binary_path = '/usr/bin/python3'
" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" set completeopt-=preview
" highlight Pmenu ctermbg=0 ctermfg=5

""""""""""""""""""""""""""""""""""
"           Functions            "
""""""""""""""""""""""""""""""""""
function ToggleFold()
	if foldlevel('.') == 0
		normal! 1
	else
		if foldclosed('.') < 0
			. foldclose
		else
			. foldopen
		endif
	endif
	echo
endfunction

function ToggleNumber()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
