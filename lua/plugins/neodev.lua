-- PLUGIN: neodev.nvim
-- FUNCTIONALITY: Debugging and development tools for Neovim 
return {
	"folke/neodev.nvim",
	opts = {
		library = {
			plugins = { "nvim-dap-ui" },
			types = true,
		},
	},

	config = function(_, opts)
		require("neodev").setup(opts)
	end,
}
