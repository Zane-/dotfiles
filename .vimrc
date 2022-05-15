"================================================"
"                                                "
"                  Vim Config                    "
"    Author: Zane Bilous                         "
"    Last Modified: 05/05/2022                   "
"    Dependencies:                               "
"      ripgrep: for the ack plugin               "
"      fzf: for fzf                              "
"      universal-ctags: for tagbar               "
"      bunch of other stuff for build tools      "
"================================================"

"--------------------------------"
"         General Config         "
"--------------------------------"
filetype plugin indent on
set encoding=utf8         " set utf8 as standard encoding
set hidden                " buffers can be in the bg without having to be saved
set autoread              " autoreload changed files

set mouse=nicr            " use mouse for scrolling and clicking

set number                " line numbers
set numberwidth=1
" set relativenumber        " hybrid numbering
set signcolumn=number     " Share the line number column and SignColumn

set scrolloff=15          " keep 15 lines above/below cursor line
set cursorline            " underline current line
set linebreak             " break lines
" show ↪ on wrapped lines
let &showbreak=nr2char(8618).' '

set hlsearch              " highlight search hits
set incsearch             " show search hits as you type
set ignorecase            " ignore case when searching
set smartcase             " override ignore case if uppercase letters in pattern

set tabstop=4             " make tabs 4-spaces wide
set shiftwidth=4          " make indents correspond to one tab
set smartindent           " indent after brackets

set splitbelow            " split splits below
set splitright            " vertical split splits right

set foldmethod=indent
set foldminlines=5        " min num of lines before a block is foldable
set foldlevelstart=12     " don't autofold unless there are 12 indents

" dont store backups and swapfile in working directory
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swapfiles
set undodir=~/.vim/undodir
set undofile              " persistent undo
set undolevels=1000       " keep lots of undo history

set pastetoggle=<F3>      " switch to paste mode to paste easily
set clipboard=unnamed     " use system clipboard

set shellpipe=>           " hide ack searches from stdout

set re=1                  " use old regex engine (faster)
set ttyfast               " optimizations
set lazyredraw

set visualbell            " visual bell

"--------------------------------"
"            Mappings            "
"--------------------------------"
let mapleader   = "," " remap leader to ,
let g:mapleader = ","
" easy normal mode
imap jk <Esc>
" easy command input
nnoremap ; :

" Use Perl-compatible regular expressions for searching
nnoremap / /\v
vnoremap / /\v

" Disable navigation with up/down
nmap <Up> <nop>
nmap <Down> <nop>

" Quick Save/Quit
nmap <leader>w :w!<cr>
nmap <leader>wq :wq!<cr>
nmap <leader>q :q<cr>
nmap <leader>qq :q!<cr>
" use w!! to save as sudo
cmap w!! w !sudo tee >/dev/null %

" Line navigation
nnoremap B ^
nnoremap E $
" move up and down by display rather than line number
nnoremap j gj
nnoremap k gk

" Window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Search
nmap <space> /
nmap <silent> <leader><space> :nohlsearch<cr>

" Replace
nmap rg :%s/
nmap rl :s/
nmap rw :%s/\<<C-r><C-w>\>/

" Buffers
nnoremap <silent> bd :bdelete<cr>
nnoremap <silent> bn :bnext<cr>
nnoremap <silent> bp :bprev<cr>

" Tabs
nnoremap <silent> tn :tabnew<cr>
map <silent> <Left> :tabprevious<cr>
map <silent> <Right> :tabnext<cr>
map <silent> tq :tabclose<cr>

" vertical split
nnoremap <silent> <C-v> :vsp<cr>

" delete trailing whitespace
nmap <silent> <leader>dw :%s/\s\+$//<cr>:nohlsearch<cr>
" delete ^M
nmap <silent> <leader>dm :%s/^M//g<cr>

" align paragraph
noremap <leader>al =ip

" reformat entire file
nnoremap <leader>fm gg=G``

" move lines with Shift + Up/Down
nnoremap <silent> <S-k> :m-2<cr>
nnoremap <silent> <S-j> :m+<cr>

" ensure <cr> isn't remapped during cmd enter and quickfix
augroup cr
	autocmd!
	autocmd CmdwinEnter * nnoremap <cr> <cr>
	autocmd BufReadPost quickfix nnoremap <cr> <cr>
augroup end

" insert timestamp
nnoremap <silent> <leader>ts :put =strftime(\"%d %b %Y, %H:%M:%S %z\")<cr>

" use macros with Q (and in visual mode)
nnoremap Q @q
vnoremap Q :norm @q<cr>

" move split to new tab
nnoremap <silent> st <C-w><s-t>gT

" move tabs to splits
nnoremap <silent> mt :call MoveToNextTab()<cr>
nnoremap <silent> mT :call MoveToPrevTab()<cr>

" toggle line number type
nnoremap <silent> tln :call ToggleNumber()<cr>

" toggle folding
nnoremap <silent> tf :call ToggleFold()<cr>

" don't unselect after shifting in visual mode
vnoremap < <gv
vnoremap > >gv

" insert blank line with enter and shift+enter
noremap <cr> o<Esc>
nmap <S-Enter> O<Esc>
nmap <cr> o<Esc>

" close quickfix window
map <silent> <leader>gq :ccl<cr>

" cycle through location list
nnoremap <silent> <F1> :call LNext(0)<cr>
nnoremap <silent> <F2> :call LNext(1)<cr>

" generate tags for directory
nmap <silent> <leader>ct :!ctags *<cr>

" copy component template into current file at cursor
nnoremap <silent> <leader>rnc :read ~/dotfiles/templates/component.js<cr>

" Plugin Mappings
map <silent> <C-n> :NERDTreeToggle<cr>
map <silent> <leader>cc :TComment<cr>
map <leader>gf :Ack! 
map <silent> <leader>gg :GitGutterToggle<cr>
map <silent> <leader>ll :LLPStartPreview<cr>
map <silent> <F5> :TagbarToggle<cr>
nnoremap <silent> \ :Rg<cr>
nnoremap <silent> <C-f> :Files<cr>
nnoremap <silent> <C-b> :Buffers<cr>
nnoremap <silent> <C-s> :BLines<cr>
nnoremap <silent> <C-l> :Windows<cr>

"--------------------------------"
"             Colors             "
"--------------------------------"
syntax on
highlight Visual ctermfg=NONE ctermbg=241 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
highlight Folded ctermbg=0
highlight Search ctermfg=NONE ctermbg=241 cterm=NONE guibg=#44475a gui=NONE
highlight CursorLine term=bold cterm=bold guibg=Grey40
highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=yellow gui=bold
highlight MatchParen ctermfg=46 ctermbg=241 cterm=NONE
highlight Pmenu ctermbg=0 ctermfg=5

highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr

augroup cursor_behaviour
    autocmd!
    " reset cursor on start:
    autocmd VimEnter * silent !echo -ne "\e[2 q"
    " cursor blinking bar on insert mode
    let &t_SI = "\e[5 q"
    " cursor steady block on command mode
    let &t_EI = "\e[2 q"

augroup END

"--------------------------------"
"      Compilation/Execution     "
"--------------------------------"
augroup exe
	" C
	autocmd filetype c nnoremap <F4> :w<cr> :!clang *.c && ./a.out<cr>
	autocmd filetype c inoremap <F4> <Esc> :w<cr> :!clang *.c && ./a.out<cr>
	" C++
	autocmd filetype cpp nnoremap <F4> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>
	autocmd filetype cpp inoremap <F4> <Esc> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>
	" Java
	autocmd filetype java nnoremap <F4> :w<cr> :!javac %<cr>
	autocmd filetype java inoremap <F4> <Esc> :w<cr> :!javac %<cr>
	" Rust
	autocmd filetype rust nnoremap <F4> :w<cr> :!rustc % && ./%:r
	autocmd filetype rust inoremap <F4> <Esc> :w<cr> :!rustc % && ./%:r
	" Python
	autocmd filetype python nnoremap <F4> :w<cr> :!python %<cr>
	autocmd filetype python inoremap <F4> <Esc> :w<cr> :!python %<cr>
	" Ruby
	autocmd filetype ruby nnoremap <F4> :w<cr> :!ruby %<cr>
	autocmd filetype ruby inoremap <F4> <Esc> :w<cr> :!ruby %<cr>
augroup end

"---------------------------------"
"            Plugins              "
"---------------------------------"
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify' " fancy start page
Plug 'scrooloose/nerdtree' " filetree
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'} " easy browsing of tags
Plug 'ludovicchabant/vim-gutentags' " auto-generates tags
Plug 'mileszs/ack.vim' " search files for a pattern recursively
Plug 'easymotion/vim-easymotion' " jump to any word with ease
Plug 'tomtom/tcomment_vim' " comment toggler
Plug 'vim-airline/vim-airline' " status line and tab bar
Plug 'vim-airline/vim-airline-themes' " themes for airline
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'valloric/youcompleteme', { 'do': './install.py --clangd-completer --ts-completer --rust-completer --java-completer' }
Plug 'sirver/ultisnips' " code snippet framework
Plug 'honza/vim-snippets' " common code snippts
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzyfinder
Plug 'ervandew/supertab' " tab for omnicompletion
Plug 'w0rp/ale' " linting and autoformatting
Plug 'jiangmiao/auto-pairs' " automatically insert matching pair ([{ etc
Plug 'tpope/vim-surround' " easily change surrounding brackets, quotes, etc.
Plug 'alvan/vim-closetag' " auto close tags for html and jsx
Plug 'bronson/vim-trailing-whitespace' " show trailing whitespace as red bg
Plug 'airblade/vim-gitgutter' " show added/deleted lines in gutter
Plug 'octol/vim-cpp-enhanced-highlight' " additional cpp syntax support
Plug 'pangloss/vim-javascript' " javascript syntax support
Plug 'mxw/vim-jsx' " jsx syntax support for react
Plug 'markonm/traces.vim' " live preview for substitution
Plug 'kana/vim-textobj-function' " targets functions
Plug 'kana/vim-textobj-user' " dependency for above
Plug 'roxma/vim-paste-easy' " auto-enter paste mode on paste

call plug#end()

"================================================"
"                 Plugin Config                  "
"================================================"

"--------------------------------"
"              ack               "
"--------------------------------"
if executable('rg')
	let g:ackprg = 'rg --vimgrep -U'
endif

"--------------------------------"
"            Airline             "
"--------------------------------"
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"--------------------------------"
"              ale               "
"--------------------------------"
let g:ale_fixers = {'javascript': ['eslint'], 'python': ['yapf'], 'c': ['clang-format'], 'cpp': ['clang-format']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
highlight ALEError ctermbg=none cterm=bold
highlight ALEErrorLine ctermbg=none cterm=bold
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEStyleError ctermbg=none cterm=bold
highlight ALEStyleWarning ctermbg=none cterm=bold
highlight ALEWarning ctermbg=none cterm=bold
highlight ALEWarningLine ctermbg=none cterm=bold
highlight ALEWarningSign ctermbg=none ctermfg=yellow

"--------------------------------"
"            Closetag            "
"--------------------------------"
let g:closetag_filenames = '*.html, *.js'

"--------------------------------"
"           gitgutter            "
"--------------------------------"
" disable on startup because it slows vim down
let g:gitgutter_enabled = 0

"--------------------------------"
"            NERDTree            "
"--------------------------------"
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenVSplit = '<C-v>'

"--------------------------------"
"            Rainbow             "
"--------------------------------"
let g:rainbow_active = 1

"--------------------------------"
"           Startify             "
"--------------------------------"
let g:startify_custom_header = [
\ '   ___      ___ ___  _____ ______',
\ '  |\  \    /  /|\  \|\   _ \  _   \ ',
\ '  \ \  \  /  / | \  \ \  \\\__\ \  \ ',
\ '   \ \  \/  / / \ \  \ \  \\|__| \  \ ',
\ '    \ \    / /   \ \  \ \  \    \ \  \',
\ '     \ \__/ /     \ \__\ \__\    \ \__\',
\ '      \|__|/       \|__|\|__|     \|__|',
\ ]

"--------------------------------"
"             Tagbar             "
"--------------------------------"
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_width = 25
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']

"--------------------------------"
"           ultisnips            "
"--------------------------------"
let g:UltiSnipsExpandTrigger="<c-e>"

"--------------------------------"
"         YouCompleteMe          "
"--------------------------------"
let g:ycm_min_num_of_chars_for_completion = 2

"--------------------------------"
"           Functions            "
"--------------------------------"
" Toggles folding
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

" Toggles hybrid numbering
function ToggleNumber()
	if (&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunction

" Cycle through location lists
function LNext(prev)
	try
		try
			if a:prev | lprev | else | lnext | endif
		catch /^Vim\%((\a\+)\)\=:E553/
			if a:prev | llast | else | lfirst | endif
		catch /^Vim\%((\a\+)\)\=:E776/
		endtry
	catch /^Vim\%((\a\+)\)\=:E42/
	endtry
endfunction

" Moves the current tab to a split in the previous tab
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

" Moves the current tab to a split in the next tab
function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
