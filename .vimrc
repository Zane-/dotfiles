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
set ignorecase         " ignore case when searching
set smartcase          " override ignore case if pattern contains uppercase letters
set number             " line numbers
set relativenumber     " hybrid numbering
set tabstop=4          " make tabs 4-spaces wide
set shiftwidth=4       " make indents correspond to one tab
set smartindent        " indent after brackets
set cursorline         " underline current line
set clipboard+=unnamed " use systemwide clipboard
set foldmethod=indent
set foldminlines=5     " number of lines before vim considers a block foldable
set foldlevelstart=99  " don't autofold things unless it has 99 indents
set vb                 " visual bell
set undodir=~/.vim/undodir
set undofile           " persistent undo
set shellpipe=>        " hide ack searches from stdout

"""""""""""""""""""""""""""""""""""
"            Mappings             "
"""""""""""""""""""""""""""""""""""
let mapleader   = "," " remap leader to ,
let g:mapleader = ","
imap jk <Esc>
imap kj <Esc>
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
map <leader>bd :bd<CR>
 " Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C->l
 " Search
nmap <space> /
 " Tabs
nnoremap <C-t> :tabnew<CR>
map <Left> :tabprevious<CR>
map <Right> :tabnext<CR>
map <leader>tc :tabclose<CR>
" delete trailing whitespace
nmap <leader>dw :%s/\s\+$//<CR>
" move lines with Shift + Up/Down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>i
inoremap <S-Down> <Esc>:m+<CR>i
nnoremap <leader>f :call Fold()<CR>
 " Plugins
noremap <leader>cc :TComment<CR>
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
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""
"             CtrlP               "
"""""""""""""""""""""""""""""""""""
let g:ctrlp_show_hidden = 1
" ignore node_modules et al
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

"""""""""""""""""""""""""""""""""""
"              ale                "
"""""""""""""""""""""""""""""""""""
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1

""""""""""""""""""""""""""""""""""
"           Functions            "
""""""""""""""""""""""""""""""""""
function Fold()
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
