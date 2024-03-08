-- FUNCTION: VS Code winbar
return {
	-- https://github.com/utilyre/barbecue.nvim
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = true,
}
