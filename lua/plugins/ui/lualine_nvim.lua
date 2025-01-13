-- Package: lualine.nvim
-- FUNCTIONALITY: statusline at the bottom of Terminal
return {
	"nvim-lualine/lualine.nvim",
	event = "UIEnter",
	dependencies = {
		"nvim-web-devicons",
		"folke/noice.nvim",
	},
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
			},
			sections = {
				lualine_x = {
					{
						require("noice").api.status.message.get_hl,
						cond = require("noice").api.status.message.has,
						color = { fg = "#c5c9c5" },
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#c5c9c5" },
					},
				},
			},
			extensions = { "nvim-tree" },
		})
	end,
}
