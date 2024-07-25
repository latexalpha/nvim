-- PLUGIN: Comment.nvim
-- FUNCTIONALITY: comment for codes
return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	opts = {
		padding = true,
		ignore = "^$", -- ignore empty line
	},
	config = function(_, opts)
		local comment = require("Comment")
		comment.setup(opts)
	end,
}
