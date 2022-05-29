--================================
--         Neovim Config
--
-- Author: Zane B.
-- Last Modified: 05/29/2022
-- Dependencies:
--   fzf, ripgrep
--================================

----------------------------------
--           Aliases
----------------------------------
local autocmd = vim.api.nvim_create_autocmd
local cmd     = vim.cmd
local fn      = vim.fn
local g       = vim.g
local hi      = vim.highlight.create
local opt     = vim.opt

----------------------------------
--           Colors
----------------------------------
g.catppuccin_flavor = 'mocha' -- latte, frappe, macchiato, mocha
cmd [[ colorscheme catppuccin ]]

local colors = require('catppuccin.api.colors').get_colors()

-- Highlights for DAP gutter symbols
hi('DapBreakpoint', { ctermbg = 0, guifg = colors.red, guibg = colors.mantle, }, false)
hi('DapLogPoint', { ctermbg = 0, guifg = colors.blue, guibg = colors.mantle, }, false)
hi('DapStopped', { ctermbg = 0, guifg = colors.green, guibg = colors.mantle, }, false)

-- Highlights for SymbolsOutline preview popup
hi('Pmenu', { ctermbg = 0, guifg = colors.text, guibg = colors.mantle, }, false)

-- Highlights for Sniprun
hi('SniprunVirtualTextOk', { ctermbg = 0, guifg = colors.blue, guibg = colors.mantle, }, false)
hi('SniprunVirtualTextErr', { ctermbg = 0, guifg = colors.red, guibg = colors.mantle, }, false)
hi('SniprunFloatingWinOk', { ctermbg = 0, guifg = colors.blue, guibg = colors.mantle, }, false)
hi('SniprunFloatingWinErr', { ctermbg = 0, guifg = colors.red, guibg = colors.mantle, }, false)

----------------------------------
--           Options
----------------------------------
opt.clipboard     = 'unnamed' -- use system clipboard
opt.fillchars     = { -- thicker borders between windows
	horiz     = '━',
	horizup   = '┻',
	horizdown = '┳',
	vert      = '┃',
	vertleft  = '┫',
	vertright = '┣',
	verthoriz = '╋',
}
opt.ignorecase    = true -- ignore case when searching
opt.laststatus    = 3 -- one statusline for all windows
opt.linebreak     = true -- break lines
opt.mouse         = 'nicr' -- use mouse for scrolling and clicking
opt.number        = true -- line numbers
opt.scrolloff     = 15 -- keep 15 lines above/below cursor line
opt.shiftwidth    = 2 -- make indents correspond to one tab
opt.showbreak     = '↪ ' -- show ↪ on wrapped lines
opt.smartcase     = true -- override ignore case if uppercase letters in pattern
opt.smartindent   = true -- indent after brackets
opt.splitbelow    = true -- split splits below
opt.splitright    = true -- vertical split splits right
opt.tabstop       = 2 -- make tabs 2-spaces wide
opt.termguicolors = true -- better colors?
opt.timeoutlen    = 300 -- quicker inputs
opt.undofile      = true -- persistent undo
opt.updatetime    = 300 -- faster update time

-- turn off linenumber for terminals and autoenter insert mode
autocmd('TermOpen', {
	pattern = '*',
	callback = function()
		opt.number = false
		opt.relativenumber = false
		vim.api.nvim_command('startinsert')
	end,
})

----------------------------------
--          Mappings
----------------------------------
local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function bufnr_map(bufnr, mode, shortcut, command)
	vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
	map('n', shortcut, command)
end

local function nmap_buf(bufnr, shortcut, command)
	bufnr_map(bufnr, 'n', shortcut, command)
end

local function imap(shortcut, command)
	map('i', shortcut, command)
end

local function vmap(shortcut, command)
	map('v', shortcut, command)
end

g.mapleader = ',' -- remap leader to ,

nmap(';', ':') -- easy command input

nmap('wr', '<cmd>w!<cr>') -- Quick Save/Quit
nmap('wq', '<cmd>wq!<cr>')
nmap('qa', '<cmd>qa<cr>')
nmap('qw', '<cmd>wq<cr>')
nmap('qq', '<cmd>Bdelete<cr>') -- close buffer but preserve window layout

nmap('j', 'gj') -- move up and down by display rather than line number
nmap('k', 'gk')

nmap('<C-h>', [[<c-\><c-n><c-w>h]]) -- easy window navigation
nmap('<C-j>', [[<c-\><c-n><c-w>j]])
nmap('<C-k>', [[<c-\><c-n><c-w>k]])
nmap('<C-l>', [[<c-\><c-n><c-w>l]])
nmap('<C-q>', '<cmd>close<cr>') -- close window

nmap('rg', ':%s/') -- Replace
nmap('rl', ':s/')
nmap('rw', ':%s/\\<<C-r><C-w>\\>/')

nmap('<leader><space>', '<cmd>nohlsearch<cr>') -- Turn off search highlight

nmap('<C-v>', '<cmd>vsp<cr>') -- Splits
nmap('<C-x>', '<cmd>sp<cr>')

nmap('<leader>dw', '<cmd>%s/\\s\\+$//<cr><cmd>nohlsearch<cr>') -- delete trailing whitespace
nmap('<leader>dm', '<cmd>%s/^M//g<cr>') -- delete ^M

vmap('<', '<gv') -- don't unselect after shifting in visual mode
vmap('>', '>gv')

nmap('<cr>', 'o<Esc>') -- insert blank line with enter

nmap('<F1>', '<cmd>lua vim.diagnostic.goto_prev()<cr>') -- cycle between diagnostics
nmap('<F2>', '<cmd>lua vim.diagnostic.goto_next()<cr>')

nmap('<LeftDrag>', '<LeftMouse>') -- disable mouse drag entering visual mode

nmap('<leader>c', '<cmd>e $MYVIMRC | :cd %:p:h <cr>') -- open this config

-- bufferline mappings
nmap('<Left>', '<cmd>BufferLineCyclePrev<cr>')
nmap('<Right>', '<cmd>BufferLineCycleNext<cr>')
nmap('<S-Left>', '<cmd>BufferLineMovePrev<cr>')
nmap('<S-Right>', '<cmd>BufferLineMoveNext<cr>')
nmap('wj', '<cmd>BufferLinePick<cr>')

-- dap mappings
nmap('<c-b>', '<cmd>lua require("dapui").toggle()<cr>')
vmap('be', '<cmd> lua require("dapui").eval()<cr>)')
nmap('bb', '<cmd>DapToggleBreakpoint<cr>')
nmap('bl', '<cmd>Telescope dap list_breakpoints<cr>')
nmap('bv', '<cmd>Telescope dap variables<cr>')
nmap('bf', '<cmd>Telescope dap frames<cr>')
nmap('bc', '<cmd>DapContinue<cr>')
nmap('bt', '<cmd>DapTerminate<cr>')
nmap('bo', '<cmd>DapStepOver<cr>')
nmap('bi', '<cmd>DapStepInto<cr>')
nmap('bO', '<cmd>DapStepOut<cr>')

-- fm-nvim mappings
nmap('<A-r>', '<cmd>Ranger<cr>')
map('t', '<A-r>', '<cmd>close<cr>')

-- nvim-tree mappings
nmap('<C-f>', '<cmd>NvimTreeToggle<cr>')

-- SnipRun mappings
nmap('er', '<cmd>SnipRun<cr>')
nmap('el', '<cmd>SnipLive<cr>')
nmap('eq', '<cmd>SnipReset<cr>')
nmap('ec', '<cmd>SnipClose<cr>')
vmap('r', '<Plug>SnipRun')

-- Telescope mappings
nmap('\\', '<cmd>Telescope live_grep hidden=true<cr>')
nmap('ff', '<cmd>Telescope find_files hidden=true<cr>')
nmap('fb', '<cmd>Telescope buffers<cr>')
nmap('fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('fm', '<cmd>Telescope marks<cr>')
nmap('fr', '<cmd>Telescope oldfiles<cr>')
nmap('<space>c', '<cmd>Telescope command_center<cr>')
nmap('<leader>th', '<cmd>Telescope colorscheme<cr>')

-- toggleterm mappings
map('t', '<C-q>', '<cmd>close<cr>')
map('t', '<Esc>', '<cmd>close<cr>')
map('t', '<C-h>', [[<c-\><c-n><c-w>h]])
map('t', '<C-j>', [[<c-\><c-n><c-w>j]])
map('t', '<C-k>', [[<c-\><c-n><c-w>k]])
map('t', '<C-l>', [[<c-\><c-n><c-w>l]])

nmap('<A-t>', '<cmd>ToggleTerm direction=float<cr>')
map('t', '<A-t>', '<cmd>ToggleTerm direction=float<cr>')

nmap('<A-x>', '<cmd>lua _toggle_horizontal()<cr>')
map('t', '<A-x>', '<cmd>lua _toggle_horizontal()<cr>')

nmap('<A-g>', '<cmd>lua _toggle_lazygit()<cr>')
map('t', '<A-g>', '<cmd>lua _toggle_lazygit()<cr>')

nmap('<A-h>', '<cmd>lua _toggle_htop()<cr>')
map('t', '<A-h>', '<cmd>lua _toggle_htop()<cr>')

nmap('<A-p>', '<cmd>lua _toggle_ipython()<cr>')
map('t', '<A-p>', '<cmd>lua _toggle_ipython()<cr>')

-- which-key mappings
nmap('<space>k', '<cmd>WhichKey<cr>')

-- LSP mappings, these only bind when an LSP is attached
local on_attach = function(_, bufnr)
	g.code_action_menu_show_details = false
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v<cmd>lua.vim.lsp.omnifunc')

	nmap_buf(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	nmap_buf(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	nmap_buf(bufnr, 'gi', 'cmd>lua vim.lsp.buf.implementation()<cr>')
	nmap_buf(bufnr, '<space>i', '<cmd>lua vim.lsp.buf.hover()<cr>')
	nmap_buf(bufnr, '<space>h', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	nmap_buf(bufnr, '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	nmap_buf(bufnr, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	nmap_buf(bufnr, '<space>a', '<cmd>CodeActionMenu<cr>')
	nmap_buf(bufnr, '<space>f', '<cmd>lua vim.lsp.buf.format { async = true } <cr>')
	nmap_buf(bufnr, 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

	-- auto format on save
	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = '<buffer>',
		callback = function()
			vim.api.nvim_command('lua vim.lsp.buf.formatting_sync()')
		end
	})

	-- goto-preview mappings
	nmap_buf(bufnr, 'gp', '<cmd>lua require("goto-preview").goto_preview_definition()<cr>')
	nmap_buf(bufnr, 'gP', '<cmd>lua require("goto-preview").close_all_win()<cr>')
	nmap_buf(bufnr, 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<cr>')
	nmap_buf(bufnr, 'gr', '<cmd>lua require("goto-preview").goto_preview_references()<cr>')

	-- Symbols mappings
	nmap('<F3>', '<cmd>SymbolsOutline<cr>') -- toggle symbols outline

	-- Trouble mappings
	nmap_buf(bufnr, '<space>t', '<cmd>TroubleToggle<cr>')
	nmap_buf(bufnr, '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
	nmap_buf(bufnr, '<leader>tq', '<cmd>TroubleToggle quickfix<cr>')
	nmap_buf(bufnr, '<leader>tl', '<cmd>TroubleToggle loclist<cr>')
	nmap_buf(bufnr, 'gR', '<cmd>TroubleToggle lsp_references<cr>')
end

-----------------------------------
--           Plugins
-----------------------------------
require('packer').startup({ function()
	use 'wbthomason/packer.nvim' -- this package manager

	use { -- Autocompletion
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'saadparwaiz1/cmp_luasnip' },
	}

	use { -- Colorschemes
		{ 'catppuccin/nvim', as = 'catppuccin' },
		{ 'folke/tokyonight.nvim' },
	}

	use { -- DAP
		{ 'mfussenegger/nvim-dap' }, -- debugger
		{ 'mfussenegger/nvim-dap-python' }, -- debugger config for python
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'rcarriga/nvim-dap-ui' }, -- UI for debugger
		{ 'theHamsta/nvim-dap-virtual-text' },
	}

	use { -- LSP
		{ 'neovim/nvim-lspconfig' }, -- completion, go-to, etc.
		{ 'rmagatti/goto-preview' }, -- goto preview popup
		{ 'williamboman/nvim-lsp-installer' }, -- install lsp servers
	}

	use { -- Programming support
		{ 'L3MON4D3/LuaSnip' }, -- snippet engine
		{ 'michaelb/sniprun', run = 'bash ./install.sh' }, -- execute code inline
		{ 'numToStr/Comment.nvim' }, -- smart comments support
		{ 'nvim-treesitter/nvim-treesitter' }, -- additional syntax highlighting
		{ 'nvim-treesitter/nvim-treesitter-textobjects' },
		{ 'rafamadriz/friendly-snippets' }, -- common snippets package
		{ 'skywind3000/asyncrun.vim' }, -- run commands async
		{ 'tpope/vim-surround' }, -- easily change surrounding brackets, quotes, etc.
		{ 'windwp/nvim-autopairs' }, -- auto pair ( {, etc.
		{ 'windwp/nvim-ts-autotag' }, -- autoclose html, etc. tags
	}

	use { -- Telescope
		{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		{ 'nvim-telescope/telescope.nvim' }, -- aesthetic finder popup
		{ 'nvim-telescope/telescope-symbols.nvim' }, -- emoji + ascii symbols
		{ 'stevearc/dressing.nvim' }, -- use telescope for more things
	}

	use { -- UI
		{ 'akinsho/bufferline.nvim' }, -- nice buffer line
		{ 'akinsho/toggleterm.nvim' }, -- better terminals
		{ 'FeiyouG/command_center.nvim' }, -- command palette
		{ 'folke/which-key.nvim' }, -- shortcut popup
		{ 'folke/trouble.nvim' }, -- aesthetic diagnostics page
		{ 'goolord/alpha-nvim' }, -- fancy start page
		{ 'kosayoda/nvim-lightbulb' }, -- show a lightbulb for code actions
		{ 'kyazdani42/nvim-tree.lua' }, -- filetree
		{ 'kyazdani42/nvim-web-devicons' }, -- file icons
		{ 'lewis6991/gitsigns.nvim' }, -- git integration
		{ 'nvim-lualine/lualine.nvim' }, -- status line
		{ 'nvim-lua/plenary.nvim' }, -- UI dependency
		{ 'nvim-lua/popup.nvim' }, -- UI dependency
		{ 'rcarriga/nvim-notify' }, -- nice notifications
		{ 'RRethy/vim-illuminate' }, -- highlight symbol under cursor
		{ 'simrat39/symbols-outline.nvim' }, -- menu for symbols
		{ 'weilbith/nvim-code-action-menu' }, -- show menu for code actions
	}

	use { -- Utility
		{ 'andrewradev/switch.vim' }, -- smart switch between stuff
		{ 'famiu/bufdelete.nvim' }, -- better buffer delete command
		{ 'ggandor/lightspeed.nvim' }, -- easy navigation
		{ 'is0n/fm-nvim' }, -- for ranger
		{ 'max397574/better-escape.nvim' }, -- better insert mode exit
		{ 'rktjmp/paperplanes.nvim' }, -- upload buffer online
		{ 'rmagatti/auto-session' }, -- sessions based on cwd
		{ 'roxma/vim-paste-easy' }, -- auto-enter paste mode on paste
		{ 'wellle/targets.vim' }, -- more text objects
	}
end,
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}
})

--================================
--       Plugin Configs
--================================

----------------------------------
--        alpha config
----------------------------------
local sections = {}

sections.header = {
	type = 'text',
	val = {
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⢀⣠⠴⢞⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣲⣿⡄⢀⡴⠋⣠⣾⣿⣿⣿⣿⣄⣀⣀⡀⠀⠀⠀⠀⠈⠓⠲⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⣼⣿⣿⣿⡟⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣶⣦⣄⡀⠀⠀⠙⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠊⠉⠀⠀⠈⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡉⠛⢿⣷⣄⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⣀⡀⠤⠐⠒⡁⢴⣤⣤⡀⠀⠀⠀⣠⣼⣿⣿⣏⣀⣀⠀⠉⠛⢿⣿⣿⣿⣿⣿⣷⣄⠙⢿⣷⣄⠀⠀⠹⡄⠀⠀⠀⠀⠀',
		'⢰⣦⣍⣁⠀⠀⠀⠀⠀⠀⢾⡉⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⢸⣿⣿⣿⣿⣿⣿⣷⡄⢻⣿⣆⠀⠀⠑⠀⠀⠀⠀⠀',
		'⠈⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠁⠁⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⡿⠋⢀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⢻⣿⡄⠀⠀⠁⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⡻⢿⣿⣷⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣎⣿⣷⠀⠀⠀⠀⠀⠀⠀',
		'⢀⠀⠀⠀⠀⠀⠀⠀⢸⠾⠀⢀⣠⣶⠀⣠⣾⣿⣿⣿⣿⣦⡉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣇⠀⠀⠀⠀⠀⠀',
		'⠀⢹⠁⠰⠉⠉⠒⢄⣸⡷⠿⠛⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀',
		'⠀⠀⢇⡇⠀⠀⠀⠘⠁⣿⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠈⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀',
		'⠀⠀⠀⠁⠀⠀⠀⠀⠀⣿⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣿⣿⣯⠻⢿⣿⣿⣿⣷⣶⡆',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢀⣿⣿⣿⣷⣶⣶⣾⣿⡿⠟⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⢰⡏⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣼⣿⣿⣿⣿⣿⡍⠁⠀⠀⠀⠀',
		'⠀⠀⢀⠞⡄⠀⠀⢠⣿⣣⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⠏⣼⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀',
		'⠀⠀⢸⣀⣇⠠⠔⢫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢫⣾⣿⣿⣿⡿⢣⣿⣿⡇⠀⠀⠀⠀⠀',
		'⠀⠀⠰⡀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⠟⢁⣾⣿⣿⠁⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠑⡄⢸⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢁⣴⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠈⠚⠉⠉⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢛⣉⣤⣶⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⠟⡇⠈⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⡿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠀⠹⣿⣿⣿⣿⣿⡏⠀⣿⡀⢻⣿⣿⣿⣿⣿⣿⠟⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⡀⠈⠻⣿⣿⣿⡇⠀⠸⣷⡀⢿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⣄⠀⠈⠙⠿⣿⡄⠀⠘⢿⣦⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⣤⡀⠀⠀⠀⠀⠀⠀⠈⠛⠿⢿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
		'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠳⠦⠄⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
	},
	opts = {
		position = 'center',
		hl = 'Label',
	},
}

local function button(sc, txt)
	local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

	local opts = {
		position = 'center',
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = 'right',
	}

	return {
		type = 'button',
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, 'normal', false)
		end,
		opts = opts,
	}
end

sections.buttons = {
	type = 'group',
	val = {
		button('f f', '  Find file  '),
		button('f r', 'ﮦ  Recent files  '),
		button('\\', '  Live grep'),
		button('f m', '  Bookmarks  '),
		button(', c', '  Configuration'),
		button('q a', '  Quit'),
	},
	opts = {
		spacing = 1,
	},
}

require('alpha').setup {
	layout = {
		{ type = 'padding', val = fn.max { 2, fn.floor(fn.winheight(0) * 0.1) } },
		sections.header,
		{ type = 'padding', val = 1 },
		sections.buttons,
	},
	opts = {},
}

-- autolaunch alpha when last buffer is closed
vim.api.nvim_create_augroup('alpha_on_empty', { clear = true })
autocmd('User', {
	pattern = 'BDeletePre',
	group = 'alpha_on_empty',
	callback = function(event)
		local found_non_empty_buffer = false

		local buffers = {}
		local len = 0
		for buffer = 1, fn.bufnr('$') do
			if fn.buflisted(buffer) == 1 then
				len = len + 1
				buffers[len] = buffer
			end
		end

		for _, bufnr in ipairs(buffers) do
			if not found_non_empty_buffer then
				local name = vim.api.nvim_buf_get_name(bufnr)
				local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

				if bufnr ~= event.buf and name ~= '' and ft ~= 'Alpha' then
					found_non_empty_buffer = true
				end
			end
		end

		if not found_non_empty_buffer then
			vim.api.nvim_command('NvimTreeClose')
			vim.api.nvim_command('Alpha')
		end
	end,
})
----------------------------------
--     auto-session config
----------------------------------
require('auto-session').setup {
	auto_session_suppress_dirs = { '~' },
}

----------------------------------
--     better-escape config
----------------------------------
require('better_escape').setup {
	mapping = { 'jk' },
}

----------------------------------
--      bufferline config
----------------------------------
require('bufferline').setup {
	options = {
		always_show_bufferline = true,
		buffer_close_icon = '',
		close_icon = '',
		diagnostics = false,
		enforce_regular_tabs = false,
		left_trunc_marker = '',
		max_name_length = 14,
		max_prefix_length = 13,
		modified_icon = '',
		offsets = { { filetype = 'NvimTree', padding = 1 } },
		right_trunc_marker = '',
		separator_style = 'thin',
		show_close_icon = false,
		show_tab_indicators = true,
		show_buffer_close_icons = true,
		tab_size = 20,
		themable = true,
		view = 'multiwindow',
	},
}

----------------------------------
--       Comment config
----------------------------------
require('Comment').setup {}

----------------------------------
--         dap config
----------------------------------
-- Auto-open DAP UI on events
local dap, dapui = require('dap'), require('dapui')

dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end

-- Gutter symbols
fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

dapui.setup {
	sidebar = {
		size = 25,
	}
}

require('dap-python').setup()

require('nvim-dap-virtual-text').setup {
	commented = true,
}

----------------------------------
--       fm-nvim config
----------------------------------
require('fm-nvim').setup {
	ui = {
		float = {
			border = 'single',
		},
	},
}

----------------------------------
--       gitsigns config
----------------------------------
require('gitsigns').setup {}

----------------------------------
--      lightspeed config
----------------------------------
require('lightspeed').setup {
	jump_to_unique_chars = false,
	safe_labels = {},
}

----------------------------------
--         LSP config
----------------------------------
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('goto-preview').setup {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}
	server:setup(opts)
end)

----------------------------------
--       lualine config
----------------------------------
local lualine = require('lualine')

local conditions = {
	buffer_not_empty = function()
		return fn.empty(fn.expand('%<cmd>t')) ~= 1
	end,
	hide_in_width = function()
		return fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = fn.expand('%<cmd>p:h')
		local gitdir = fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		-- Disable sections and component separators
		component_separators = '',
		disabled_filetypes = {
			'alpha',
			'dapui_breakpoints',
			'dapui_hover',
			'dapui_repl',
			'dapui_stacks',
			'dapui_scopes',
			'dapui_watches',
			'NvimTree',
			'Outline',
			'packer',
			'TelescopePrompt',
			'toggleterm',
			'Trouble',
		},
		globalstatus = true,
		section_separators = '',
		theme = 'catppuccin',
	},
	sections = {
		-- These are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- These are to remove the defaults
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
		return '▌'
	end,
	color = { fg = colors.lavender }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
	-- mode component
	function()
		return ''
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			V = colors.blue,
			c = colors.mauve,
			no = colors.red,
			s = colors.peach,
			S = colors.peach,
			[''] = colors.peach,
			ic = colors.yellow,
			R = colors.lavender,
			Rv = colors.lavender,
			cv = colors.red,
			ce = colors.red,
			r = colors.teal,
			rm = colors.teal,
			['r?'] = colors.teal,
			['!'] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[fn.mode()] }
	end,
	padding = { right = 1 },
}

ins_left {
	'filename',
	cond = conditions.buffer_not_empty,
	icon = '',
	color = function()
		if vim.api.nvim_buf_get_option(0, 'modified') then
			return { fg = colors.red, gui = 'bold' }
		end
		return { fg = colors.blue, gui = 'bold' }
	end,
}

ins_left {
	'filesize',
	cond = conditions.buffer_not_empty,
	icon = '',
}

ins_left {
	'location',
	icon = '',
}

ins_right {
	'branch',
	icon = '',
	color = { fg = colors.lavender, gui = 'bold' },
}

ins_right {
	'diff',
	symbols = { added = ' ', modified = '柳', removed = ' ' },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.peach },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
}
ins_right {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.teal },
	},
}

local function get_lsp_client_name()
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	local clients = vim.lsp.get_active_clients()

	if next(clients) == nil then
		return nil
	end

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end

	return nil
end

ins_right {
	-- LSP server name
	function()
		local lsp_client = get_lsp_client_name()

		if lsp_client == nil then
			return 'ﰸ'
		end

		return '⟪' .. lsp_client .. '⟫'
	end,
	icon = ' LSP',
	color = function()
		local lsp_client = get_lsp_client_name()

		if lsp_client == nil then
			return { fg = colors.red }
		end

		return { fg = colors.green, gui = 'bold' }
	end,

}

ins_right {
	'o<cmd>encoding',
	fmt = string.upper,
	cond = conditions.hide_in_width,
	color = { fg = colors.teal, gui = 'bold' },
	icon = '',
}

ins_right {
	'fileformat',
	fmt = string.upper,
	icons_enabled = false,
	color = { fg = colors.teal, gui = 'bold' },
}

ins_right {
	function()
		return '▐'
	end,
	color = { fg = colors.lavender },
	padding = { left = 1 },
}

lualine.setup(config)

----------------------------------
--    nvim-autopairs config
----------------------------------
require('nvim-autopairs').setup {}

----------------------------------
--       nvim-cmp config
----------------------------------
require('luasnip.loaders.from_vscode').lazy_load()

local luasnip = require('luasnip')
local cmp = require('cmp')

local kind_icons = {
	Text = '',
	Method = '',
	Function = '',
	Constructor = '',
	Field = '',
	Variable = '',
	Class = 'ﴯ',
	Interface = '',
	Module = '',
	Property = 'ﰠ',
	Unit = '',
	Value = '',
	Enum = '',
	Keyword = '',
	Snippet = '',
	Color = '',
	File = '',
	Reference = '',
	Folder = '',
	EnumMember = '',
	Constant = '',
	Struct = '',
	Event = '',
	Operator = '',
	TypeParameter = ''
}

cmp.setup({
	enabled = function()
		-- disable completion in comments
		local context = require 'cmp.config.context'
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture('comment')
					and not context.in_syntax_group('Comment')
		end
	end,
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			return vim_item
		end
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
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
			if cmp.visible() then cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump()
			else fallback()
			end
		end
			, { 'i', 'c' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then luasnip.jump(-1)
			else fallback()
			end
		end
			, { 'i', 'c' }),
		['<cr>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' },
	}, {
		{ name = 'buffer' },
	})
})

local cmp_disabled_filetypes = {
	'dap-repl',
	'TelescopePrompt',
}

for _, filetype in pairs(cmp_disabled_filetypes) do
	cmp.setup.filetype(filetype, {
		enabled = false
	})
end

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
--       nvim-tree config
----------------------------------
require('nvim-tree').setup {
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	disable_netrw = true,
	git = {
		enable = false,
		ignore = true,
	},
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_ft_on_setup = { 'alpha' },
	open_on_tab = false,
	renderer = {
		highlight_git = true,
		indent_markers = {
			enable = false,
		},
	},
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	view = {
		side = 'left',
		width = 30,
		hide_root_folder = true,
	},
}

----------------------------------
--    nvim-treesitter config
----------------------------------
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'c',
		'cpp',
		'css',
		'html',
		'java',
		'javascript',
		'lua',
		'python',
		'rust',
		'yaml',
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'vni',
			node_incremental = 'vnn',
			node_decremental = 'vnp',
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
	},
	autotag = {
		enable = true,
	},
}

----------------------------------
--      paperplanes config
----------------------------------
require('paperplanes').setup {
	register = '+',
	provider = 'ix.io',
	provider_options = { insecure = true },
	cmd = 'curl',
}

----------------------------------
--        sniprun config
----------------------------------
require('sniprun').setup {
	display = {
		'TempFloatingWindow'
	},
	live_mode_toggle = 'enable',
}

----------------------------------
--    symbols-outline config
----------------------------------
g.symbols_outline = {
	width = 25,
	relative_width = false,
	show_symbol_details = false,
	symbols = {
		Array = { icon = '', hl = 'TSConstant' },
		Boolean = { icon = '⊨', hl = 'TSBoolean' },
		Class = { icon = 'ﴯ', hl = 'TSType' },
		Constant = { icon = '', hl = 'TSConstant' },
		Constructor = { icon = '', hl = 'TSConstructor' },
		Enum = { icon = '', hl = 'TSType' },
		EnumMember = { icon = '', hl = 'TSField' },
		Event = { icon = '', hl = 'TSType' },
		Field = { icon = '', hl = 'TSField' },
		File = { icon = '', hl = 'TSURI' },
		Function = { icon = '', hl = 'TSFunction' },
		Interface = { icon = '', hl = 'TSType' },
		Key = { icon = '', hl = 'TSType' },
		Method = { icon = '', hl = 'TSMethod' },
		Module = { icon = '', hl = 'TSNamespace' },
		Namespace = { icon = '', hl = 'TSNamespace' },
		Null = { icon = 'NULL', hl = 'TSType' },
		Number = { icon = '#', hl = 'TSNumber' },
		Object = { icon = '⦿', hl = 'TSType' },
		Operator = { icon = '', hl = 'TSOperator' },
		Package = { icon = '', hl = 'TSNamespace' },
		Property = { icon = 'ﰠ', hl = 'TSMethod' },
		String = { icon = '', hl = 'TSString' },
		Struct = { icon = '', hl = 'TSType' },
		TypeParameter = { icon = '', hl = 'TSParameter' },
		Variable = { icon = '', hl = 'TSConstant' },
	}
}
----------------------------------
--       Telescope config
----------------------------------
require('telescope').setup {
	defaults = {
		borderchars = {
			prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
			results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
			preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		},
		color_devicons = true,
		entry_prefix = '  ',
		file_ignore_patterns = {
			'.bundle',
			'.git',
			'node_modules',
			'site-packages',
		},
		initial_mode = 'insert',
		layout_config = {
			height = function(_, _, max_lines)
				return math.min(max_lines, 15)
			end,
			preview_cutoff = 1,
			width = function(_, max_columns, _)
				return math.min(max_columns, 80)
			end,
		},
		layout_strategy = 'center',
		path_display = { 'truncate' },
		prompt_prefix = '   ',
		results_title = false,
		selection_caret = '  ',
		selection_strategy = 'reset',
		sorting_strategy = 'ascending',
		use_less = true,
		vimgrep_arguments = {
			'rg',
			'--line-number',
			'--column',
			'--smart-case',
		},
		winblend = 0,
	},
	extensions = {
		command_center = {
			components = {
				require('command_center').component.DESCRIPTION,
			},
		},
	}
}

require('telescope').load_extension('command_center')
require('telescope').load_extension('fzf')

---------------------------------
--      toggleterm config
---------------------------------
require 'toggleterm'.setup {
	shade_terminals = false,
}

local Terminal = require('toggleterm.terminal').Terminal

local horizontal = Terminal:new({ direction = 'horizontal', hidden = true })
function _toggle_horizontal()
	horizontal:toggle()
end

local htop = Terminal:new({ cmd = 'htop', direction = 'float', hidden = true })
function _toggle_htop()
	htop:toggle()
end

local lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })
function _toggle_lazygit()
	lazygit:toggle()
end

local ipython = Terminal:new({ cmd = 'ipython', direction = 'float', hidden = true })
function _toggle_ipython()
	ipython:toggle()
end

----------------------------------
--       trouble config
----------------------------------
require('trouble').setup {}

----------------------------------
--    command center config
----------------------------------
local command_center = require('command_center')

command_center.add({
	{
		description = 'Open keymap',
		cmd = '<cmd>WhichKey<cr>',
	},
	{
		description = 'Find file',
		cmd = '<cmd>Telescope find_files<cr>',
	},
	{
		description = 'Open recent file',
		cmd = '<cmd>Telescope oldfiles<cr>',
	},
	{
		description = 'Search in current file',
		cmd = '<cmd>Telescope current_buffer_fuzzy_find<cr>',
	},
	{
		description = 'Search in files',
		cmd = '<cmd>Telescope live_grep<cr>',
	},
	{
		description = 'New file in tab',
		cmd = '<cmd>tabnew<cr>',
	},
	{
		description = 'Close current file',
		cmd = '<cmd>Bdelete<cr>',
	},
	{
		description = 'Save current file',
		cmd = '<cmd>w<cr>',
	},
	{
		description = 'Save all files',
		cmd = '<cmd>wa<cr>',
	},
	{
		description = 'Save and quit',
		cmd = '<cmd>wq<cr>',
	},
	{
		description = 'Open vertical split',
		cmd = '<cmd>vsp<cr>',
	},
	{
		description = 'Open horizontal split',
		cmd = '<cmd>sp<cr>',
	},
	{
		description = 'Quit',
		cmd = '<cmd>qa<cr>',
	},
	{
		description = 'Force quit',
		cmd = '<cmd>q!<cr>',
	},
	{
		description = 'Select all',
		cmd = '<cmd>call feedkeys("GVgg")<cr>',
	},
	{
		description = 'Trim trailing whitespace',
		cmd = '<cmd>%s/\\s\\+$//<cr><cmd>nohlsearch<cr>',
	},
	{
		description = 'Reload config',
		cmd = '<cmd>source ~/.config/nvim/init.lua<cr>',
	},
	{
		description = 'Check health',
		cmd = '<cmd>checkhealth<cr>',
	},
	{
		description = 'Toggle live code execution',
		cmd = '<cmd>SnipLive<cr>',
	},
	{
		description = 'Open DAP commands',
		cmd = '<cmd>Telescope dap commands<cr>',
	},
	{
		description = 'Open DAP configurations',
		cmd = '<cmd>Telescope dap configurations<cr>',
	},
	{
		description = 'Open DAP breakpoints',
		cmd = '<cmd>Telescope dap breakpoints<cr>',
	},
	{
		description = 'Open DAP variables',
		cmd = '<cmd>Telescope dap variables<cr>',
	},
	{
		description = 'Open DAP frames',
		cmd = '<cmd>Telescope dap frames<cr>',
	},
	{
		description = 'Open command history',
		cmd = '<cmd>Telescope command_history<cr>',
	},
	{
		description = 'Open search history',
		cmd = '<cmd>Telescope search_history<cr>',
	},
	{
		description = 'Open quickfix history',
		cmd = '<cmd>Telescope quickfixhistory<cr>',
	},
	{
		description = 'Open type definitions',
		cmd = '<cmd>Telescope lsp_type_definitions<cr>',
	},
	{
		description = 'Open document symbols',
		cmd = '<cmd>Telescope lsp_document_symbols<cr>',
	},
	{
		description = 'Open treesitter',
		cmd = '<cmd>Telescope treesitter<cr>',
	},
	{
		description = 'Open diagnostics',
		cmd = '<cmd>Telescope diagnostics<cr>',
	},
	{
		description = 'Open quickfix menu',
		cmd = '<cmd>Telescope quickfix<cr>',
	},
	{
		description = 'Open definitions',
		cmd = '<cmd>Telescope lsp_definitions<cr>',
	},
	{
		description = 'Open references',
		cmd = '<cmd>Telescope lsp_references<cr>',
	},
	{
		description = 'Open implementations',
		cmd = '<cmd>Telescope lsp_implementations<cr>',
	},
	{
		description = 'Open dynamic workspace symbols',
		cmd = '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
	},
	{
		description = 'Rename symbol under cursor',
		cmd = '<cmd>lua vim.lsp.buf.rename()<cr>',
	},
	{
		description = 'Open code actions for symbol under cursor',
		cmd = '<cmd>CodeActionMenu<cr>',
	},
	{
		description = 'Open references for symbol under cursor',
		cmd = '<cmd>lua require("goto-preview").goto_preview_references()<cr>',
	},
	{
		description = 'Open definition for symbol under cursor',
		cmd = '<cmd>lua require("goto-preview").goto_definition()<cr>',
	},
	{
		description = 'Open implementation for symbol under cursor',
		cmd = '<cmd>lua require("goto-preview").goto_implementation()<cr>',
	},
	{
		description = 'Close all preview windows',
		cmd = '<cmd>lua require("goto-preview").close_all_win()<cr>',
	},
	{
		description = 'Format file',
		cmd = '<cmd>lua vim.lsp.buf.format { async = true } <cr>',
	},
	{
		description = 'Open jump list',
		cmd = '<cmd>Telescope jumplist<cr>',
	},
	{
		description = 'Open marks',
		cmd = '<cmd>Telescope marks<cr>',
	},
	{
		description = 'Open filetype list',
		cmd = '<cmd>Telescope filetypes<cr>',
	},
	{
		description = 'Open symbol map',
		cmd = '<cmd>Telescope symbols<cr>',
	},
	{
		description = 'Open vim options',
		cmd = '<cmd>Telescope vim_options<cr>',
	},
	{
		description = 'Open man pages',
		cmd = '<cmd>Telescope man_pages<cr>',
	},
	{
		description = 'Open spell suggest',
		cmd = '<cmd>Telescope spell_suggest<cr>',
	},
	{
		description = 'Change colorscheme',
		cmd = '<cmd>Telescope colorscheme<cr>',
	},
	{
		description = 'Toggle trouble menu',
		cmd = '<cmd>TroubleToggle<cr>',
	},
	{
		description = 'Toggle file tree',
		cmd = '<cmd>NvimTreeToggle<cr>',
	},
	{
		description = 'Toggle ranger',
		cmd = '<cmd>Ranger<cr>',
	},
	{
		description = 'Toggle symbols outline',
		cmd = '<cmd>SymbolsOutline<cr>',
	},
	{
		description = 'Toggle floating terminal',
		cmd = '<cmd>ToggleTerm direction=float<cr>',
	},
	{
		description = 'Toggle terminal in horizontal split',
		cmd = '<cmd>lua _toggle_horizontal()<cr>',
	},
	{
		description = 'Toggle lazygit',
		cmd = '<cmd>lua _toggle_lazygit()<cr>',
	},
	{
		description = 'Toggle htop',
		cmd = '<cmd>lua _toggle_htop()<cr>',
	},
	{
		description = 'Toggle ipython',
		cmd = '<cmd>lua _toggle_ipython()<cr>',
	},
	{
		description = 'Toggle paste mode',
		cmd = '<cmd>set paste!<cr>',
	},
	{
		description = 'Toggle cursor line',
		cmd = '<cmd>set cursorline!<cr>',
	},
	{
		description = 'Toggle spell checker',
		cmd = '<cmd>set spell!<cr>',
	},
	{
		description = 'Toggle relative number',
		cmd = '<cmd>set relativenumber!<cr>',
	},
	{
		description = 'Toggle search highlighting',
		cmd = '<cmd>set hlsearch!<cr>',
	},
	{
		description = 'Open git branches',
		cmd = '<cmd>Telescope git_branches<cr>',
	},
	{
		description = 'Open git files',
		cmd = '<cmd>Telescope git_files<cr>',
	},
	{
		description = 'Install LSP server',
		cmd = '<cmd>LspInstall<cr>',
	},
	{
		description = 'Open LSP info',
		cmd = '<cmd>LspInfo<cr>',
	},
	{
		description = 'Restart LSP server',
		cmd = '<cmd>LspRestart<cr>',
	},
	{
		description = 'Packer install',
		cmd = '<cmd>PackerInstall<cr>',
	},
	{
		description = 'Packer update',
		cmd = '<cmd>PackerUpdate<cr>',
	},
	{
		description = 'Packer sync',
		cmd = '<cmd>PackerSync<cr>',
	},
	{
		description = 'Packer clean',
		cmd = '<cmd>PackerClean<cr>',
	},
	{
		description = 'Packer status',
		cmd = '<cmd>PackerStatus<cr>',
	},
})

----------------------------------
--       which-key config
----------------------------------
local wk = require('which-key')

wk.setup({
	ignore_missing = true,
	plugins = {
		marks = false,
		registers = false,
		presets = {
			operators = false,
			motions = false,
			nav = false,
		},
	},
	key_labels = {
		['<Right>'] = '⇒',
		['<Left>'] = '⬅',
		['<M-g>'] = 'Alt + g',
		['<M-h>'] = 'Alt + h',
		['<M-p>'] = 'Alt + p',
		['<M-r>'] = 'Alt + r',
		['<M-t>'] = 'Alt + t',
		['<M-x>'] = 'Alt + x',
		['<C-B>'] = 'Ctrl + b',
		['<C-H>'] = 'Ctrl + h',
		['<C-J>'] = 'Ctrl + j',
		['<C-K>'] = 'Ctrl + k',
		['<C-L>'] = 'Ctrl + l',
		['<C-F>'] = 'Ctrl + f',
		['<C-Q>'] = 'Ctrl + q',
		['<c-space>'] = 'Ctrl + space',
		['<C-V>'] = 'Ctrl + v',
		['<c-w>'] = 'Ctrl + w',
		['<C-X>'] = 'Ctrl + x',
		['<F1>'] = 'F1',
		['<F2>'] = 'F2',
		['<F3>'] = 'F3',
		['<S-Right>'] = 'Shift + ⇒',
		['<S-Left>'] = 'Shift + ⬅',
		['<space>'] = 'Space',
		['<CR>'] = 'Enter',
		['<Tab>'] = 'Tab',
		['<leader>'] = ',',
	}
})

wk.register({
	c = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
		s = 'Surrounding',
	},
	b = {
		name = 'Debug',
		b = 'Toggle breakpoint',
		c = 'Continue',
		e = 'Evaluate expression under cursor',
		f = 'List frames',
		i = 'Step into',
		l = 'List breakpoints',
		o = 'Step over',
		O = 'Step out',
		t = 'Terminate',
		v = 'List variables'
	},
	d = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
		s = 'Surrounding',
	},
	e = {
		name = 'Code execution',
		c = 'Clear all execution results',
		l = 'Toggle live code execution',
		r = 'Execute line of code',
		q = 'Stop currently executing code',
	},
	g = {
		name = 'Goto/Comments/Global',
		b = 'Toggle comment blockwise',
		c = 'Toggle comment linewise',
		d = 'Jump to definition for symbol',
		D = 'Jump to decleration for symbol',
		p = 'Open definition preview for symbol',
		P = 'Close all preview windows',
		r = 'Open references in preview for symbol',
		R = 'Open references in quickfix window for symbol',
		s = 'Switch symbol under cursor',
		u = {
			a = {
				c = 'a class',
				f = 'a function',
			},
			i = {
				c = 'a class',
				f = 'a function',
			}
		},
		U = {
			a = {
				c = 'a class',
				f = 'a function',
			},
			i = {
				c = 'a class',
				f = 'a function',
			}
		},
		['~'] = {
			a = {
				c = 'a class',
				f = 'a function',
			},
			i = {
				c = 'a class',
				f = 'a function',
			},
		}
	},
	f = {
		name = 'Search',
		b = 'Switch between open buffers',
		f = 'Search for filename',
		m = 'Open bookmarks',
		r = 'Open recent file',
		s = 'Search pattern in current file',
	},
	q = {
		name = 'Quit',
		a = 'Quit all',
		q = 'Close current buffer',
		w = 'Save and quit',
	},
	r = {
		name = 'Refactor',
		g = 'Replace all',
		l = 'Replace on line only',
		n = 'Rename symbol under cursor',
		w = 'Rename word under cursor',
	},
	s = 'Jump to text forwards',
	S = 'Jump to text backwards',
	v = {
		name = 'Visual Mode',
		n = {
			name = 'Node selection',
			i = 'Initialize node selection',
			n = 'Increment node selection',
			p = 'Decrement node selection',
		},
		r = 'Execute code selection',
	},
	w = {
		name = 'Save/Jump',
		j = 'Jump to buffer',
		q = 'Save and quit',
		r = 'Save',
	},
	['<space>'] = {
		name = 'Util',
		a = 'Open code action menu',
		c = 'Open command center',
		d = 'Open type definiton for symbol',
		e = 'Open diagnostics window',
		f = 'Format current file',
		h = 'Open signature help',
		i = 'Preview symbol information',
		k = 'Open keymap',
		t = 'Toggle trouble menu',
		w = {
			name = 'Workspace',
			a = 'Add workspace folder',
			l = 'List workspace folders',
			r = 'Remove workspace folder',
		},
	},
	['<leader>'] = {
		name = 'Misc',
		c = 'Open nvim config',
		d = {
			name = 'Trim',
			m = 'Trim ^M carriage characters',
			w = 'Trim trailing whitespace',
		},
		t = {
			name = 'Trouble',
			l = 'Toggle location list',
			q = 'Toggle quickfix list',
			w = 'Toggle workspace diagnostics',
		},
		['<space>'] = 'Unhighlight search results',
	},
	[';'] = 'Input command',
	['\\'] = 'Live grep',
	['<Left>'] = 'Previous buffer',
	['<Right>'] = 'Next buffer',
	['<A-h>'] = 'Toggle htop',
	['<A-g>'] = 'Toggle lazygit',
	['<A-p>'] = 'Toggle ipython',
	['<A-r>'] = 'Toggle ranger',
	['<A-t>'] = 'Toggle floating terminal',
	['<A-x>'] = 'Toggle terminal in split',
	['<c-b>'] = 'Toggle DAP sidebar',
	['<c-f>'] = 'Toggle file tree',
	['<c-h>'] = 'Go to window left',
	['<C-j>'] = 'Go to window down',
	['<c-k>'] = 'Go to window up',
	['<c-l>'] = 'Go to window right',
	['<c-q>'] = 'Close selected window',
	['<c-space>'] = 'Trigger autocomplete',
	['<c-v>'] = 'Split window vertically',
	['<c-x>'] = 'Split window horizontally',
	['<cr>'] = 'Insert blankline',
	['<F1>'] = 'Goto previous location',
	['<F2>'] = 'Goto next location',
	['<F3>'] = 'Toggle symbols outline',
	['<s-left>'] = 'Move buffer left',
	['<s-Right>'] = 'Move buffer right',
})
