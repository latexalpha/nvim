-- PLUGIN: barbecue.nvim
-- FUNCTIONALITY: VS Code style winbar
return {
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = true,
}
