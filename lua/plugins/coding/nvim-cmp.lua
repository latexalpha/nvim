-- PLUGIN: nvim-cmp
-- FUNCTIONALITY: auto completion for LSP, LuaSnip, buffer and path
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		-- lsp completion
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		-- lua completion
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- buffer and path completion
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		return {
			sources = {
				{ name = "nvim_lsp", priority = 1000, max_item_count = 5 },
				{ name = "luasnip", priority = 750, max_item_count = 5 },
				{ name = "buffer", priority = 500, max_item_count = 5 },
				{ name = "path", priority = 250, max_item_count = 5 },
			},
			formatting = {
				format = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]

					vim_item.dup = ({
						nvim_lsp = 0,
						luasnip = 0,
						buffer = 0,
						path = 0,
					})[entry.source.name] or 0
					return vim_item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),

				-- <Tab> settings
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- <Shift + Tab> settings
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- LuaSnip settings
			snippet = {
				expand = function(args)
					if not luasnip then
						return
					end
					luasnip.lsp_expand(args.body)
				end,
			},
		}
	end,

	config = function(_, opts)
		local cmp = require("cmp")
		cmp.setup(opts)
	end,
}
