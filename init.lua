local g = vim.g

-- set `mapleader` before lazy so mappings are correct
g.mapleader = " "
g.maplocalleader = " "

-- disable netrw at the very start of init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- vim.o.cmdheight = 0 -- hide cmd line when inactive

-- keymap settings
local map = vim.keymap.set

map({ "n", "i", "x" }, "jk", "<ESC>")
map("t", "jk", "C-\\><C-n>")
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected texts down. " })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected texts up. " })
map("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit buffer " })
map("n", "<leader>wt", "<CMD>w<CR>", { desc = "Write buffer. " })
map("n", "<leader>wq", "<CMD>wq<CR>", { desc = "Write and quit " })
map("n", "<leader>hl", "<cmd>noh<CR>", { desc = "NO highlight " })
map("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Checkhealth" })
-- keymaps for diagnostics
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window. " })
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic in the current buffer " })
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Get the next diagnostic closest to the cursor position. " })
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list. " })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
	end,
})

-- option settings
local opt = vim.opt
opt.clipboard = "unnamedplus" -- clipboard
opt.number = true -- show line number
opt.relativenumber = true -- relative line number
opt.tabstop = 4 -- indent
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = true -- wrap
opt.cursorline = true -- cursor
opt.mouse:append("a") -- mouse
opt.splitright = true -- new window location
opt.splitbelow = true
opt.ignorecase = true -- search
opt.smartcase = true
opt.termguicolors = true -- true colors
opt.signcolumn = "yes"
opt.list = true -- lists
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- OS specific settings
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
if binaryformat == "dll" then
	g.python3_host_prog = "~/miniconda3/python" -- set the Nvim python virtual environment
	vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "\\python.exe"
        elseif has("nvim") && !empty($VIRTUAL_ENV)
            let g:python3_host_prog = $VIRTUAL_ENV. "\\Scripts\\python.exe"
    ]])
	-- VimTeX settings for Windows
	g.tex_flavor = "latex"
	g.vimtex_compiler_method = "latexmk"
	g.vimtex_indent_bib_enabled = true
	g.vimtex_format_enabled = false
	g.vimtex_view_general_viewer = "SumatraPDF"
	g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
elseif binaryformat == "so" then
	g.python3_host_prog = "~/miniconda3/bin/python" -- set the Nvim python virtual environment
	vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
        elseif has("nvim") && !empty($VIRTUAL_ENV)
            let g:python3_host_prog = $VIRTUAL_ENV . "/bin/python"
    ]])
end
binaryformat = nil

-- bootstrap lazy.nvim
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
require("lazy").setup({
	spec = { -- importing directories
		{ import = "plugins" },
		{ import = "plugins.coding" },
		{ import = "plugins.ui" },
	},
	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		versions = true, -- Honor versions in pkg sources
		-- the first package source that is found for a plugin will be used.
		sources = {
			"lazy",
			"rockspec",
			"packspec",
		},
	},
	rocks = {
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/",
	},
	ui = { -- ui config
		border = "double",
		size = {
			width = 0.8,
			height = 0.8,
		},
	},
	checker = { -- check updates
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

vim.cmd.colorscheme("catppuccin") -- colorscheme
