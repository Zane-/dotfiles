set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""
"            Plugins              "
"""""""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree' "filetree
Plugin 'tomtom/tcomment_vim' "comment toggler
Plugin 'easymotion/vim-easymotion' "jump to any word with ease
Plugin 'ctrlpvim/ctrlp.vim' " fuzzyfinder
Plugin 'mileszs/ack.vim' " search files for a pattern recursively
Plugin 'vim-airline/vim-airline' "status line and tab bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes' " a bunch of colorschemes

Plugin 'octol/vim-cpp-enhanced-highlight' "additional cpp syntax support
Plugin 'valloric/youcompleteme' "autocompletion engine, must compile
Plugin 'w0rp/ale' " linting
Plugin 'tpope/vim-surround'
Plugin 'pangloss/vim-javascript' " javascript support
Plugin 'mxw/vim-jsx' " react support
Plugin 'rstacruz/sparkup' "html expander
Plugin 'airblade/vim-gitgutter' "show added/deleted lines in gutter
Plugin 'bronson/vim-trailing-whitespace' "show trailing whitespace as red bg
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""
"         General Config          "
"""""""""""""""""""""""""""""""""""
set hidden                " buffers can be in the bg without having to be saved
set autoread              " autoreload changed files
set nobackup
set noswapfile            " I hate swp files sometimes, use at your own risk

set number                " line numbers
set relativenumber        " hybrid numbering

set cursorline            " underline current line
set nowrap                " don't wrap lines

set hlsearch              " highlight search hits
set ignorecase            " ignore case when searching
set incsearch             " show search hits as you type
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
nnoremap ; :

nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
map <leader>bd :bd<CR>

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
nmap <silent> <leader><space> :nohlsearch<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
map <silent> <Left> :tabprevious<CR>
map <silent> <Right> :tabnext<CR>
map  <leader>tc :tabclose<CR>

" delete trailing whitespace
nmap <silent> <leader>dw :%s/\s\+$//<CR>

" move lines with Shift + Up/Down
nnoremap <silent> <S-Up> :m-2<CR>
nnoremap <silent> <S-Down> :m+<CR>
inoremap <silent> <S-Up> <Esc>:m-2<CR>i
inoremap <silent> <S-Down> <Esc>:m+<CR>i

" toggle line number type
nnoremap <silent> <F3> :call ToggleNumber()<CR>
" toggle folding
nnoremap <silent> <leader>f :call ToggleFold()<CR>

" use w!! to save as sudo
cmap w!! w !sudo tee % >/dev/nulli

" Plugin Mappings
noremap <silent> <leader>cc :TComment<CR>
map <leader>g :Ack! 
" close quickfix window
map <leader>gq :ccl<CR>

"""""""""""""""""""""""""""""""""""
"             Colors              "
"""""""""""""""""""""""""""""""""""
syntax on
"colorscheme Dark
hi Visual ctermfg=NONE ctermbg=241 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi Folded ctermbg=0
hi Search ctermfg=NONE ctermbg=241 cterm=NONE guibg=#44475a gui=NONE

"""""""""""""""""""""""""""""""""""
"            Airline              "
"""""""""""""""""""""""""""""""""""
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""
"          YouCompleteMe          "
"""""""""""""""""""""""""""""""""""
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
set completeopt-=preview
highlight Pmenu ctermbg=0 ctermfg=5

"""""""""""""""""""""""""""""""""""
"            NERDTree             "
"""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""
"             CtrlP               "
"""""""""""""""""""""""""""""""""""
let g:ctrlp_show_hidden = 1
" use ag
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" ignore node_modules et al
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

"""""""""""""""""""""""""""""""""""
"              ale                "
"""""""""""""""""""""""""""""""""""
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1

""""""""""""""""""""""""""""""""""
"              ack               "
""""""""""""""""""""""""""""""""""
if executable('ag')
	let g:ackprg = 'ag --vimgrep -U'
endif

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
