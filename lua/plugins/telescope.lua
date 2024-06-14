-- PLUGIN: telescope.nvim
-- FUNCTIONALITY: grep search in files
-- telescope.nvim
local map = vim.keymap.set
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		map("n", "<leader>fb", builtin.buffers, { desc = "Telescope bffers" })
		map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find_files" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help_tags" })
		map("n", "<leader>fo", "<cmd>Telescope oldfiles", { desc = "Telescope oldfiles" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live_grep" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })
		require("telescope").setup({})
	end,
}
