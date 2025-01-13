-- PLUGIN: accelerated-jk
-- FUNCTIONALITY: key cursor in center of screen
return {
	"rhysd/accelerated-jk",
	keys = {
		{ "j", "<Plug>(accelerated_jk_gj)zz", buffer = nil, noremap = true, nowait = true, silent = true },
		{ "k", "<Plug>(accelerated_jk_gk)zz", buffer = nil, noremap = true, nowait = true, silent = true },
	},
	config = function()
		vim.cmd("let g:accelerated_jk_acceleration_table = [7, 13, 20, 33, 53, 86]")
	end,
}
