-- PLUGIN: lualine.nvim
-- FUNCTIONALITY: Highly configurable statusline for Neovim
-- DESCRIPTION: Displays file information, git status, diagnostics and more in a customizable statusline

return {
	"nvim-lualine/lualine.nvim",
	event = "UIEnter", -- Load when UI is ready, for better startup performance

	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Icons for file types
	},

	config = function()
		local lualine = require("lualine")

		-- Configure and initialize lualine
		lualine.setup({
			options = {
				theme = "auto", -- Automatically match colorscheme

				-- Separators between sections
				component_separators = { left = "|", right = "|" }, -- Straight lines between components
				section_separators = { left = "", right = "" }, -- No separators between sections

				-- Disable statusline for specific filetypes
				disabled_filetypes = {
					statusline = {}, -- No filetypes disabled for statusline
					winbar = {}, -- No filetypes disabled for winbar
				},

				-- Additional options (uncomment to enable)
				-- globalstatus = true, -- Single statusline for all windows
				-- refresh = {          -- Update frequency in ms
				--     statusline = 1000,
				--     tabline = 1000,
				--     winbar = 1000,
				-- },
			},

			-- Configure statusline sections
			sections = {
				-- Left sections (defaults are fine)
				lualine_a = { "mode" }, -- Shows current mode
				lualine_b = { "branch", "diff", "diagnostics" }, -- Git branch, changes, and diagnostics
				lualine_c = { "filename" }, -- Filename

				-- Right sections (custom configuration)
				-- Add last_command component to lualine_x
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" }, -- File progress percentage
				lualine_z = { "location" }, -- Cursor location (line:column)
			},

			-- Extensions for specific plugins
			extensions = {
				"nvim-tree", -- Integration with nvim-tree file explorer
			},
		})

		-- Set up autocmd to refresh statusline after command execution
		vim.api.nvim_create_autocmd("CmdlineLeave", {
			callback = function()
				vim.defer_fn(function()
					vim.cmd("redrawstatus")
				end, 100)
			end,
		})
	end,
}
