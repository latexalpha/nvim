-- PLUGIN: nvim-ufo
-- FUNCTIONALITY: folding and unfolding code blocks
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		{
			"kevinhwang91/promise-async",
		},
		{
			"nvim-treesitter/nvim-treesitter",
		},
	},
	config = function()
		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
	end,
}
