-- PLUGIN: catppuccin/nvim
-- FUNCTIONALITY: A soothing pastel theme for Neovim
-- THEME VARIANTS: latte (light), frappe (medium-dark), macchiato (darker), mocha (darkest)
-- GITHUB: https://github.com/catppuccin/nvim

return {
	"catppuccin/nvim",
	name = "catppuccin", -- Set plugin name for easier reference
	lazy = false, -- Load during startup since it's a colorscheme
	priority = 1000, -- High priority ensures it loads before other plugins

	opts = {
		-- Core theme configuration
		flavour = "mocha", -- Default theme variant (darkest option)
		background = { -- Map Vim's background option to theme variants
			light = "latte", -- Use latte when 'background=light'
			dark = "mocha", -- Use mocha when 'background=dark'
		},

		-- Appearance options
		transparent_background = false, -- Set true for transparent background
		show_end_of_buffer = false, -- Hide '~' characters after end of buffer
		term_colors = false, -- Set terminal colors (vim.g.terminal_color_*)
		dim_inactive = { -- Dim inactive windows
			enabled = false, -- Set to true to enable this feature
			shade = "dark", -- The shade to use for dimming
			percentage = 0.15, -- Dimming percentage
		},

		-- Typography settings
		no_italic = false, -- Set true to disable italic styles completely
		no_bold = false, -- Set true to disable bold styles completely

		-- Syntax highlighting style customization
		styles = {
			comments = { "italic" }, -- Italic comments for better distinction
			conditionals = { "italic" }, -- Italic conditionals (if, else, etc.)
			loops = {}, -- Default style for loops (for, while, etc.)
			functions = {}, -- Default style for functions
			keywords = {}, -- Default style for keywords
			strings = {}, -- Default style for strings
			variables = {}, -- Default style for variables
			numbers = {}, -- Default style for numbers
			booleans = {}, -- Default style for booleans
			properties = {}, -- Default style for properties
			types = {}, -- Default style for types
			operators = {}, -- Default style for operators
		},

		-- Color customization
		color_overrides = {
			-- Uncomment and customize to override specific colors
			-- all = {
			--     text = "#ffffff",      -- Override text color in all themes
			-- },
			-- mocha = {
			--     base = "#181825",      -- Override base background in mocha
			--     surface0 = "#313244",  -- Override surface0 in mocha
			-- },
		},

		-- Custom highlights
		custom_highlights = {
			-- Uncomment and customize to add custom highlight groups
			-- Comment = { fg = "#a6adc8" },
			-- LineNr = { fg = "#6c7086" },
		},

		-- Plugin integrations
		integrations = {
			cmp = true, -- nvim-cmp completion menu
			gitsigns = true, -- Git change indicators
			nvimtree = true, -- NvimTree file explorer
			telescope = true, -- Telescope fuzzy finder UI
			notify = false, -- nvim-notify pop-up notifications
			mini = false, -- mini.nvim plugin suite

			-- Uncomment to enable additional integrations
			-- mason = true,          -- mason.nvim UI
			-- which_key = true,      -- which-key.nvim help popup
			-- indent_blankline = { enabled = true },  -- indent guides
			-- native_lsp = {
			--     enabled = true,
			--     virtual_text = {
			--         errors = { "italic" },
			--         hints = { "italic" },
			--         warnings = { "italic" },
			--         information = { "italic" },
			--     },
			--     underlines = {
			--         errors = { "underline" },
			--         hints = { "underline" },
			--         warnings = { "underline" },
			--         information = { "underline" },
			--     },
			--     inlay_hints = { background = true },
			-- },
		},
	},

	config = function(_, opts)
		-- Initialize the theme with our configuration
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)

		-- Apply the colorscheme
		vim.cmd.colorscheme("catppuccin")

		-- Set terminal colors to match theme
		-- vim.g.terminal_color_0 = "#45475a"  -- black
		-- vim.g.terminal_color_1 = "#f38ba8"  -- red
		-- ...etc for other colors if needed
	end,
}
