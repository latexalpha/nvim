-- PLUGIN: nvim-ufo
-- FUNCTIONALITY: folding and unfolding code blocks
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 9 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 9
vim.o.foldenable = false -- show fold level
-- vim.o.foldenable = true -- show fold level

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
