--================================================
--                Neovim Config
--    Author: Zane Bilous
--    Last Modified: 05/21/2022
--    Dependencies:
--      ripgrep, fzf
--================================================

----------------------------------
--           Aliases
----------------------------------
local autocmd = vim.api.nvim_create_autocmd
local cmd     = vim.cmd
local g       = vim.g
local fn      = vim.fn
local opt     = vim.opt

----------------------------------
--           Options
----------------------------------
opt.clipboard = 'unnamed' -- use system clipboard
opt.cmdheight = 2 -- use more space for displaying messages
opt.ignorecase = true -- ignore case when searching
opt.linebreak = true -- break lines
opt.mouse = 'nicr' -- use mouse for scrolling and clicking
opt.number = true -- line numbers
opt.scrolloff = 15 -- keep 15 lines above/below cursor line
opt.shiftwidth = 2 -- make indents correspond to one tab
opt.showbreak = '↪ ' -- show ↪ on wrapped lines
opt.smartcase = true -- override ignore case if uppercase letters in pattern
opt.smartindent = true -- indent after brackets
opt.splitbelow = true -- split splits below
opt.splitright = true -- vertical split splits right
opt.tabstop = 2 -- make tabs 2-spaces wide
opt.termguicolors = true -- better colors?
opt.timeoutlen = 500 -- quicker inputs
opt.undofile = true -- persistent undo
opt.updatetime = 300 -- faster update time

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
--            Mappings
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
nmap('B', '^') -- Line navigation
nmap('E', '$')
nmap('j', 'gj') -- move up and down by display rather than line number
nmap('k', 'gk')
nmap('<leader><space>', '<cmd>nohlsearch<cr>') -- Turn off search highlight
nmap('rg', ':%s/') -- Replace
nmap('rl', ':s/')
nmap('rw', ':%s/\\<<C-r><C-w>\\>/')
nmap('qq', '<cmd>Bdelete<cr>') -- Buffers
nmap('<C-v>', '<cmd>vsp<cr>') -- Splits
nmap('<C-x>', '<cmd>sp<cr>')
nmap('<leader>dw', '<cmd>%s/\\s\\+$//<cr>:nohlsearch<cr>') -- delete trailing whitespace
nmap('<leader>dm', '<cmd>%s/^M//g<cr>') -- delete ^M
nmap('<S-s>', '<cmd>m+<cr>') -- move lines with shift+w/s
nmap('<S-w>', '<cmd>m-2<cr>')
vmap('<', '<gv') -- don't unselect after shifting in visual mode
vmap('>', '>gv')
nmap('<cr>', 'o<Esc>') -- insert blank line with enter
nmap('<bs>', 'dd') -- delete line with backspace
nmap('<C-q>', '<cmd>:close<cr>') -- close window
nmap('<F1>', '<cmd>lua vim.diagnostic.goto_prev()<cr>') -- cycle between diagnostics
nmap('<F2>', '<cmd>lua vim.diagnostic.goto_next()<cr>')
nmap('<leader>cf', '<cmd>e $MYVIMRC | :cd %:p:h <cr>')
nmap('<LeftDrag>', '<LeftMouse>') -- disable mouse drag entering visual mode

-- bufferline mappings
nmap('<Left>', '<cmd>BufferLineCyclePrev<cr>')
nmap('<Right>', '<cmd>BufferLineCycleNext<cr>')
nmap('<S-Left>', '<cmd>BufferLineMovePrev<cr>')
nmap('<S-Right>', '<cmd>BufferLineMoveNext<cr>')
nmap('<S-Right>', '<cmd>BufferLineMoveNext<cr>')
nmap('tj', '<cmd>BufferLinePick<cr>')

-- dap mappings
nmap('<c-b>', '<cmd>lua require("dapui").toggle()<cr>')
nmap('bb', '<cmd>DapToggleBreakpoint<cr>')
nmap('bl', '<cmd>Telescope dap list_breakpoints<cr>')
nmap('bv', '<cmd>Telescope dap variables<cr>')
nmap('bf', '<cmd>Telescope dap frames<cr>')
nmap('bc', '<cmd>DapContinue<cr>')
nmap('bt', '<cmd>DapTerminate<cr>')
nmap('bo', '<cmd>DapStepOver<cr>')
nmap('bi', '<cmd>DapStepInto<cr>')
nmap('bO', '<cmd>DapStepOut<cr>')

-- nvterm mappings
nmap('<A-t>', '<cmd>lua require("nvterm.terminal").toggle("float")<cr>')
map('t', '<A-t>', '<cmd>lua require("nvterm.terminal").toggle("float")<cr>')
nmap('<A-v>', '<cmd>lua require("nvterm.terminal").toggle("vertical")<cr>')
map('t', '<A-v>', '<cmd>lua require("nvterm.terminal").toggle("vertical")<cr>')
nmap('<A-x>', '<cmd>lua require("nvterm.terminal").toggle("horizontal")<cr>')
map('t', '<A-x>', '<cmd>lua require("nvterm.terminal").toggle("horizontal")<cr>')
nmap('<A-V>', '<cmd>lua require("nvterm.terminal").new("vertical")<cr>')
map('t', '<A-V>', '<cmd>lua require("nvterm.terminal").new("vertical")<cr>')
nmap('<A-X>', '<cmd>lua require("nvterm.terminal").new("horizontal")<cr>')
map('t', '<A-X>', '<cmd>lua require("nvterm.terminal").new("horizontal")<cr>')
map('t', '<C-q>', '<cmd>close<cr>')

-- hop mappings
nmap('ww', '<cmd>HopWord<cr>')
nmap('wl', '<cmd>HopLine<cr>')

-- nvim-tree mappings
nmap('<C-n>', '<cmd>NvimTreeToggle<cr>')

-- SnipRun mappings
nmap('sr', '<cmd>SnipRun<cr>')
nmap('sq', '<cmd>SnipReset<cr>')
nmap('sc', '<cmd>SnipClose<cr>')
vmap('sr', "<cmd>SnipRun<cr>")

-- Telescope mappings
nmap('\\', '<cmd>Telescope live_grep hidden=true<cr>')
nmap('ff', '<cmd>Telescope find_files hidden=true<cr>')
nmap('fb', '<cmd>Telescope buffers<cr>')
nmap('fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('fm', '<cmd>Telescope marks<cr>')
nmap('fr', '<cmd>Telescope oldfiles<cr>')
nmap('<space>p', '<cmd>Telescope command_center<cr>')
nmap('th', '<cmd>Telescope colorscheme<cr>')

-- LSP mappings
-- These only bind when an LSP is attached
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v<cmd>lua.vim.lsp.omnifunc')
	nmap_buf(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	nmap_buf(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	nmap_buf(bufnr, 'D', '<cmd>lua vim.lsp.buf.hover()<cr>')
	nmap_buf(bufnr, 'gi', 'cmd>lua vim.lsp.buf.implementation()<cr>')
	nmap_buf(bufnr, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	nmap_buf(bufnr, '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
	nmap_buf(bufnr, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	nmap_buf(bufnr, '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	nmap_buf(bufnr, 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	nmap_buf(bufnr, 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
	nmap_buf(bufnr, '<space>f', '<cmd>lua vim.lsp.buf.format { async = true } <cr>')

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
	nmap_buf(bufnr, '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>')
	nmap_buf(bufnr, '<leader>tq', '<cmd>TroubleToggle quickfix<cr>')
	nmap_buf(bufnr, '<leader>tl', '<cmd>TroubleToggle loclist<cr>')
	nmap_buf(bufnr, 'gR', '<cmd>TroubleToggle lsp_references<cr>')
end

-----------------------------------
--            Plugins
-----------------------------------
require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- this package manager

	use { -- Autocompletion
		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-path' },
		{ 'saadparwaiz1/cmp_luasnip' },
	}

	use { -- Colorschemes
		{ 'EdenEast/nightfox.nvim' },
		{ 'folke/tokyonight.nvim' },
		{ 'mhartington/oceanic-next' },
		{ 'olimorris/onedarkpro.nvim' },
		{ 'rebelot/kanagawa.nvim' },
		{ 'rose-pine/neovim' },
		{ 'shaunsingh/nord.nvim' },
		{ 'tiagovla/tokyodark.nvim' },
	}

	use { -- DAP
		{ 'mfussenegger/nvim-dap' }, -- debugger
		{ 'mfussenegger/nvim-dap-python' }, -- debugger config for python
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'theHamsta/nvim-dap-virtual-text' },
	}

	use { -- LSP
		{ 'rmagatti/goto-preview' }, -- goto preview popup
		{ 'neovim/nvim-lspconfig' }, -- completion, go-to, etc.
		{ 'williamboman/nvim-lsp-installer' }, -- install lsp servers
	}

	use { -- Programming support
		{ 'L3MON4D3/LuaSnip' }, -- snippets
		{ 'markonm/traces.vim' }, -- live preview for substitution
		{ 'michaelb/sniprun', run = 'bash ./install.sh' }, -- run code snippets
		{ 'numToStr/Comment.nvim' }, -- comments
		{ 'nvim-treesitter/nvim-treesitter' }, -- additional syntax highlighting
		{ 'nvim-treesitter/nvim-treesitter-textobjects' },
		{ 'rafamadriz/friendly-snippets' }, -- snippets
		{ 'rcarriga/nvim-dap-ui' }, -- UI for debugger
		{ 'skywind3000/asyncrun.vim' }, -- run commands async
		{ 'tpope/vim-surround' }, -- easily change surrounding brackets, quotes, etc.
		{ 'windwp/nvim-ts-autotag' }, -- autoclose html, etc. tags
		{ 'windwp/nvim-autopairs' }, -- auto pair ( {, etc.
	}

	use { -- Telescope
		{ 'nvim-telescope/telescope.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		{ 'nvim-telescope/telescope-symbols.nvim' },
		{ 'stevearc/dressing.nvim' }, -- use telescope for more things
	}

	use { -- UI
		{ 'akinsho/bufferline.nvim' }, -- nice buffer line
		{ 'folke/which-key.nvim' }, -- shortcut popup
		{ 'folke/trouble.nvim' }, -- aesthetic diagnostics page
		{ 'FeiyouG/command_center.nvim' }, -- command palette
		{ 'goolord/alpha-nvim' }, -- fancy start page
		{ 'kosayoda/nvim-lightbulb' }, -- show a lightbulb for code actions
		{ 'kyazdani42/nvim-tree.lua' }, -- filetree
		{ 'kyazdani42/nvim-web-devicons' }, -- file icons
		{ 'lewis6991/gitsigns.nvim' }, -- git integration
		{ 'NvChad/nvterm' }, -- terminal popup and splits
		{ 'nvim-lua/plenary.nvim' }, -- dependency
		{ 'nvim-lua/popup.nvim' }, -- dependency
		{ 'nvim-lualine/lualine.nvim' }, -- status line
		{ 'RRethy/vim-illuminate' }, -- highlight symbol under cursor
		{ 'simrat39/symbols-outline.nvim' }, -- menu for symbols
		{ 'weilbith/nvim-code-action-menu' }, -- show menu for code actions
	}

	use { -- Utility
		{ 'famiu/bufdelete.nvim' }, -- better buffer delete command
		{ 'max397574/better-escape.nvim' }, -- better insert mode exit
		{ 'phaazon/hop.nvim' }, -- easy navigation
		{ 'rktjmp/paperplanes.nvim' }, -- upload buffer online
		{ 'rmagatti/auto-session' }, -- sessions based on cwd
		{ 'roxma/vim-paste-easy' }, -- auto-enter paste mode on paste
	}
end)

----------------------------------
--             Colors
----------------------------------
cmd [[ colorscheme tokyonight ]]

--================================================
--                Plugin Configs
--================================================

----------------------------------
--         alpha config
----------------------------------
local function button(sc, txt, keybind)
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

local options = {}

local ascii = {
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
}

options.header = {
	type = 'text',
	val = ascii,
	opts = {
		position = 'center',
		hl = 'Label',
	},
}

options.buttons = {
	type = 'group',
	val = {
		button('f f', '  Find File  ', ':Telescope find_files<cr>'),
		button('f r', '  Recent File  ', ':Telescope oldfiles<cr>'),
		button('\\', '  Find Word  ', ':Telescope live_grep<cr>'),
		button('b m', '  Bookmarks  ', ':Telescope marks<cr>'),
		button('t h', '  Themes  ', ':Telescope colorscheme<cr>'),
		button(', c f', '  Settings', ':e $MYVIMRC | :cd %:p:h <cr>'),
	},
	opts = {
		spacing = 1,
	},
}

-- Reenable status and tabline outside of alpha
autocmd('FileType', {
	pattern = '*',
	callback = function()
		opt.laststatus = 2
		opt.showtabline = 2
	end,
})

-- Disable statusline in alpha
autocmd('FileType', {
	pattern = 'alpha',
	callback = function()
		opt.laststatus = 0
		opt.showtabline = 0
	end,
})

-- dynamic header padding
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * 0.1) }

require('alpha').setup {
	layout = {
		{ type = 'padding', val = headerPadding },
		options.header,
		{ type = 'padding', val = 2 },
		options.buttons,
	},
	opts = {},
}
----------------------------------
--      auto-session config
----------------------------------
require('auto-session').setup {}

----------------------------------
--      bufferline config
----------------------------------
require('bufferline').setup {
	options = {
		buffer_close_icon = '',
		close_icon = '',
		close_command = 'Bdelete! %d',
		right_mouse_command = 'Bdelete! %d',
		separator_style = 'thick',
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			if context.buffer:current() then
				return ''
			end
			local s = ' '
			for e, n in pairs(diagnostics_dict) do
				local sym = e == 'error' and ' '
						or (e == 'warning' and ' ' or ' ')
				s = s .. n .. sym
			end
			return s
		end,
		offsets = {
			{ filetype = 'NvimTree' },
		},
	},
}

----------------------------------
--    better-escpape config
----------------------------------
require('better_escape').setup {
	mapping = { 'jk' },
}

----------------------------------
--        Comment config
----------------------------------
require('Comment').setup {}

----------------------------------
--          dap config
----------------------------------
require('dapui').setup {}

-- Python DAP Configuration
require('dap-python').setup()

require("nvim-dap-virtual-text").setup {
	commented = true,
}

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

-- Gutter colors and symbols
vim.highlight.create('DapBreakpoint', { ctermbg = 0, guifg = '#993939', guibg = '#31353f' }, false)
vim.highlight.create('DapLogPoint', { ctermbg = 0, guifg = '#61afef', guibg = '#31353f' }, false)
vim.highlight.create('DapStopped', { ctermbg = 0, guifg = '#98c379', guibg = '#31353f' }, false)

fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

----------------------------------
--       gitsigns config
----------------------------------
require('gitsigns').setup {}

----------------------------------
--          hop config
----------------------------------
require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }

----------------------------------
--          LSP config
----------------------------------
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('goto-preview').setup {
	opacity = 7
}

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
--        Lualine config
----------------------------------
local lualine = require('lualine')

-- Color table for highlights
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
		return vim.fn.empty(vim.fn.expand('%<cmd>t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%<cmd>p:h')
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
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
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
		return '▊'
	end,
	color = { fg = colors.blue }, -- Sets highlighting of component
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
	'filename',
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = 'bold' },
}

ins_left {
	'filesize',
	cond = conditions.buffer_not_empty,
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_right {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
}

ins_right {
	-- LSP server name
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

ins_right {
	'o<cmd>encoding',
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
--     nvim-autopairs config
----------------------------------
require('nvim-autopairs').setup {}

----------------------------------
--        nvim-cmp config
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
			return not context.in_treesitter_capture("comment")
					and not context.in_syntax_group("Comment")
		end
	end,
	formatting = {
		format = function(entry, vim_item)
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

-- disable cmp for dap-repl window
cmp.setup.filetype('dap-repl', {
	enabled = false
})

-- disable cmp for Telescope prompts
cmp.setup.filetype('TelescopePrompt', {
	enabled = false
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
--       nvim-tree config
----------------------------------
require('nvim-tree').setup {}

----------------------------------
--    nvim-treesitter config
----------------------------------
require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'cpp', 'css', 'html', 'java', 'javascript', 'lua', 'python', 'rust', 'yaml' },

	highlight = {
		enable = true,
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
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
	autotag = {
		enable = true,
	},
}

----------------------------------
--        nvterm config
----------------------------------
require('nvterm').setup()

----------------------------------
--     paperplanes config
----------------------------------
require('paperplanes').setup({
	register = '+',
	provider = 'ix.io',
	provider_options = { insecure = true },
	cmd = 'curl',
})

----------------------------------
--       Telescope config
----------------------------------

local command_center = require('command_center')

command_center.add({
	{
		description = 'Open keymap',
		cmd = '<cmd>WhichKey<cr>',
	},
	{
		description = 'Find files',
		cmd = '<cmd>Telescope find_files<cr>',
	},
	{
		description = 'Open recent files',
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
		cmd = '<cmd>%s/\\s\\+$//<cr>:nohlsearch<cr>',
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
		cmd = '<cmd>lua vim.lsp.buf.code_action<cr>',
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
		description = 'Toggle symbols outline',
		cmd = '<cmd>SymbolsOutline<cr>',
	},
	{
		description = 'Toggle floating terminal',
		cmd = '<cmd>lua require("nvim.terminal").toggle("float")<cr>',
	},
	{
		description = 'Toggle vertical split terminal',
		cmd = '<cmd>lua require("nvim.terminal").toggle("vertical")<cr>',
	},
	{
		description = 'Toggle horizontal split terminal',
		cmd = '<cmd>lua require("nvim.terminal").toggle("horizontal")<cr>',
	},
	{
		description = 'New terminal in vertical split',
		cmd = '<cmd>lua require("nvim.terminal").new("vertical")<cr>',
	},
	{
		description = 'New terminal in horizontal split',
		cmd = '<cmd>lua require("nvim.terminal").new("horizontal")<cr>',
	},
	{
		description = 'Toggle paste mode',
		cmd = '<cmd>:set paste!<cr>',
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

require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--hidden',
			'--line-number',
			'--column',
			'--smart-case',
		},
	},
	extensions = {
		command_center = {
			components = {
				command_center.component.DESCRIPTION,
			},
		},
	}
})

require('telescope').load_extension('command_center')
require('telescope').load_extension('fzf')

----------------------------------
--        trouble config
----------------------------------
require('trouble').setup {}

----------------------------------
--       which-key config
----------------------------------
local wk = require('which-key')

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
		S = 'Surrounding and expand',
	},
	B = 'Jump to beginning of line',
	b = {
		b = 'Toggle breakpoint',
		c = '[DAP] Continue',
		f = '[DAP] List frames',
		i = '[DAP] Step into',
		l = '[DAP] List breakpoints',
		o = '[DAP] Step over',
		O = '[DAP] Step out',
		t = '[DAP] Terminate',
		v = '[DAP] List variables'
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
	D = 'Preview symbol information',
	E = 'Jump to end of line',
	g = {
		b = 'Toggle comment blockwise',
		c = 'Toggle comment linewise',
		d = 'Jump to definition for symbol under cursor',
		D = 'Jump to decleration for symbol under cursor',
		p = 'Open definition preview for symbol under cursor',
		P = 'Close all preview windows',
		R = 'Open references quickfix window for symbol under cursor',
		r = 'Open references preview for symbol under cursor',
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
		b = 'Search open buffers',
		f = 'Search file',
		l = 'Search in current file',
		m = 'Open bookmarks',
		r = 'Open recent file',
	},
	p = {
		c = 'a class',
		f = 'a function',
	},
	q = {
		a = 'Quit all',
		q = 'Close buffer',
	},
	r = {
		g = 'Replace all',
		l = 'Replace on line only',
		n = 'Rename symbol under cursor',
		w = 'Rename word under cursor',
	},
	s = {
		c = 'Clear all execution results',
		r = 'Execute line of code',
		q = 'Stop currently executing code',
	},
	S = 'Move line down',
	t = {
		h = 'Open colorschemes',
	},
	v = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
	},
	w = {
		l = 'Jump to line',
		q = 'Save and quit',
		r = 'Save',
		w = 'Jump to word',
	},
	W = 'Move line up',
	y = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
		s = 'Add surrounding',
		S = 'Add surrounding and expand',
		['ss'] = 'Add surrounding to entire line',
	},
	Y = 'Copy until end of line',
	z = {
		f = {
			a = {
				c = 'a class',
				f = 'a function',
			},
			i = {
				c = 'a class',
				f = 'a function',
			},
		},
	},
	['<space>'] = {
		d = 'Open type definiton for symbol under cursor',
		e = 'Open diagnostics window',
		f = 'Format current file',
		p = 'Open command center',
		t = 'Toggle trouble menu',
		w = {
			a = 'Add workspace folder',
			l = 'List workspace folders',
			r = 'Remove workspace folder',
		},
	},
	['<leader>'] = {
		['cf'] = 'Open nvim config',
		d = {
			w = 'Trim trailing whitespace',
			m = 'Delete ^M carriage characters',
		},
		t = {
			d = 'Toggle document diagnostics',
			l = 'Toggle location list',
			j = 'Jump to buffer',
			q = 'Toggle quickfix list',
			w = 'Toggle workspace diagnostics',
		},
		['<space>'] = 'Unhighlight search results',
	},
	['!'] = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
	},
	['<'] = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
	},
	['>'] = {
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
	},
	[';'] = 'Input command',
	['\\'] = 'Search through all files',
	['<c-b>'] = 'Toggle DAP sidebar',
	['<c-k>'] = 'Open signature help',
	['<c-l>'] = 'Unhighlight search results',
	['<c-n>'] = 'Toggle file tree',
	['<c-q>'] = 'Close selected window',
	['<c-v>'] = 'Split window vertically',
	['<c-x>'] = 'Split window horizontally',
	['<c-space>'] = 'Trigger autocomplete',
	['<F1>'] = 'Goto previous location',
	['<F2>'] = 'Goto next location',
	['<F3>'] = 'Toggle symbols outline',
	['<cr>'] = 'Insert blankline',
	['<m-t>'] = 'Toggle floating terminal',
	['<Left>'] = 'Previous buffer',
	['<Right>'] = 'Next buffer',
	['<s-left>'] = 'Move buffer left',
	['<s-Right>'] = 'Move buffer right',
	['<LeftDrag>'] = 'Move mouse cursor',
	['<bs>'] = 'Delete line',
	['<A-t>'] = 'Toggle floating terminal',
	['<A-v>'] = 'Toggle terminal in vertical split',
	['<A-x>'] = 'Toggle terminal in horizontal split',
	['<A-V>'] = 'New terminal in vertical split',
	['<A-X>'] = 'New terminal in horizontal split',
})
