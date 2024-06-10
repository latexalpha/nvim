-- PLUGIN: noice.nvim
-- FUNCTIONALITY: noice ui
local map = vim.keymap.set
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
		-- Noice
		map("n", "<leader>nl", function()
			require("noice").cmd("last")
		end, { desc = "Noice Last Message." })
		map("n", "<leader>nh", function()
			require("noice").cmd("history")
		end, { desc = "Noice History" })
		map("n", "<leader>na", function()
			require("noice").cmd("all")
		end, { desc = "Noice All" })
		map("c", "<S-Enter>", function()
			require("noice").redirect(vim.fn.getcmdline())
		end, { desc = "Redirect Cmdline" })
		map({ "i", "n", "s" }, "<c-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-f>"
			end
		end, { silent = true, expr = true, desc = "Scroll forward." })
		map({ "i", "n", "s" }, "<c-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-b>"
			end
		end, { silent = true, expr = true, desc = "Scroll backward." })

		require("noice").setup(opts)
	end,
}
