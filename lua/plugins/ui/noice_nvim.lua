-- PLUGIN: noice.nvim
-- FUNCTIONALITY: Enhanced UI for messages, cmdline, and popups
-- FEATURES:
-- - Replaces the standard message, cmdline and popups UIs
-- - LSP progress and signature help integration
-- - Custom command history view
-- - Highly configurable layout and appearance

local map = vim.keymap.set

return {
	"folke/noice.nvim",
	event = "VeryLazy", -- Load after startup for better performance

	-- Required dependencies
	dependencies = {
		{
			"MunifTanjim/nui.nvim", -- UI component library
			lazy = true, -- Load only when needed
		},
		{
			"rcarriga/nvim-notify", -- Notification manager
			config = function()
				require("notify").setup({
					background_colour = "#1e1e2e", -- Catppuccin-like background
					merge_duplicates = true, -- Merge duplicate notifications into one
					-- Uncomment for additional notify configuration:
					-- timeout = 3000,              -- Notification timeout in ms
					-- max_width = 80,              -- Max width of notifications
					-- render = "default",          -- Display style
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp", -- Completion plugin (required for documentation override)
		},
	},

	opts = {
		-- LSP message handling configuration
		lsp = {
			progress = { enabled = false }, -- Disable LSP progress notifications
			-- signature = { enabled = false },  -- Uncomment to disable signature help

			-- Override standard LSP methods to use Noice's improved rendering
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- Improve markdown rendering
				["vim.lsp.util.stylize_markdown"] = true, -- Enable markdown styling
				["cmp.entry.get_documentation"] = true, -- Enhance completion documentation
			},
		},

		-- Enable helpful presets
		presets = {
			bottom_search = false, -- Use floating window for search (not bottom line)
			command_palette = false, -- Don't use command palette mode
			long_message_to_split = true, -- Show long messages in split window
			lsp_doc_border = true, -- Add border to LSP documentation
			-- Uncomment for additional presets:
			-- inc_rename = true,            -- Enable incremental rename UI
		},

		-- Customize individual UI components
		views = {
			-- Command line popup configuration
			cmdline_popup = {
				style = "none", -- No border around cmdline
				-- style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },  -- Uncomment for custom border
				padding = { 1, 3 }, -- Add padding around content
				position = { row = 20, col = "50%" }, -- Position near middle of screen
				size = { width = "40%", height = "auto" },
			},

			-- Uncomment to customize messages view:
			messages = {
				enabled = true,
				view = "notify", -- Use notify for standard messages
				view_error = "notify", -- Use notify for error messages
				view_warn = "notify", -- Use notify for warning messages
			},
		},
	},

	config = function(_, opts)
		-- Define keymaps for Noice functionality

		-- View last message
		map("n", "<leader>nl", function()
			require("noice").cmd("last")
		end, { desc = "Noice: Show last message" })

		-- View message history
		map("n", "<leader>nh", function()
			require("noice").cmd("history")
		end, { desc = "Noice: Show message history" })

		-- View all messages
		map("n", "<leader>na", function()
			require("noice").cmd("all")
		end, { desc = "Noice: Show all messages" })

		-- Redirect command output to split
		map("c", "<S-Enter>", function()
			require("noice").redirect(vim.fn.getcmdline())
		end, { desc = "Noice: Redirect command to split" })

		-- Scroll forward in documentation windows
		map({ "i", "n", "s" }, "<c-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-f>"
			end
		end, { silent = true, expr = true, desc = "Scroll forward in documentation" })

		-- Scroll backward in documentation windows
		map({ "i", "n", "s" }, "<c-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-b>"
			end
		end, { silent = true, expr = true, desc = "Scroll backward in documentation" })

		-- Initialize Noice with configured options
		local noice = require("noice")
		noice.setup(opts)
	end,
}
