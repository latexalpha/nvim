-- PLUGIN: noice.nvim
-- FUNCTIONALITY: noice ui
return {
	"folke/noice.nvim",
	event = "VeryLazy",

	dependencies = {
		{
			"MunifTanjim/nui.nvim",
			lazy = true,
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
					background_colour = "#1e1e2e",
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp",
		},
	},

	opts = {
		lsp = {
			progress = { enabled = false },
			-- signature = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = false,
			long_message_to_split = true,
		},
		views = {
			cmdline_popup = {
				-- border = {
				style = "none",
				-- style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				padding = { 1, 3 },
				-- },
				-- win_options = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
				position = { row = 20, col = "50%" },
			},
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)
	end,
}
