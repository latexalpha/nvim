return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			markdown = { "markdownlint" },
			lua = { "luacheck" },
			python = { "ruff" },
		}
	end,
}