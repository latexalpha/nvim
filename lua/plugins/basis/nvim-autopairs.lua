-- PLUGIN: nvim-autopairs
-- FUNCTIONALITY: Automatically pair brackets, quotes, and other symbols
-- FEATURES:
--  - Auto-close pairs like (), [], {}, '', "", ``
--  - Smart deletion of pairs (delete both when inside empty pair)
--  - Supports filetype-specific rules
--  - Works with existing text and won't interfere with selections

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- Only load when entering insert mode
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			-- Core behavior settings
			disable_in_replace_mode = true, -- Don't pair in replace mode
			disable_in_macro = false, -- Enable pairing in macros
			disable_in_visualblock = false, -- Enable pairing in visual block mode
			disable_filetype = { "TelescopePrompt", "vim" }, -- Disable in specific filetypes

			-- Pair behavior configuration
			enable_moveright = true, -- Auto-move past closing pairs
			enable_afterquote = true, -- Add space between quote and parenthesis
			enable_check_bracket_line = true, -- Don't add pair if same line has unmatched bracket

			-- Visual feedback settings
			check_ts = false, -- Use treesitter for more accurate pairing (set true if using TS)
			ts_config = { -- Treesitter integration (only if check_ts=true)
				-- lua = {'string'},           -- Don't add pairs in lua string treesitter nodes
				-- javascript = {'template_string'}, -- Don't add pairs in JS template strings
			},

			-- Fast wrap settings - quickly wrap selected text with a pair
			fast_wrap = {
				map = "<M-e>", -- Use Alt+e to trigger fast wrap
				chars = { "{", "[", "(", '"', "'" }, -- Characters that can wrap
				pattern = [=[[%'%"%>%]%)%}%,]]=], -- Pattern to recognize end of region
				end_key = "$", -- Key to place cursor at end of wrapped region
				keys = "qwertyuiopzxcvbnmasdfghjkl", -- Keys for choosing wrapping char
				check_comma = true, -- Add comma if needed when wrapping
				highlight = "Search", -- Highlight for wrap area
				highlight_grey = "Comment", -- Highlight for other options
			},
		})

		-- Optional: Integration with nvim-cmp completion (uncomment if using nvim-cmp)
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
