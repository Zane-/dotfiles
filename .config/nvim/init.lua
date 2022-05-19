--================================================
--                 Neovim Config
--    Author: Zane Bilous
--    Last Modified: 05/18/2022
--    Dependencies:
--      ripgrep, fzf
--================================================

----------------------------------
--           Aliases
----------------------------------
local cmd = vim.cmd -- vim commands
local g   = vim.g -- global for let options
local opt = vim.opt -- global

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
opt.smartcase = true -- override ignore case if uppercase letters in pattern
opt.smartindent = true -- indent after brackets
opt.splitbelow = true -- split splits below
opt.splitright = true -- vertical split splits right
opt.tabstop = 2 -- make tabs 2-spaces wide
opt.undofile = true -- persistent undo
opt.updatetime = 300 -- faster update time

cmd([[
let &showbreak=nr2char(8618).' '
]]) -- show ↪ on wrapped lines

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

g.mapleader = ',' -- remap leader to ,

imap('jk', '<Esc>') -- easy normal mode
nmap(';', ':') -- easy command input
nmap('<leader>w', '<cmd>w!<cr>') -- Quick Save/Quit
nmap('<leader>wq', '<cmd>wq!<cr>')
nmap('<leader>q', '<cmd>q<cr>')
nmap('<leader>qq', '<cmd>q!<cr>')
nmap('B', '^') -- Line navigation
nmap('E', '$')
nmap('j', 'gj') -- move up and down by display rather than line number
nmap('k', 'gk')
nmap('<leader><space>', '<cmd>nohlsearch<cr>') -- Turn off search highlight
nmap('rg', ':%s/') -- Replace
nmap('rl', ':s/')
nmap('rw', ':%s/\\<<C-r><C-w>\\>/')
nmap('tq', '<cmd>bdelete<cr>') -- Buffers
nmap('tt', '<cmd>tabnew<cr>')
nmap('<Left>', '<cmd>bnext<cr>')
nmap('<Right>', '<cmd>bprev<cr>')
nmap('<C-v>', '<cmd>vsp<cr>') -- Splits
nmap('<C-x>', '<cmd>sp<cr>')
nmap('<leader>dw', '<cmd>%s/\\s\\+$//<cr>:nohlsearch<cr>') -- delete trailingqwhitespace
nmap('<leader>dm', '<cmd>%s/^M//g<cr>') -- delete ^M
nmap('<S-s>', '<cmd>m+<cr>') -- move lines with shift+w/s
nmap('<S-w>', '<cmd>m-2<cr>')
nmap('Q', '@q') -- use macros with Q (and in visual mode)
vmap('Q', '<cmd>norm @q<cr>')
vmap('<', '<gv') -- don't unselect after shifting in visual mode
vmap('>', '>gv')
nmap('<cr>', 'o<Esc>') -- insert blank line with enter
nmap('<C-q>', '<cmd>:close<cr>') -- close window

-- disable mouse drag entering visual mode
cmd([[
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>
]])

-- nvim-tree mappings
nmap('<C-n>', '<cmd>NvimTreeToggle<cr>')

-- Telescope mappings
nmap('\\', '<cmd>Telescope live_grep hidden=true<cr>')
nmap('ff', '<cmd>Telescope find_files hidden=true<cr>')
nmap('fb', '<cmd>Telescope buffers<cr>')
nmap('fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('fr', '<cmd>Telescope oldfiles<cr>')
nmap('<space>p', '<cmd>Telescope command_center<cr>')

-- barbar mappings
nmap('bp', '<cmd>BufferPick<cr>')
nmap('<S-Left>', '<cmd>BufferMovePrevious<cr>')
nmap('<S-Right>', '<cmd>BufferMoveNext<cr>')

-- FTerm mappings
nmap('<A-t>',
	'<cmd>lua require("FTerm").toggle()<cr>')
map('t', '<A-t>',
	'<cmd>lua require("FTerm").toggle()<cr>')

-- LSP mappings
nmap('<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
nmap('<F1>', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
nmap('<F2>', '<cmd>lua vim.diagnostic.goto_next()<cr>')

-- These only bind when an LSP is attached
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v<cmd>lua.vim.lsp.omnifunc')
	nmap_buf(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	nmap_buf(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	nmap_buf(bufnr, 'D', '<cmd>lua vim.lsp.buf.hover()<cr>')
	nmap_buf(bufnr, 'gi', 'cmd>lua vim.lsp.buf.implementation()<cr>')
	nmap_buf(bufnr, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	nmap_buf(bufnr, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	nmap_buf(bufnr, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	nmap_buf(bufnr, '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	nmap_buf(bufnr, 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	nmap_buf(bufnr, 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
	nmap_buf(bufnr, '<space>f', '<cmd>lua vim.lsp.buf.format { async = true } <cr>')

	-- goto-preview mappings
	nmap_buf(bufnr, 'gp', '<cmd>lua require("goto-preview").goto_preview_definition()<cr>')
	nmap_buf(bufnr, 'gP', '<cmd>lua require("goto-preview").close_all_win()<cr>')
	nmap_buf(bufnr, 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<cr>')
	nmap_buf(bufnr, 'gr', '<cmd>lua require("goto-preview").goto_preview_references()<cr>')

	-- Trouble mappings
	nmap_buf(bufnr, '<space>t', '<cmd>TroubleToggle<cr>')
	nmap_buf(bufnr, '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
	nmap_buf(bufnr, '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>')
	nmap_buf(bufnr, '<leader>tf', '<cmd>TroubleToggle quickfix<cr>')
	nmap_buf(bufnr, '<leader>tl', '<cmd>TroubleToggle loclist<cr>')
	nmap_buf(bufnr, 'gR', '<cmd>TroubleToggle lsp_references<cr>')

	-- Symbols mappings
	nmap('<F3>', '<cmd>SymbolsOutline<cr>') -- toggle symbols outline
end

-- ensure <cr> isn't remapped during cmd enter and quickfix
cmd([[
augroup cr
	autocmd!
	autocmd CmdwinEnter * nnoremap <cr> <cr>
	autocmd BufReadPost quickfix nnoremap <cr> <cr>
augroup end
]])

-- autoformat on save
cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

-----------------------------------
--            Plugins
-----------------------------------

require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- this package manager

	use 'bronson/vim-trailing-whitespace' -- show trailing whitespace as red bg
	use 'easymotion/vim-easymotion' -- jump to any word with ease
	use 'folke/tokyonight.nvim' -- colorscheme
	use 'glepnir/dashboard-nvim' -- fancy start page
	use 'folke/trouble.nvim' -- aesthetic diagnostics page
	use 'FeiyouG/command_center.nvim' -- command palette
	use 'jbyuki/instant.nvim' -- collaborative editing server
	use 'kosayoda/nvim-lightbulb' -- show a lightbulb for code actions
	use 'lewis6991/gitsigns.nvim' -- git integration
	use 'markonm/traces.vim' -- live preview for substitution
	use 'mfussenegger/nvim-dap' -- debugger
	use 'ms-jpq/coq_nvim' -- completion
	use 'ms-jpq/coq.artifacts' -- snippets
	use 'mxw/vim-jsx' -- jsx syntax support for react
	use 'neovim/nvim-lspconfig' -- completion, go-to, etc.
	use 'numToStr/Comment.nvim' -- comments
	use 'numToStr/FTerm.nvim' -- terminal popup
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lualine/lualine.nvim' -- status line
	use 'nvim-telescope/telescope.nvim' -- aesthetic fuzzyfinder
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-treesitter/nvim-treesitter' -- additional syntax highlighting
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'olimorris/onedarkpro.nvim' -- colorscheme
	use 'stevearc/dressing.nvim' -- use telescope for more things
	use 'roxma/vim-paste-easy' -- auto-enter paste mode on paste
	use 'RRethy/vim-illuminate' -- highlight symbol under cursor
	use 'ryanoasis/vim-devicons' -- add icons to files
	use 'kyazdani42/nvim-tree.lua' -- filetree
	use 'rmagatti/goto-preview' -- goto preview popup
	use 'simrat39/symbols-outline.nvim' -- menu for symbols
	use 'tpope/vim-surround' -- easily change surrounding brackets, quotes, etc.
	use {
		'romgrk/barbar.nvim', -- fancy tabs
		requires = { { 'kyazdani42/nvim-web-devicons' } }
	}
	use 'weilbith/nvim-code-action-menu' -- show diffs for code actions
	use 'williamboman/nvim-lsp-installer' -- install lsp servers
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

--================================================
--                 Plugin Config
--================================================

----------------------------------
--        Comment config
----------------------------------
require('Comment').setup()

----------------------------------
--         coq config
----------------------------------
cmd [[ let g:coq_settings = { 'auto_start': 'shut-up' } ]]

----------------------------------
--       Dashboard config
----------------------------------
g.dashboard_default_executive = 'telescope'

----------------------------------
--       gitsigns config
----------------------------------
require('gitsigns').setup()

----------------------------------
--        instant config
----------------------------------
g.instant_username = "Zane"

----------------------------------
--          LSP config
----------------------------------
require('goto-preview').setup {
	opacity = 10
}

local coq = require('coq')
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
	}
	server:setup(coq.lsp_ensure_capabilities(opts))
end)

----------------------------------
--        Lualine config
----------------------------------
local lualine = require('lualine')

-- Color table for highlights
-- stylua<cmd> ignore
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
	'o<cmd>encoding', -- option component same as &encoding in viml
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
--       nvim-tree config
----------------------------------
require('nvim-tree').setup()

----------------------------------
--    nvim-treesitter config
----------------------------------
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'c', 'cpp', 'css', 'html', 'java', 'javascript', 'lua', 'python', 'rust', 'yaml' },

	highlight = {
		enable = true,
		-- Setting this to true will run `<cmd>h syntax` and tree-sitter at the same time.
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
})

----------------------------------
--       Telescope config
----------------------------------

local command_center = require('command_center')

command_center.add({
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
		description = 'Quit',
		cmd = '<cmd>qa<cr>',
	},
	{
		description = 'Select all',
		cmd = '<cmd>call feedkeys("GVgg")<cr>',
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
		description = 'Open keymap',
		cmd = '<cmd>Telescope keymaps<cr>',
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
		description = 'Open color scheme picker',
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
		description = 'Toggle floating terminal',
		cmd = '<cmd>lua require("FTerm").toggle()<cr>',
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
			'--with-filename',
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
