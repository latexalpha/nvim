-- PLUGIN: formatter.nvim
-- FUNCTIONALITY: code formatting for lua

-- the auto command group to format files on save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- the formatters need to be installed via Mason
return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				python = {
					require("formatter.filetypes.python").ruff,
				},
				markdown = {
					require("formatter.filetypes.markdown").prettier,
				},
			},
		})
	end,
}
