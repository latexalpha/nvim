-- PLUGIN: nvim-tree
-- FUNCTIONALITY: file explorer
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,

	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			lazy = true,
		},
	},

	opts = {
		sort_by = "case_sensitive",
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
	},

	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,
}
