-- PLUGIN: nvim-autopairs
-- FUNCTIONALITY: auto pairs for symbols
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")
		autopairs.setup({
			disable_in_replace_mode = true,
		})
	end,
}
