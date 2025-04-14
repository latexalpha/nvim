-- PLUGIN: nvim-cmp
-- FUNCTIONALITY: Advanced auto-completion engine for Neovim
-- SOURCES: LSP, Snippets, Buffer words, File paths
--
-- FEATURES:
--  - Intelligent completion suggestions based on context
--  - Integration with LSP for accurate code completions
--  - Snippet support via LuaSnip
--  - Buffer word and file path completion

-- Helper function to check if there's a word before cursor
-- Used for tab completion behavior
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"hrsh7th/nvim-cmp",
	version = false, -- Use latest version
	event = "InsertEnter", -- Load only when entering insert mode for better startup

	-- Required dependencies for different completion sources
	dependencies = {
		-- LSP completion source
		"neovim/nvim-lspconfig", -- LSP configuration
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp

		-- Lua API completion source (for Neovim config)
		"hrsh7th/cmp-nvim-lua", -- Neovim Lua API source

		-- Snippet completion source
		"L3MON4D3/LuaSnip", -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- LuaSnip source for nvim-cmp

		-- Additional helpful sources
		"hrsh7th/cmp-buffer", -- Buffer words source
		"hrsh7th/cmp-cmdline", -- Command line source
		"hrsh7th/cmp-path", -- Filesystem path source
	},

	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		return {
			-- Configure completion sources and their priorities
			-- Higher priority sources appear first in the completion menu
			sources = {
				{ name = "nvim_lsp", priority = 1000, max_item_count = 5 }, -- LSP suggestions (highest priority)
				{ name = "luasnip", priority = 750, max_item_count = 5 }, -- Snippets
				{ name = "buffer", priority = 500, max_item_count = 5 }, -- Words from current buffer
				{ name = "path", priority = 250, max_item_count = 10 }, -- File paths
			},

			-- Customize how items appear in the completion menu
			formatting = {
				format = function(entry, vim_item)
					-- Add source name labels to completion items
					vim_item.menu = ({
						nvim_lsp = "[LSP]", -- Language server suggestions
						luasnip = "[Snippet]", -- Snippet suggestions
						buffer = "[Buffer]", -- Words from buffer
						path = "[Path]", -- File paths
					})[entry.source.name]

					-- Control duplicate items (0 disables duplicates)
					vim_item.dup = ({
						nvim_lsp = 0, -- No duplicates from LSP
						luasnip = 0, -- No duplicates from snippets
						buffer = 0, -- No duplicates from buffer
						path = 0, -- No duplicates from paths
					})[entry.source.name] or 0

					return vim_item
				end,
			},

			-- Keybindings for completion menu interaction
			mapping = cmp.mapping.preset.insert({
				-- Documentation scroll controls
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll up in docs
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Scroll down in docs

				-- Cancel completion
				["<C-e>"] = cmp.mapping.abort(), -- Close completion menu

				-- Item navigation with Ctrl+p/n (vim style)
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

				-- Item navigation with Ctrl+k/j (additional option)
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

				-- Confirm selection with Enter
				["<CR>"] = cmp.mapping.confirm({
					select = true, -- Select item if none explicitly selected
					behavior = cmp.ConfirmBehavior.Replace, -- Replace existing text
				}),

				-- Tab key behavior - multi-function key
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- If completion menu is visible, select next item
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						-- If in a snippet and can expand/jump, do that
						luasnip.expand_or_jump()
					elseif has_words_before() then
						-- If typing and no snippet active, show completion menu
						cmp.complete()
					else
						-- Otherwise, behave like normal Tab key
						fallback()
					end
				end, { "i", "s" }), -- Works in insert and select modes

				-- Shift-Tab key behavior - mostly navigation
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- If completion menu is visible, select previous item
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						-- If in a snippet and can jump backwards, do that
						luasnip.jump(-1)
					else
						-- Otherwise, behave like normal Shift-Tab
						fallback()
					end
				end, { "i", "s" }), -- Works in insert and select modes
			}),

			-- Configure snippet expansion
			snippet = {
				expand = function(args)
					if not luasnip then
						return
					end
					-- Use LuaSnip to handle LSP snippets
					luasnip.lsp_expand(args.body)
				end,
			},

			-- Completion window appearance (uncomment to customize)
			-- window = {
			--     completion = cmp.config.window.bordered(),
			--     documentation = cmp.config.window.bordered(),
			-- },

			-- Enable experimental features (uncomment if needed)
			-- experimental = {
			--     ghost_text = true,  -- Show "ghost text" preview of completion
			-- },
		}
	end,

	config = function(_, opts)
		local cmp = require("cmp")

		-- Set up the main insert mode completion
		cmp.setup(opts)

		-- Add command line completion (optional, uncomment to enable)
		-- cmp.setup.cmdline(':', {
		--     mapping = cmp.mapping.preset.cmdline(),
		--     sources = {
		--         { name = 'cmdline', max_item_count = 20 }
		--     }
		-- })

		-- Add search completion (optional, uncomment to enable)
		-- cmp.setup.cmdline('/', {
		--     mapping = cmp.mapping.preset.cmdline(),
		--     sources = {
		--         { name = 'buffer', max_item_count = 10 }
		--     }
		-- })
	end,
}
