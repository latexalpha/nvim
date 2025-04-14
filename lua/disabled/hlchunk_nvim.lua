-- PLUGIN: hlchunk.nvim
-- FUNCTIONALITY: Highlights code structure with enhanced visual indicators
-- FEATURES:
-- - Adds indent guides with rainbow colors
-- - Highlights matching brackets and parentheses
-- - Shows line indicators for code blocks

return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" }, -- Load when UI is ready for better startup performance
	config = function()
		local hlchunk = require("hlchunk")
		hlchunk.setup({
			-- Indentation guide configuration
			indent = {
				chars = { "│" }, -- Character for indentation guides (thin vertical bar)
				-- Rainbow colors for different indentation levels
				style = {
					"#E06C75", -- Level 1: Soft red
					"#E5C07B", -- Level 2: Soft yellow
					"#C678DD", -- Level 3: Purple
					"#61AFEF", -- Level 4: Light blue
					"#56B6C2", -- Level 5: Teal
					"#98C379", -- Level 6: Light green
				},
				-- Additional indent options (uncomment to enable)
				-- enable = true,    -- Enable indent guides
				-- use_treesitter = false, -- Whether to use treesitter for indentation
				-- exclude_filetypes = { "help", "dashboard", "NvimTree" },
			},

			-- Highlight line for start of chunk
			line_num = {
				enable = true, -- Enable line number highlighting
				-- style = "#61AFEF", -- Color for the line number highlight
			},

			-- Blank line highlighting
			blank = {
				enable = false, -- Disable blank line highlighting by default
				-- chars = { "·" },  -- Character for blank spaces
				-- style = {
				--     vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				-- },
			},
		})

		-- Optional keymap to toggle hlchunk (uncomment to enable)
		-- vim.keymap.set("n", "<leader>th", function()
		--     vim.g.hlchunk_enabled = not vim.g.hlchunk_enabled
		--     if vim.g.hlchunk_enabled then
		--         hlchunk.enable()
		--     else
		--         hlchunk.disable()
		--     end
		-- end, { desc = "Toggle code chunk highlighting" })
	end,
}
