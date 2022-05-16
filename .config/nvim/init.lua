--================================================
--                 Neovim Config
--    Author: Zane Bilous
--    Last Modified: 05/15/2022
--    Dependencies:
--      ripgrep: for the ack plugin
--      fzf: for fzf
--      universal-ctags: for tagbar
--      nodejs: for coc.nvim
--================================================

----------------------------------
--           Aliases
----------------------------------
local bo = vim.bo    -- buffer local
local cmd = vim.cmd  -- vim commands
local fn = vim.fn    -- access vim functions
local g  = vim.g     -- global for let options
local opt  = vim.opt -- global
local wo = vim.wo    -- window local

----------------------------------
--           Options
----------------------------------
opt.encoding = 'utf8'               -- set utf8 as standard encoding
opt.hidden = true                   -- buffers can be in the bg without having to be saved
opt.autoread = true                 -- autoreload changed files
opt.mouse = 'nicr'                  -- use mouse for scrolling and clicking
opt.number = true                   -- line numbers
opt.cmdheight = 2                   -- use more space for displaying messages
opt.scrolloff = 15                  -- keep 15 lines above/below cursor line
opt.linebreak = true                -- break lines
opt.hlsearch = true                 -- highlight search hits
opt.incsearch = true                -- show search hits as you type
opt.ignorecase = true               -- ignore case when searching
opt.smartcase = true                -- override ignore case if uppercase letters in pattern
opt.tabstop = 4                     -- make tabs 4-spaces wide
opt.shiftwidth = 4                  -- make indents correspond to one tab
opt.smartindent = true              -- indent after brackets
opt.splitbelow = true               -- split splits below
opt.splitright = true               -- vertical split splits right
opt.foldmethod = 'indent'
opt.foldminlines = 5                -- min num of lines before a block is foldable
opt.foldlevelstart = 12             -- don't autofold unless there are 12 indents
opt.directory = '~/.vim/swapfiles'  -- store swapfiles elsewhere
opt.undodir = '~/.vim/nvim-undodir' -- store undodir elsewhere
opt.undofile = true                 -- persistent undo
opt.undolevels = 1000               -- keep lots of undo history
opt.pastetoggle = '<F3>'            -- switch to paste mode to paste easily
opt.clipboard = 'unnamed'           -- use system clipboard
opt.shellpipe = '>'                 -- hide ack searches from stdout
opt.re = 1                          -- use old regex engine (faster)
opt.ttyfast = true                  -- optimizations
opt.lazyredraw = true
opt.updatetime = 300
opt.visualbell = true               -- use visual bell

----------------------------------
--            Mappings
----------------------------------
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function bufnr_map(bufnr, mode, shortcut, command)
  vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function nmap_buf(bufnr, shortcut, command)
  bufnr_map(bufnr, 'n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

g.mapleader = ','                        -- remap leader to ,
imap('jk', '<Esc>')                      -- easy normal mode
nmap(';', ':')                           -- easy command input
nmap('/', '/\v')                         -- Use Perl-compatible regular expressions for searching
vmap('/', '/\v')
nmap('<leader>w', ':w!<cr>')             -- Quick Save/Quit
nmap('<leader>wq', ':wq!<cr>')
nmap('<leader>q', ':q<cr>')
nmap('<leader>qq', ':q!<cr>')
nmap('B', '^')                           -- Line navigation
nmap('E', '$')
nmap('j', 'gj')                          -- move up and down by display rather than line number
nmap('k', 'gk')
nmap('<leader><space>',
     ':nohlsearch<cr>')                  -- Turn off search highlight
nmap('rg', ':%s/')                       -- Replace
nmap('rl', ':s/')
nmap('rw', ':%s/\\<<C-r><C-w>\\>/')
nmap('bd', ':bdelete<cr>')               -- Buffers
nmap('<Left>', ':bnext<cr>')
nmap('<Right>', ':bprev<cr>')
nmap('tt', ':tabnew<cr>')                -- Tabs
nmap('tp', ':tabprevious<cr>')
nmap('tn', ':tabnext<cr>')
nmap('tq', ':tabclose<cr>')
nmap('<C-v>', ':vsp<cr>')                -- Splits
nmap('<C-x>', ':sp<cr>')
nmap('<leader>dw',
     ':%s/\\s\\+$//<cr>:nohlsearch<cr>') -- delete trailing whitespace
nmap('<leader>dm', ':%s/^M//g<cr>')      -- delete ^M
nmap('<Down>', ':m+<cr>')                -- move lines with Up/Down
nmap('<Up>', ':m-2<cr>')
nmap('Q', '@q')                          -- use macros with Q (and in visual mode)
vmap('Q', ':norm @q<cr>')
vmap('<', '<gv')                         -- don't unselect after shifting in visual mode
vmap('>', '>gv')
nmap('<cr>', 'o<Esc>')                   -- insert blank line with enter
nmap('qw', ':ccl<cr>')                   -- close quickfix window

-- Plugin Mappings
nmap('<C-n>', ':NvimTreeToggle<cr>')     -- toggle nvim-tree
nmap('<F5>', ':TagbarToggle<cr>')        -- toggle tagbar

nmap('\\', ':Telescope live_grep<cr>')   -- Telescope mappings
nmap('ff', ':Telescope find_files<cr>')
nmap('fb', ':Telescope buffers<cr>')
nmap('fl',
    ':lua require("telescope.builtin").live_grep({grep_open_files=true})<cr>')

nmap('bp', ':BufferPick<cr>')            -- barbar mappings
nmap('<S-Left>', ':BufferMovePrevious<cr>')
nmap('<S-Right>', ':BufferMoveNext<cr>')

nmap('<A-t>',                            -- toggle terminal
     '<cmd>lua require("FTerm").toggle()<cr>')
map('t', '<A-t>',
     '<cmd>lua require("FTerm").toggle()<cr>')

-- LSP mappings
nmap('<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
nmap('<F1>', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
nmap('<F2>', '<cmd>lua vim.diagnostic.goto_next()<cr>')
nmap('<space>q', '<cmd>lua vim.diagnostic.setloclist()<cr>')

-- ensure <cr> isn't remapped during cmd enter and quickfix
vim.cmd([[
augroup cr
	autocmd!
	autocmd CmdwinEnter * nnoremap <cr> <cr>
	autocmd BufReadPost quickfix nnoremap <cr> <cr>
augroup end
]])

-----------------------------------
--            Plugins
-----------------------------------

require('packer').startup(function()
  use 'wbthomason/packer.nvim'            -- this package manager

  use 'bronson/vim-trailing-whitespace'   -- show trailing whitespace as red bg
  use 'easymotion/vim-easymotion'         -- jump to any word with ease
  use 'folke/tokyonight.nvim'             -- colorscheme
  use 'glepnir/dashboard-nvim'            -- fancy start page
  use 'honza/vim-snippets'                -- common code snippts
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'              -- completion stuff
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'kosayoda/nvim-lightbulb'           -- show a lightbulb for code actions
  use 'ludovicchabant/vim-gutentags'      -- auto-generates tags
  use 'majutsushi/tagbar'                 -- easy browsing of tags
  use 'markonm/traces.vim'                -- live preview for substitution
  use 'mxw/vim-jsx'                       -- jsx syntax support for react
  use 'neovim/nvim-lspconfig'             -- completion, go-to, etc.
  use 'numToStr/Comment.nvim'             -- comments
  use 'numToStr/FTerm.nvim'               -- terminal popup
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lualine/lualine.nvim'         -- status line
  use 'nvim-telescope/telescope.nvim'     -- aesthetic fuzzyfinder
  use 'nvim-treesitter/nvim-treesitter'   -- additional syntax highlighting
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use "oberblastmeister/neuron.nvim"
  use 'olimorris/onedarkpro.nvim'
  use 'stevearc/dressing.nvim'            -- use telescope for more things
  use {
	  'ray-x/navigator.lua',              -- combine LSP and treesitter
	  requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
  }
  use 'roxma/vim-paste-easy'              -- auto-enter paste mode on paste
  use 'RRethy/vim-illuminate'             -- highlight symbol under cursor
  use 'ryanoasis/vim-devicons'            -- add icons to files
  use 'kyazdani42/nvim-tree.lua'          -- filetree
  use 'sirver/ultisnips'                  -- code snippet framework
  use 'tpope/vim-surround'                -- easily change surrounding brackets, quotes, etc.
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use {
    'romgrk/barbar.nvim',                 -- fancy tabs
    requires = {{'kyazdani42/nvim-web-devicons'}}
  }
  use 'weilbith/nvim-code-action-menu'    -- show diffs for code actions
end)

----------------------------------
--             Colors
----------------------------------
cmd([[
colorscheme tokyonight
set background=dark

highlight Visual ctermfg=NONE ctermbg=241 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
highlight Folded ctermbg=0
highlight Search ctermfg=NONE ctermbg=241 cterm=NONE guibg=#44475a gui=NONE
highlight CursorLine term=bold cterm=bold guibg=Grey40
highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=yellow gui=bold
highlight MatchParen ctermfg=46 ctermbg=241 cterm=NONE
highlight Pmenu ctermbg=0 ctermfg=3

highlight! link SignColumn LineNr
highlight CocHighlightText ctermfg=None ctermbg=241 guibg=#44475a gui=NONE

autocmd ColorScheme * highlight! link SignColumn LineNr

augroup cursor_behaviour
    autocmd!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
augroup END
]])

-- ----------------------------------'
-- --      Compilation/Execution     '
-- ----------------------------------'
-- augroup exe
-- 	-- C
-- 	autocmd filetype c nnoremap <F4> :w<cr> :!clang *.c && ./a.out<cr>
-- 	autocmd filetype c inoremap <F4> <Esc> :w<cr> :!clang *.c && ./a.out<cr>
-- 	-- C++
-- 	autocmd filetype cpp nnoremap <F4> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>
-- 	autocmd filetype cpp inoremap <F4> <Esc> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>
-- 	-- Java
-- 	autocmd filetype java nnoremap <F4> :w<cr> :!javac %<cr>
-- 	autocmd filetype java inoremap <F4> <Esc> :w<cr> :!javac %<cr>
-- 	-- Rust
-- 	autocmd filetype rust nnoremap <F4> :w<cr> :!rustc % && ./%:r
-- 	autocmd filetype rust inoremap <F4> <Esc> :w<cr> :!rustc % && ./%:r
-- 	-- Python
-- 	autocmd filetype python nnoremap <F4> :w<cr> :!python %<cr>
-- 	autocmd filetype python inoremap <F4> <Esc> :w<cr> :!python %<cr>
-- 	-- Ruby
-- 	autocmd filetype ruby nnoremap <F4> :w<cr> :!ruby %<cr>
-- 	autocmd filetype ruby inoremap <F4> <Esc> :w<cr> :!ruby %<cr>
-- augroup end

--================================================
--                 Plugin Config
--================================================

----------------------------------
--           Comment
----------------------------------
require('Comment').setup()

----------------------------------
--          Dashboard
----------------------------------
g.dashboard_default_executive = 'telescope'

----------------------------------
--             LSP
----------------------------------
require('navigator').setup({
  on_attach = function(client, bufnr)
    require('illuminate').on_attach(client)
    nmap_buf(bufnr, 'ca', '<cmd>CodeActionMenu<cr>')
  end,

  lsp = {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    -- servers = { 'clangd', 'pyright', 'rust_analyzer', 'tsserver' },
  },
})

----------------------------------
--           Lualine
----------------------------------
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'N/A'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

lualine.setup(config)

----------------------------------
--           neuron
----------------------------------
require('neuron').setup()

----------------------------------
--          nvim-tree
----------------------------------
require('nvim-tree').setup()

----------------------------------
--            nvim-cmp
----------------------------------
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
	vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
  },
  window = {
	  completion = cmp.config.window.bordered(),
	  documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
	['<Tab>'] = cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
									return
								end
								fallback()
							end
	, { 'i', 'c' }),

	['<S-Tab>'] = cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
									return
								end
								fallback()
							end
	, { 'i', 'c' }),
    ['<cr>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
  { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

----------------------------------
--        nvim-treesitter
----------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'javascript', 'python', 'rust' },

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    lsp_interop = {
      enable = true,
	  border = 'single',
      peek_definition_code = {
        ['pf'] = '@function.outer',
        ['pc'] = '@class.outer',
      },
    },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}

----------------------------------
--           Startify
----------------------------------
cmd([[
let g:startify_custom_header = [
\ '   ___      ___ ___  _____ ______',
\ '  |\  \    /  /|\  \|\   _ \  _   \ ',
\ '  \ \  \  /  / | \  \ \  \\\__\ \  \ ',
\ '   \ \  \/  / / \ \  \ \  \\|__| \  \ ',
\ '    \ \    / /   \ \  \ \  \    \ \  \',
\ '     \ \__/ /     \ \__\ \__\    \ \__\',
\ '      \|__|/       \|__|\|__|     \|__|',
\ ]
]])

----------------------------------
--             Tagbar
----------------------------------
g.tagbar_left = 1
g.tagbar_autofocus = 1
g.tagbar_width = 25
g.tagbar_compact = 1
cmd('let g:tagbar_iconchars = ["▸", "▾"]')

----------------------------------
--           ultisnips
----------------------------------
g.UltiSnipsExpandTrigger= '<c-e>'
