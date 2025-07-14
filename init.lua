---- NEOVIM CORE CONFIGURATION
-- Author: heihi
-- Last Update: April 2025
--
-- This is the main Neovim configuration file that loads at startup.
-- It handles basic settings, keymaps, and initializes the plugin manager.

------------------------
-- GLOBAL VARIABLES  --
------------------------
local g = vim.g

-- Leader key configuration (set before plugins load)
g.mapleader = " " -- Space as the leader key
g.maplocalleader = " " -- Space as the local leader key

-- Disable built-in plugins for better performance
g.loaded_netrw = 1 -- Disable built-in file explorer
g.loaded_netrwPlugin = 1
g.loaded_ruby_provider = 0 -- Disable Ruby support
g.loaded_perl_provider = 0 -- Disable Perl support
g.loaded_node_provider = 0 -- Disable NodeJS support

------------------------
-- KEYMAPPINGS        --
------------------------
local map = vim.keymap.set

-- Essential keymaps
map({ "n", "i", "x" }, "jk", "<ESC>", { desc = "Exit to normal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- Fixed syntax error here

-- Text manipulation
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected text down" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected text up" })

-- Split window operations
map("n", "<leader>sh", "<cmd>sp<CR>", { desc = "Horizontal split" })
map("n", "<leader>sv", "<cmd>vsp<CR>", { desc = "Vertical split" })

-- Terminal
map("n", "<Leader>t", ":terminal<CR>", { desc = "Open Terminal" })
map("n", "<Leader>tv", ":vsplit | terminal<CR>", { desc = "Vertical Split Terminal" })
map("n", "<Leader>th", ":split | terminal<CR>", { desc = "Horizontal Split Terminal" })

-- Buffer operations
map("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit buffer" })
map("n", "<leader>wt", "<CMD>w<CR>", { desc = "Write buffer" })
map("n", "<leader>wq", "<CMD>wq<CR>", { desc = "Write and quit" })
map("n", "<leader>hl", "<cmd>noh<CR>", { desc = "Clear search highlighting" })
map("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Run health check" })

------------------------
-- EDITOR OPTIONS     --
------------------------
local opt = vim.opt

-- Clipboard settings
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Line numbers
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers

-- Indentation settings
opt.tabstop = 4 -- Width of tab character
opt.softtabstop = 4 -- Number of spaces for tab in editing operations
opt.shiftwidth = 4 -- Number of spaces for each indent
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from current line when starting new line

-- Display settings
opt.wrap = true -- Wrap long lines
opt.cursorline = true -- Highlight current line
opt.mouse:append("a") -- Enable mouse in all modes
opt.termguicolors = true -- Enable true color support
opt.signcolumn = "yes" -- Always show sign column

-- Split window behavior
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below

-- Search settings
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive when uppercase present

-- Whitespace visualization
opt.list = true -- Show invisible characters
opt.listchars:append("space:⋅") -- Show spaces as middle dots
opt.listchars:append("eol:↴") -- Show end of line as down-right arrow
opt.termguicolors = true -- Enable true color support for proper highlighting

-- -- Spellfile
-- vim.opt.spellfile = vim.fn.expand("%:p:h") .. "/en.utf-8.add"
-- vim.spell = true

------------------------
-- OS-SPECIFIC CONFIG --
------------------------
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")

if binaryformat == "dll" then
	-- Windows-specific configuration

	-- Python host configuration (priority order):
	-- 1. Conda environment (if active)
	-- 2. Virtual environment (if active)
	-- 3. Fallback to global installation
	vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "\\python.exe"
        elseif has("nvim") && !empty($VIRTUAL_ENV)
            let g:python3_host_prog = $VIRTUAL_ENV. "\\Scripts\\python.exe"
        else
            let g:python3_host_prog = "C:\\ZSY_apps\\global_python3_host\\.venv\\Scripts\\python.exe"
        endif
    ]])
	-- Configure for PowerShell on Windows
	vim.o.shell = "pwsh.exe"
	vim.o.shellcmdflag =
		"-NoLogo -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
elseif binaryformat == "so" then
	-- Linux/macOS configuration
	g.python3_host_prog = "~/python_venv/.venv/bin/python3" -- Default Python venv path

	-- Override with environment Python if available
	-- vim.cmd([[
	--        if has("nvim") && !empty($CONDA_PREFIX)
	--            let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
	--        elseif has("nvim") && !empty($VIRTUAL_ENV)
	--            let g:python3_host_prog = $VIRTUAL_ENV . "/bin/python"
	--        endif
	--    ]])
	-- Configure for Bash on Linux (often the default, but good to be explicit)
	vim.o.shell = "bash"
	vim.o.shellcmdflag = "-c"
	vim.o.shellredir = "2>&1 > %s"
	vim.o.shellpipe = "2>&1 | tee %s"
	vim.o.shellquote = "'"
	vim.o.shellxquote = ""
end

binaryformat = nil -- Clean up the variable

------------------------
-- PLUGIN MANAGEMENT --
------------------------
-- Bootstrap lazy.nvim (auto-install if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with configuration
require("lazy").setup({
	-- Plugin specification directories
	spec = {
		{ import = "plugins.basis" }, -- Core plugins
		{ import = "plugins.ui" }, -- UI plugins
	},

	-- Package manager configuration
	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		versions = true, -- Honor versions in package sources
		-- Plugin source priority (first match is used)
		sources = {
			"lazy",
			"rockspec",
			"packspec",
		},
	},

	-- Neorocks configuration
	rocks = {
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/",
	},

	-- UI configuration
	ui = {
		border = "double",
		size = {
			width = 0.8,
			height = 0.8,
		},
	},

	-- Update checker
	checker = {
		enabled = true, -- Enable update checking
		notify = false, -- Don't show notifications
	},

	-- Change detection
	change_detection = {
		notify = false, -- Don't notify on config changes
	},
})
