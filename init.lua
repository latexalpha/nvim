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

-- require settings according to the OS
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
if binaryformat == "dll" then
	g.python3_host_prog = "C:/Users/heihi/miniconda3/python"
	-- set the Nvim python virtual environment
	vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "\\python.exe"
    ]])

	-- -------------------VimTeX settings-------------------
	g.tex_flavor = "latex"
	g.vimtex_compiler_method = "latexmk"
	g.vimtex_indent_bib_enabled = true
	g.vimtex_format_enabled = false
	g.vimtex_view_general_viewer = "SumatraPDF"
	g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
	--
elseif binaryformat == "so" then
	g.python3_host_prog = "/home/xxxxx/miniconda3/bin/python"
	-- set the Nvim python virtual environment
	vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
    ]])
end
binaryformat = nil

-- bootstrap lazy.nvim
-- FUNCTIONALITY: bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- use lazy.nvim to manage plugins
require("lazy").setup({
	-- importing directories
	spec = {
		{ import = "plugins" },
		{ import = "plugins.coding" },
		{ import = "plugins.ui" },
	},
	-- ui config
	ui = {
		border = "double",
		size = {
			width = 0.8,
			height = 0.8,
		},
	},
	-- check updated
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

-- colorscheme
vim.cmd.colorscheme("catppuccin")

require("core.keymaps")
require("core.options")
