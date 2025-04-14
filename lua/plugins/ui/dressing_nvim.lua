-- PLUGIN: dressing.nvim
-- FUNCTIONALITY: Improves the default Neovim UI for input and select dialogs
--
-- FEATURES:
-- - Enhanced text input interface with history navigation
-- - Better selection menus that integrate with telescope and other pickers
-- - Fully customizable appearance and behavior
-- - Seamless replacement for vim.ui.input and vim.ui.select

return {
	"stevearc/dressing.nvim",
	lazy = true, -- Only load when needed by other plugins
	event = "VeryLazy", -- Load after startup is complete

	opts = {
		-- Input dialog configuration (vim.ui.input)
		input = {
			enabled = true, -- Enable enhanced input dialogs

			-- Appearance settings
			default_prompt = "Input:", -- Default prompt text
			prompt_align = "center", -- Center-align the prompt text
			title_pos = "center", -- Center-align the window title
			relative = "cursor", -- Position dialog relative to cursor

			-- Behavior settings
			insert_only = true, -- Restrict to insert mode only
			start_in_insert = true, -- Start with insert mode active
			border = "rounded", -- Use rounded borders for the window

			-- Size and position
			min_width = 20, -- Minimum width of input window
			max_width = 50, -- Maximum width of input window

			-- Keymappings for input dialog
			mappings = {
				n = { -- Normal mode mappings
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = { -- Insert mode mappings
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev", -- Navigate input history
					["<Down>"] = "HistoryNext", -- Navigate input history
				},
			},
		},

		-- Selection dialog configuration (vim.ui.select)
		select = {
			enabled = true, -- Enable enhanced select dialogs

			-- Backend preference (tries each in order)
			backend = {
				"telescope", -- 1. Use Telescope if available
				"fzf_lua", -- 2. Use fzf-lua if available
				"fzf", -- 3. Use fzf if available
				"builtin", -- 4. Use builtin UI if needed
				"nui", -- 5. Use nui.nvim as fallback
			},

			-- Telescope specific settings
			telescope = {
				layout_config = { -- Custom layout for telescope picker
					width = 0.5, -- Use 50% of screen width
					height = 0.6, -- Use 60% of screen height
				},
			},

			-- Keymappings for select dialog
			mappings = {
				["<Esc>"] = "Close",
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<C-j>"] = "Next", -- Navigate to next option
				["<C-k>"] = "Prev", -- Navigate to previous option
			},
		},
	},

	config = function(_, opts)
		-- Initialize the plugin with our configuration
		require("dressing").setup(opts)

		-- You can add additional customization here if needed:
		-- Examples:
		-- - Override specific vim.ui functions
		-- - Add custom theming based on colorscheme
	end,
}
