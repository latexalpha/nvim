-- PLUGIN: hlchunk.nvim
-- FUNCTIONALITY: highlight chunks of code
return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		local hlchunk = require("hlchunk")
		hlchunk.setup({
			indent = {
				chars = { "│" },
				style = {
					"#E06C75",
					"#E5C07B",
					"#C678DD",
					"#61AFEF",
					"#56B6C2",
					"#98C379",
				},
			},
		})
	end,
}
