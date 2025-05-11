-- PLUGIN: nvim-treesitter
-- FUNCTIONALITY: Advanced syntax highlighting, code navigation and text objects
-- DESCRIPTION: Uses Tree-sitter to provide better syntax awareness for language features
--
-- FEATURES:
--  - Accurate syntax highlighting based on language grammar
--  - Smart text objects for code navigation
--  - Incremental selection based on syntax tree
--  - Improved indentation based on code structure

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
	build = ":TSUpdate", -- Update parsers when plugin is installed/updated

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects
			init = function()
				-- Performance optimization: only load textobjects if actually configured
				-- This avoids loading the plugin when only using its queries for mini.ai
				local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
				local opts = require("lazy.core.plugin").values(plugin, "opts", false)
				local enabled = false

				-- Check if any textobject modules are enabled
				if opts.textobjects then
					for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
						if opts.textobjects[mod] and opts.textobjects[mod].enable then
							enabled = true
							break
						end
					end
				end

				-- Disable the plugin from rtp if no modules are enabled
				if not enabled then
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end
			end,
		},
	},

	-- Define keymaps for incremental selection
	keys = {
		{ "<c-space>", desc = "Increment selection" }, -- Expand selection
		{ "<bs>", desc = "Decrement selection", mode = "x" }, -- Shrink selection (visual mode)
	},

	opts = {
		-- Languages to install parsers for
		ensure_installed = {
			"bash", -- Shell scripting
			"c", -- C language
			"lua", -- Lua language (for Neovim config)
			"luap", -- Lua patterns
			"markdown", -- Markdown documents
			"markdown_inline", -- Inline markdown (in comments, etc)
			-- "python",           -- Python (uncomment if needed)
			"regex", -- Regular expressions
			"vim", -- Vim script
			"vimdoc", -- Vim documentation format
			"yaml", -- YAML data format
		},

		-- Core modules configuration
		highlight = {
			enable = true, -- Enable syntax highlighting
			-- additional_vim_regex_highlighting = false,  -- Disable vim regex highlighting
		},

		indent = {
			enable = true, -- Enable indentation based on syntax
		},

		-- Enable context-aware commenting (works with Comment.nvim)
		context_commentstring = {
			enable = true,
			enable_autocmd = false, -- Let Comment.nvim handle this
		},

		-- Configure incremental selection
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>", -- Start selection
				node_incremental = "<C-space>", -- Expand selection to larger node
				scope_incremental = "<nop>", -- Expand to scope (disabled)
				node_decremental = "<bs>", -- Shrink selection
			},
		},

		-- Uncomment to enable text objects
		-- textobjects = {
		--     select = {
		--         enable = true,
		--         lookahead = true,  -- Automatically jump ahead to matching textobject
		--         keymaps = {
		--             ["af"] = "@function.outer",  -- Around function
		--             ["if"] = "@function.inner",  -- Inside function
		--             ["ac"] = "@class.outer",     -- Around class
		--             ["ic"] = "@class.inner",     -- Inside class
		--         },
		--     },
		--     move = {
		--         enable = true,
		--         set_jumps = true,  -- Add jumps to jumplist
		--         goto_next_start = {
		--             ["]m"] = "@function.outer",  -- Next method/function start
		--             ["]]"] = "@class.outer",     -- Next class start
		--         },
		--         goto_next_end = {
		--             ["]M"] = "@function.outer",  -- Next method/function end
		--             ["]["] = "@class.outer",     -- Next class end
		--         },
		--         goto_previous_start = {
		--             ["[m"] = "@function.outer",  -- Previous method/function start
		--             ["[["] = "@class.outer",     -- Previous class start
		--         },
		--         goto_previous_end = {
		--             ["[M"] = "@function.outer",  -- Previous method/function end
		--             ["[]"] = "@class.outer",     -- Previous class end
		--         },
		--     },
		-- },
	},

	config = function(_, opts)
		-- Set compiler preference for parsing (important on Windows)
		require("nvim-treesitter.install").compilers = { "clang", "gcc", "g++" }

		-- Apply configuration
		require("nvim-treesitter.configs").setup(opts)
	end,
}
