"================================================"
"                                                "
"                  Vim Config                    "
"    Author: Zane Bilous                         "
"    Last Modified: 05/15/2022                   "
"    Dependencies:                               "
"      ripgrep: for the ack plugin               "
"      fzf: for fzf                              "
"      universal-ctags: for tagbar               "
"      nodejs: for coc.nvim                      "
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
" set relativenumber      " hybrid numbering
set signcolumn=number     " Share the line number column and SignColumn

set cmdheight=2           " use more space for displaying messages
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

" dont store backups and  don't store swapfile in working directory
set nobackup
set nowritebackup
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
set updatetime=300

set shortmess+=c          " don't pass messages to ins-completion-menu

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

" Search
nmap <silent> <leader><space> :nohlsearch<cr>

" Replace
nmap rg :%s/
nmap rl :s/
nmap rw :%s/\<<C-r><C-w>\>/

" Buffers
nnoremap <silent> bd :bdelete<cr>
nnoremap <silent> <Left> :bnext<cr>
nnoremap <silent> <Right> :bprev<cr>

" Tabs
nnoremap <silent> tt :tabnew<cr>
map <silent> tp :tabprevious<cr>
map <silent> tn :tabnext<cr>
map <silent> tq :tabclose<cr>

" Splits
nnoremap <silent> <C-v> :vsp<cr>
nnoremap <silent> <C-h> :sp<cr>

" delete trailing whitespace
nmap <silent> <leader>dw :%s/\s\+$//<cr>:nohlsearch<cr>
" delete ^M
nmap <silent> <leader>dm :%s/^M//g<cr>

" align paragraph
noremap <leader>al =ip

" reformat entire file
nnoremap <leader>fm gg=G``

" move lines with Shift + Up/Down
nnoremap <silent> <S-j> :m+<cr>
nnoremap <silent> <S-k> :m-2<cr>

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
nnoremap <silent> <leader>st <C-w><s-t>gT

" move splits to existing tabs
nnoremap <silent> mt :call MoveToNextTab()<cr>
nnoremap <silent> mT :call MoveToPrevTab()<cr>

" toggle line number type
nnoremap <silent> tln :call ToggleNumber()<cr>

" toggle folding
nnoremap <silent> tf :call ToggleFold()<cr>

" don't unselect after shifting in visual mode
vnoremap < <gv
vnoremap > >gv

" insert blank line with enter
noremap <cr> o<Esc>

" close quickfix window
map <silent> ccl :ccl<cr>

" cycle through location list
nnoremap <silent> <F1> :call LNext(0)<cr>
nnoremap <silent> <F2> :call LNext(1)<cr>

" Plugin Mappings
map <silent> <C-n> :NERDTreeToggle<cr>
map <silent> <leader>cc :TComment<cr>
map <silent> <F5> :TagbarToggle<cr>

" fzf mappings
nnoremap <silent> \ :Rg<cr>
nnoremap <silent> sf :Files<cr>
nnoremap <silent> sb :Buffers<cr>
nnoremap <silent> sl :BLines<cr>
nnoremap <silent> sw :Windows<cr>

" coc mappings

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" make <cr> auto-select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use Ctrl+e to expand snippets
imap <C-e> <Plug>(coc-snippets-expand)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show documentation in preview window
nnoremap <silent> D :call ShowDocumentation()<CR>

" symbol renaming
nnap rn <Plug>(coc-rename)

" apply codeAction to selection
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" apply codeAction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)

" apply AutoFix to problem on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" open the marketplace
nnoremap <silent><nowait> <space>m  :<C-u>CocList marketplace<CR>

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
highlight CocHighlightText ctermfg=None ctermbg=241 guibg=#44475a gui=NONE

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
" Plug 'valloric/youcompleteme', { 'do': './install.py --clangd-completer --ts-completer --rust-completer --java-completer' }
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion
Plug 'sirver/ultisnips' " code snippet framework
Plug 'honza/vim-snippets' " common code snippts
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzyfinder
Plug 'w0rp/ale' " linting and autoformatting
Plug 'tpope/vim-surround' " easily change surrounding brackets, quotes, etc.
Plug 'bronson/vim-trailing-whitespace' " show trailing whitespace as red bg
Plug 'mxw/vim-jsx' " jsx syntax support for react
Plug 'markonm/traces.vim' " live preview for substitution
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
"           coc.nvim             "
"--------------------------------"
let g:coc_global_extensions = ['coc-git', 'coc-html', 'coc-lightbulb', 'coc-marketplace', 'coc-pairs', 'coc-pyright', 'coc-snippets', 'coc-syntax', 'coc-tag', 'coc-tsserver']

" highlight symbol and references when hodling cursor on it
autocmd CursorHold * silent call CocActionAsync('highlight')

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

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

" shows documentation with coc
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
