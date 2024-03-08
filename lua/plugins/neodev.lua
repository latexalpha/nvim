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
