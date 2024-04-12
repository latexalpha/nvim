-- PLUGIN: accelerated-jk
-- FUNCTIONALITY: key cursor in center of screen
-- local map = vim.keymap.set
return {
	"rhysd/accelerated-jk",
	keys = {
		{ "j", "<Plug>(accelerated_jk_gj)zz", buffer = nil, noremap = true, nowait = true, silent = true },
		{ "k", "<Plug>(accelerated_jk_gk)zz", buffer = nil, noremap = true, nowait = true, silent = true },
	},
	-- "rainbowhxch/accelerated-jk.nvim",
	-- lazy = false,
	-- config = function()
	-- local accjk = require("accelerated-jk")
	-- local on_attach = function(client, bufnr)
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- map({ "n", "x" }, accjk.accelerated_jk_gj, bufopts)
	-- map({ "n", "x" }, accjk.accelerated_jk_gk, bufopts)
	-- end
	-- accjk.setup()
	-- end,
}
