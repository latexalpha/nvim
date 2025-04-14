-- PLUGIN: kanagawa.nvim
-- FUNCTIONALITY: A dark colorscheme for Neovim inspired by the colors of the famous painting by Katsushika Hokusai
-- THEME VARIANTS: wave (default dark), dragon (darker), lotus (light)

return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = false, -- Load during startup since it's a colorscheme
	priority = 1000, -- Set high priority to load before other plugins

	opts = {
		-- Core configuration options
		compile = false, -- Whether to compile the colorscheme (faster startup, but less flexible)
		transparent = false, -- Set to true to disable background color (for transparent terminals)
		dimInactive = false, -- Dim colors in inactive windows
		terminalColors = true, -- Define terminal colors (vim.g.terminal_color_*)

		-- Syntax highlighting style options
		undercurl = true, -- Use undercurls for underlines (requires terminal support)
		commentStyle = { italic = true }, -- Style for comments
		functionStyle = {}, -- Style for function names (empty = normal)
		keywordStyle = { italic = true }, -- Style for keywords
		statementStyle = { bold = true }, -- Style for statements
		typeStyle = {}, -- Style for type definitions (empty = normal)

		-- Theme variants and customization
		theme = "wave", -- Default theme when 'background' option is not set
		background = { -- Map 'background' option to a theme variant
			dark = "dragon", -- Use "dragon" variant for dark background
			light = "lotus", -- Use "lotus" variant for light background
		},

		-- Advanced customization options
		colors = { -- Custom color overrides
			palette = {}, -- Override specific palette colors
			theme = { -- Theme-specific color overrides
				wave = {}, -- Wave theme overrides
				lotus = {}, -- Lotus theme overrides
				dragon = {}, -- Dragon theme overrides
				all = {}, -- Overrides for all themes
			},
		},

		-- Custom highlight group overrides
		overrides = function(colors)
			return {
				-- Examples of custom highlight overrides:
				-- Comment = { fg = colors.palette.fujiGray, italic = true },
				-- LineNr = { fg = colors.palette.fujiGray },
				-- CursorLineNr = { fg = colors.palette.carpYellow, bold = true },
			}
		end,
	},

	config = function(_, opts)
		-- Initialize the colorscheme
		local kanagawa = require("kanagawa")
		kanagawa.setup(opts)

		-- Uncomment to automatically set the colorscheme
		-- vim.cmd("colorscheme kanagawa")
	end,
}
