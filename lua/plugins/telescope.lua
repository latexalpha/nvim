-- PLUGIN: telescope.nvim
-- FUNCTIONALITY: grep search in files
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
}
