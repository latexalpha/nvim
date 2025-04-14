-- PLUGIN: telescope.nvim
-- FUNCTIONALITY: Highly extensible fuzzy finder over lists
-- FEATURES:
--  - Find files by name with blazing fast performance
--  - Search content across files with live grep
--  - Browse and search buffers, help tags, keymaps, and more
--  - Highly customizable UI and behavior
--  - Extensible with custom pickers and sorters

local map = vim.keymap.set

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter", -- Load at startup
	cmd = "Telescope", -- Also load when the Telescope command is used
	-- version = "0.1.x",           -- Use stable version

	-- Required dependencies
	dependencies = {
		"nvim-lua/plenary.nvim", -- Lua functions library required by Telescope
		{
			"nvim-telescope/telescope-fzf-native.nvim", -- C-based fuzzy sorter for better performance
			build = "make", -- Compile the native sorter
		},
	},

	config = function()
		-- Import the required modules
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		-- Configure telescope
		telescope.setup({
			-- Core configuration
			defaults = {
				-- Interface appearance
				prompt_prefix = " ", -- Icon for the prompt
				selection_caret = " ", -- Icon for the selection
				path_display = { "truncate" }, -- How to display paths

				-- Behavior settings
				sorting_strategy = "ascending", -- Show results from top to bottom
				layout_strategy = "horizontal", -- Horizontal layout
				layout_config = {
					horizontal = {
						prompt_position = "top", -- Show prompt at top
						preview_width = 0.55, -- Width of preview window
						results_width = 0.8, -- Width of results window
					},
					width = 0.87, -- Window width (87% of screen)
					height = 0.80, -- Window height (80% of screen)
					preview_cutoff = 120, -- Min width needed for preview
				},

				-- File settings
				file_ignore_patterns = { -- Patterns to ignore
					"node_modules",
					".git/",
					"dist/",
				},
			},

			-- Extension configuration
			-- extensions = {
			-- fzf = {
			-- fuzzy = true,                -- Enable fuzzy search
			-- override_generic_sorter = true, -- Override default sorter
			-- override_file_sorter = true, -- Override file sorter
			-- case_mode = "smart_case",    -- Case-insensitive if pattern is lowercase
			-- },
			-- }
		})

		-- Load extensions
		-- telescope.load_extension("fzf")

		-- Define keymappings for telescope features
		-- File navigation
		map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Search in files" })

		-- Vim navigation
		map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })

		-- Additional useful pickers (uncomment to use)
		-- map("n", "<leader>fs", builtin.treesitter, { desc = "Find symbols" })
		-- map("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })

		-- Git integration
		-- map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
		-- map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
	end,
}
