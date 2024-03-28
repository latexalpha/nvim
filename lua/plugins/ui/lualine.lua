-- Package: lualine.nvim
-- FUNCTIONALITY: statusline
return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			sections = {
				lualine_x = {
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
				},
			},
		})
	end,
}
