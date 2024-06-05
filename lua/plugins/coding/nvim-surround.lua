-- PLUGIN: nvim-surround
-- FUNCTIONALITY: add surrounds
return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
