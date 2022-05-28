--================================================
--                Neovim Config
--    Author: Zane Bilous
--    Last Modified: 05/28/2022
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
nmap('<C-h>', [[<c-\><c-n><c-w>h]]) -- easy window navigation
nmap('<C-j>', [[<c-\><c-n><c-w>j]])
nmap('<C-k>', [[<c-\><c-n><c-w>k]])
nmap('<C-l>', [[<c-\><c-n><c-w>l]])
nmap('<leader><space>', '<cmd>nohlsearch<cr>') -- Turn off search highlight
nmap('rg', ':%s/') -- Replace
nmap('rl', ':s/')
nmap('rw', ':%s/\\<<C-r><C-w>\\>/')
nmap('qq', '<cmd>Bdelete<cr>') -- Buffers
nmap('<C-v>', '<cmd>vsp<cr>') -- Splits
nmap('<C-x>', '<cmd>sp<cr>')
nmap('<leader>dw', '<cmd>%s/\\s\\+$//<cr>:nohlsearch<cr>') -- delete trailing whitespace
nmap('<leader>dm', '<cmd>%s/^M//g<cr>') -- delete ^M
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
nmap('wj', '<cmd>BufferLinePick<cr>')

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

-- fm-nvim mappings
nmap('<A-r>', '<cmd>Ranger<cr>')

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
nmap('fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('fm', '<cmd>Telescope marks<cr>')
nmap('fr', '<cmd>Telescope oldfiles<cr>')
nmap('<space><space>', '<cmd>Telescope command_center<cr>')
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

-- LSP mappings
-- These only bind when an LSP is attached
local on_attach = function(client, bufnr)
	g.code_action_menu_show_details = false
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v<cmd>lua.vim.lsp.omnifunc')

	nmap_buf(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	nmap_buf(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	nmap_buf(bufnr, 'D', '<cmd>lua vim.lsp.buf.hover()<cr>')
	nmap_buf(bufnr, 'gi', 'cmd>lua vim.lsp.buf.implementation()<cr>')
	nmap_buf(bufnr, '<space>h', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	nmap_buf(bufnr, '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
	nmap_buf(bufnr, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	nmap_buf(bufnr, '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	nmap_buf(bufnr, 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	nmap_buf(bufnr, 'ca', '<cmd>CodeActionMenu<cr>')
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
		{ 'catppuccin/nvim', as = 'catppuccin' },
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
		{ 'akinsho/toggleterm.nvim' }, -- better terminals
		{ 'folke/which-key.nvim' }, -- shortcut popup
		{ 'FeiyouG/command_center.nvim' }, -- command palette
		{ 'folke/trouble.nvim' }, -- aesthetic diagnostics page
		{ 'goolord/alpha-nvim' }, -- fancy start page
		{ 'kosayoda/nvim-lightbulb' }, -- show a lightbulb for code actions
		{ 'kyazdani42/nvim-tree.lua' }, -- filetree
		{ 'kyazdani42/nvim-web-devicons' }, -- file icons
		{ 'lewis6991/gitsigns.nvim' }, -- git integration
		{ 'nvim-lua/plenary.nvim' }, -- dependency
		{ 'nvim-lua/popup.nvim' }, -- dependency
		{ 'nvim-lualine/lualine.nvim' }, -- status line
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
end)

----------------------------------
--             Colors
----------------------------------
cmd [[ colorscheme catppuccin ]]

local catppuccin_colors = require('catppuccin.api.colors').get_colors()

-- Highlight colors for DAP gutter symbols
vim.highlight.create('DapBreakpoint', { ctermbg = 0, guifg = catppuccin_colors.red, guibg = catppuccin_colors.mantle }, false)
vim.highlight.create('DapLogPoint', { ctermbg = 0, guifg = catppuccin_colors.blue, guibg = catppuccin_colors.mantle }, false)
vim.highlight.create('DapStopped', { ctermbg = 0, guifg = catppuccin_colors.green, guibg = catppuccin_colors.mantle }, false)

-- Highlight color for SymbolsOutline preview popup
vim.highlight.create('Pmenu', { ctermbg = 0, guifg = catppuccin_colors.text, guibg = catppuccin_colors.mantle }, false)

-- Highlights for Sniprun

vim.highlight.create('SniprunVirtualTextOk', { ctermbg = 0, guifg = catppuccin_colors.blue, guibg = catppuccin_colors.mantle }, false)
vim.highlight.create('SniprunVirtualTextErr', { ctermbg = 0, guifg = catppuccin_colors.red, guibg = catppuccin_colors.mantle }, false)
vim.highlight.create('SniprunFloatingWinOk', { ctermbg = 0, guifg = catppuccin_colors.blue, guibg = catppuccin_colors.mantle }, false)
vim.highlight.create('SniprunFloatingWinErr', { ctermbg = 0, guifg = catppuccin_colors.red, guibg = catppuccin_colors.mantle }, false)

--================================================
--                Plugin Configs
--================================================

----------------------------------
--         alpha config
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
		button('\\', '  ripgrep'),
		button('f m', '  Bookmarks  '),
		button(', c f', '  Configuration'),
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

-- Reenable bufferline/statusline outside of alpha
autocmd('FileType', {
	pattern = '*',
	callback = function()
		opt.showtabline = 3
		opt.laststatus = 3
	end,
})

-- Disable bufferline/statusline in alpha
autocmd('FileType', {
	pattern = 'alpha',
	callback = function()
		opt.showtabline = 0
		opt.laststatus = 0
	end,
})
----------------------------------
--      auto-session config
----------------------------------
require('auto-session').setup {
	auto_session_suppress_dirs = { '~' },
}

----------------------------------
--      bufferline config
----------------------------------
require('bufferline').setup {
	options = {
		always_show_bufferline = true,
		buffer_close_icon = "",
		close_icon = "",
		diagnostics = false,
		enforce_regular_tabs = false,
		left_trunc_marker = "",
		max_name_length = 14,
		max_prefix_length = 13,
		modified_icon = "",
		offsets = { { filetype = 'NvimTree', padding = 1 } },
		right_trunc_marker = "",
		separator_style = "thin",
		show_close_icon = false,
		show_tab_indicators = true,
		show_buffer_close_icons = true,
		tab_size = 20,
		themable = true,
		view = "multiwindow",
	},
}

----------------------------------
--     better-escape config
----------------------------------
require('better_escape').setup {
	mapping = { 'jk' },
}

----------------------------------
--       catppuccin config
----------------------------------
require('catppuccin').setup {
	integrations = {
		lightspeed = true,
	},
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

-- Gutter symbols
fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

----------------------------------
--        fm-nvim config
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
require('lightspeed').setup {}

----------------------------------
--          LSP config
----------------------------------
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
--        Lualine config
----------------------------------
local lualine = require('lualine')

-- Color table for highlights
local lualine_colors = {
	fg       = catppuccin_colors.text,
	yellow   = catppuccin_colors.yellow,
	cyan     = catppuccin_colors.teal,
	darkblue = catppuccin_colors.sapphire,
	green    = catppuccin_colors.green,
	orange   = catppuccin_colors.peach,
	violet   = catppuccin_colors.lavender,
	magenta  = catppuccin_colors.mauve,
	blue     = catppuccin_colors.blue,
	red      = catppuccin_colors.red,
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
		disabled_filetypes = {
			'alpha',
			'dapui_breakpoints',
			'dapui_hover',
			'dapui_repl',
			'dapui_stacks',
			'dapui_scopes',
			'dapui_watches',
			'Outline',
			'TelescopePrompt',
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
		return '▊'
	end,
	color = { fg = lualine_colors.violet }, -- Sets highlighting of component
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
			n = lualine_colors.red,
			i = lualine_colors.green,
			v = lualine_colors.blue,
			V = lualine_colors.blue,
			c = lualine_colors.magenta,
			no = lualine_colors.red,
			s = lualine_colors.orange,
			S = lualine_colors.orange,
			[''] = lualine_colors.orange,
			ic = lualine_colors.yellow,
			R = lualine_colors.violet,
			Rv = lualine_colors.violet,
			cv = lualine_colors.red,
			ce = lualine_colors.red,
			r = lualine_colors.cyan,
			rm = lualine_colors.cyan,
			['r?'] = lualine_colors.cyan,
			['!'] = lualine_colors.red,
			t = lualine_colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
}

ins_left {
	'filename',
	cond = conditions.buffer_not_empty,
	icon = '',
	color = function()
		if vim.api.nvim_buf_get_option(0, 'modified') then
			return { fg = lualine_colors.green, gui = 'bold' }
		end
		return { fg = lualine_colors.magenta, gui = 'bold' }
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
	color = { fg = lualine_colors.violet, gui = 'bold' },
}

ins_right {
	'diff',
	symbols = { added = ' ', modified = '柳', removed = ' ' },
	diff_color = {
		added = { fg = lualine_colors.green },
		modified = { fg = lualine_colors.orange },
		removed = { fg = lualine_colors.red },
	},
	cond = conditions.hide_in_width,
}
ins_right {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
	diagnostics_color = {
		color_error = { fg = lualine_colors.red },
		color_warn = { fg = lualine_colors.yellow },
		color_info = { fg = lualine_colors.cyan },
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
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
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
			return { fg = lualine_colors.red }
		end

		return { fg = lualine_colors.green, gui = 'bold' }
	end,

}

ins_right {
	'o<cmd>encoding',
	fmt = string.upper,
	cond = conditions.hide_in_width,
	color = { fg = lualine_colors.cyan, gui = 'bold' },
	icon = '',
}

ins_right {
	'fileformat',
	fmt = string.upper,
	icons_enabled = false,
	color = { fg = lualine_colors.cyan, gui = 'bold' },
}

ins_right {
	function()
		return '▐'
	end,
	color = { fg = lualine_colors.violet },
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
			return not context.in_treesitter_capture('comment')
					and not context.in_syntax_group('Comment')
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
	ensure_installed = { 'c', 'cpp', 'css', 'html', 'java', 'javascript', 'lua', 'python', 'rust', 'yaml' },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "vn",
			node_incremental = "vnn",
			scope_incremental = "vnc",
			node_decremental = "vnp",
		},
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
--     paperplanes config
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
--       Telescope config
----------------------------------
require('telescope').setup {
	defaults = {
		border = {},
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
			horizontal = {
				prompt_position = 'top',
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		layout_strategy = 'horizontal',
		path_display = { 'truncate' },
		prompt_prefix = '   ',
		selection_caret = '  ',
		selection_strategy = 'reset',
		sorting_strategy = 'ascending',
		use_less = true,
		vimgrep_arguments = {
			'rg',
			'--hidden',
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
----------------------------------
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
--        trouble config
----------------------------------
require('trouble').setup {}

----------------------------------
--     command center config
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
		description = 'Open ranger',
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
	icons = {
		separator = '⟷',
	},
	ignore_missing = true,
	key_labels = {
		['<space>'] = 'Space',
		['<BS>'] = 'Backspace',
		['<CR>'] = 'Enter',
		['<Tab>'] = 'Tab',
		['<C-B>'] = 'Ctrl + b',
		['<C-H>'] = 'Ctrl + h',
		['<C-J>'] = 'Ctrl + j',
		['<C-K>'] = 'Ctrl + k',
		['<C-L>'] = 'Ctrl + l',
		['<C-F>'] = 'Ctrl + f',
		['<C-Q>'] = 'Ctrl + q',
		['<C-V>'] = 'Ctrl + v',
		['<c-w>'] = 'Ctrl + w',
		['<C-X>'] = 'Ctrl + x',
		['<c-space>'] = 'Ctrl + space',
		['<M-g>'] = 'Alt + g',
		['<M-h>'] = 'Alt + h',
		['<M-p>'] = 'Alt + p',
		['<M-r>'] = 'Alt + r',
		['<M-t>'] = 'Alt + t',
		['<M-x>'] = 'Alt + x',
		['<F1>'] = 'F1',
		['<F2>'] = 'F2',
		['<F3>'] = 'F3',
		['<Right>'] = '⇒',
		['<Left>'] = '⬅',
		['<S-Right>'] = 'Shift + ⇒',
		['<S-Left>'] = 'Shift + ⬅',
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
	B = 'Jump to first char of line',
	b = {
		name = 'DAP',
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
	e = {
		name = 'Code execution',
		c = 'Clear all execution results',
		l = 'Toggle live code execution',
		r = 'Execute line of code',
		q = 'Stop currently executing code',
	},
	E = 'Jump to end of line',
	g = {
		b = 'Toggle comment blockwise',
		c = 'Toggle comment linewise',
		d = 'Jump to definition for symbol under cursor',
		D = 'Jump to decleration for symbol under cursor',
		p = 'Open definition preview for symbol under cursor',
		P = 'Close all preview windows',
		R = 'Open references quickfix window for symbol under cursor',
		s = 'Switch symbol under cursor',
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
		name = 'Files',
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
		q = 'Close current buffer',
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
		a = {
			c = 'a class',
			f = 'a function',
		},
		i = {
			c = 'a class',
			f = 'a function',
		},
		r = 'Execute code',
	},
	w = {
		name = 'Save / Jump',
		j = 'Jump to buffer',
		q = 'Save and quit',
		r = 'Save',
	},
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
		['<space>'] = 'Open command center',
		d = 'Open type definiton for symbol under cursor',
		e = 'Open diagnostics window',
		f = 'Format current file',
		k = 'Open keymap',
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
	['<c-h>'] = 'Go to window left',
	['<c-l>'] = 'Go to window right',
	['<C-j>'] = 'Go to window down',
	['<c-k>'] = 'Go to window up',
	['<c-f>'] = 'Toggle file tree',
	['<c-q>'] = 'Close selected window',
	['<c-v>'] = 'Split window vertically',
	['<c-x>'] = 'Split window horizontally',
	['<c-space>'] = 'Trigger autocomplete',
	['<A-t>'] = 'Toggle floating terminal',
	['<A-x>'] = 'Toggle terminal in horizontal split',
	['<A-p>'] = 'Toggle ipython',
	['<A-h>'] = 'Toggle htop',
	['<A-g>'] = 'Toggle lazygit',
	['<A-r>'] = 'Open ranger',
	['<F1>'] = 'Goto previous location',
	['<F2>'] = 'Goto next location',
	['<F3>'] = 'Toggle symbols outline',
	['<Left>'] = 'Previous buffer',
	['<Right>'] = 'Next buffer',
	['<s-left>'] = 'Move buffer left',
	['<s-Right>'] = 'Move buffer right',
	['<cr>'] = 'Insert blankline',
	['<bs>'] = 'Delete line',
	['<space>h'] = 'Open signature help',
})
