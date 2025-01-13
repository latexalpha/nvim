-- PLUGIN: nvim-tree
-- FUNCTIONALITY: file explorer
local map = vim.keymap.set
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, -- must set lazy to false
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sort_by = "case_sensitive",
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		view = {
			width = 40,
		},
	},

	config = function(_, opts)
		map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTreeToggle" })
		local nvim_tree = require("nvim-tree")
		nvim_tree.setup(opts)
	end,
}
