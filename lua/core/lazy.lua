-- bootstrap lazy.nvim
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
		{ import = "plugins.lsp" },
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

-- personal specs
require("core.keymaps")
require("core.options")
