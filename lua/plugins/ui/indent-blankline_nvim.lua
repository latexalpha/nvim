-- PLUGIN: indent-blankline.nvim
-- FUNCTIONALITY: Adds indentation guides to all lines
-- FEATURES: Rainbow indentation with scope highlighting


return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost", -- Load after buffer is read for better performance
	config = function()
		-- Define rainbow colors for indentation levels
		local highlight = {
			"RainbowRed", -- First indentation level
			"RainbowYellow", -- Second indentation level
			"RainbowBlue", -- Third indentation level
			"RainbowOrange", -- Fourth indentation level
			"RainbowGreen", -- Fifth indentation level
			"RainbowViolet", -- Sixth indentation level
			"RainbowCyan", -- Seventh indentation level
		}

		-- Set up hook system for the plugin
		local hooks = require("ibl.hooks")

		-- Register a hook that runs whenever the colorscheme changes
		-- This ensures our custom highlight groups are always available
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Define custom highlight groups with darker colors (40% opacity)
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#8e444b" }) -- Darker red
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#8c764c" }) -- Darker yellow
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#3e6c94" }) -- Darker blue
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#825f3e" }) -- Darker orange
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#5e774b" }) -- Darker green
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#7a4987" }) -- Darker purple
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#366f78" }) -- Darker teal
		end)

		-- Initialize the plugin
		local ibl = require("ibl")
		ibl.setup({
			-- Configure indentation guides
			indent = {
				char = "┊", -- Thinner character for indentation guides
				tab_char = "┊", -- Thinner character for tab indentation
				highlight = highlight, -- Use our rainbow highlight groups
			},

			-- Configure whitespace display
			whitespace = {
				highlight = highlight, -- Use the same rainbow colors for whitespace
				remove_blankline_trail = false, -- Keep trailing whitespace on blank lines
			},

			-- Configure scope highlighting (highlights the current code scope)
			scope = {
				enabled = true, -- Enable scope highlighting
				highlight = highlight, -- Use rainbow colors for scope
				char = "┆", -- Thinner character for scope indication
			},

			-- Exclude certain filetypes (uncomment and modify as needed)
			exclude = {
				filetypes = {
					"help",
					"dashboard",
					"nvim-tree",
					"Trouble",
					"lazy",
				},
			},
		})
	end,
}
