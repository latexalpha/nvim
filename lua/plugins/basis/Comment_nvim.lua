-- PLUGIN: Comment.nvim
-- FUNCTIONALITY: Smart code commenting plugin
-- DESCRIPTION: Fast and powerful commenting plugin that supports motions, operators, and more
--
-- SHORTCUTS:
--   Normal mode:
--     - gcc: Toggle line comment for current line
--     - gc{motion}: Toggle line comment for motion (gcip = comment inside paragraph)
--     - gbc: Toggle block comment for current line
--     - gb{motion}: Toggle block comment for motion (gbap = block comment around paragraph)
--   Visual mode:
--     - gc: Toggle line comment for selection
--     - gb: Toggle block comment for selection
--   Extra:
--     - gc0: Comment from cursor to beginning of line
--     - gc$: Comment from cursor to end of line
--     - gcO: Insert comment on line above and enter insert mode
--     - gco: Insert comment on line below and enter insert mode
--     - gcA: Insert comment at end of line and enter insert mode

return {
	"numToStr/Comment.nvim",
	event = "VeryLazy", -- Load plugin when needed for better startup performance
	opts = {
		-- Basic configuration options
		padding = true, -- Add a space between comment delimiter and content
		sticky = true, -- Keep cursor position when commenting
		ignore = "^$", -- Skip empty lines when commenting multiple lines

		-- Mappings configuration
		mappings = {
			-- Enable default operator-pending mappings
			basic = true, -- gcc, gbc, gc[motion], gb[motion]

			-- Enable extra mappings (gco, gcO, gcA)
			extra = true,

			-- Enable extended mappings (gc0, gc$, etc)
			extended = true,
		},

		-- Pre-hook and post-hook functions
		-- pre_hook is called before commenting and can modify the comment string
		pre_hook = function(ctx)
			-- For context-aware commenting in files with multiple languages
			-- (like markdown with code blocks or Vue with HTML/JS/CSS)
			local loaded, tscomments = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if loaded and tscomments then
				return tscomments.create_pre_hook()(ctx)
			end
			return nil -- Use default comment string
		end,

		-- For language-specific comment string configuration:
		-- To override comment string for a specific language, uncomment and adjust:
		-- languages = {
		--     -- Example: Use different comment style for a language
		--     -- cpp = { '// %s', '/* %s */' },  -- Line and block comments for C++
		--     -- python = { '# %s', '""" %s """' },  -- Line and block comments for Python
		-- },
	},

	config = function(_, opts)
		-- Initialize the plugin with our configuration
		local comment = require("Comment")

		-- Setup the plugin
		comment.setup(opts)

		-- Optional: Enhanced integration with treesitter for mixed-language files
		-- This requires the nvim-ts-context-commentstring plugin
		--[[ 
        -- Uncomment if you want to use treesitter-based context commenting
        if pcall(require, 'nvim-treesitter.configs') then
            require('nvim-treesitter.configs').setup({
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false, -- Let Comment.nvim handle it
                }
            })
        end
        --]]

		-- Example of adding custom keymaps (uncomment to use)
		-- vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end,
		--    { desc = "Toggle comment" })
		-- vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		--    { desc = "Toggle comment on selection" })
	end,
}
