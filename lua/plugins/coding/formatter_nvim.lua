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
	event = "VeryLazy",
	config = function()
		local formatter = require("formatter")
		formatter.setup({
			logging = true,
			log_level = vim.log.levels.WARN,
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
