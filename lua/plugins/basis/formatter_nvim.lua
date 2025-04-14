-- PLUGIN: formatter.nvim
-- FUNCTIONALITY: Code formatting for various languages
--
-- PREREQUISITES:
-- - Formatters are automatically installed via Mason
--
-- USAGE:
-- - Manual: Use :Format to format current buffer
-- - Manual with write: Use :FormatWrite to format and save
-- - Auto: Files are automatically formatted on save

-- Create an autocommand group for the formatter
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Clear previous autocommands in this group and set up formatting on save
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite", -- Format and save when buffer is written
})

return {
	"mhartington/formatter.nvim",
	event = "VeryLazy", -- Load only when needed for better startup performance
	config = function()
		local formatter = require("formatter")

		formatter.setup({
			-- Logging configuration
			logging = true, -- Enable logging for debugging
			log_level = vim.log.levels.WARN, -- Show only warnings and errors

			-- Configure formatters for specific filetypes
			filetype = {
				-- Lua files: use stylua formatter
				lua = {
					require("formatter.filetypes.lua").stylua,
				},

				-- Python files: use ruff formatter
				python = {
					require("formatter.filetypes.python").ruff,
				},

				-- Markdown files: use prettier formatter
				markdown = {
					require("formatter.filetypes.markdown").prettier,
				},
			},

			-- Fallback formatter for any filetype not configured above (optional)
			["*"] = {
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		})
	end,
}
