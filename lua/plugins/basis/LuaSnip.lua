-- PLUGIN: LuaSnip
-- FUNCTIONALITY: Snippet engine for Neovim
--
-- FEATURES:
-- - Loads snippets from Lua files in the snippets directory
-- - Supports dynamic snippets with Lua functions
-- - Integrates with completion plugins like nvim-cmp
--
-- USAGE:
-- - Place snippet definitions in: ~/.config/nvim/lua/snippets/*.lua

return {
	"L3MON4D3/LuaSnip",
	-- version = "v2.*",                -- Use version 2.x for stability
	event = "InsertEnter", -- Load when entering insert mode for better startup time
	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		-- Configure LuaSnip options
		luasnip.config.set_config({
			history = true, -- Allow jumping back into previous snippets
			updateevents = "TextChanged,TextChangedI", -- Update dynamic snippets on text change
			enable_autosnippets = true, -- Enable automatic snippet expansion
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { " ← Current choice", "Comment" } },
					},
				},
			},
		})

		-- Define the path to custom snippets directory
		local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

		-- Load snippets from the Lua files in the snippets directory
		require("luasnip.loaders.from_lua").lazy_load({ paths = { snippets_path } })

		-- Optional: Load snippets from VS Code snippet format (uncomment if needed)
		-- require("luasnip.loaders.from_vscode").lazy_load()

		-- Optional: Setup keymaps for snippet navigation (uncomment if needed)
		-- vim.keymap.set({"i", "s"}, "<Tab>", function()
		--     if luasnip.expand_or_jumpable() then
		--         luasnip.expand_or_jump()
		--     else
		--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
		--     end
		-- end, {silent = true})
		--
		-- vim.keymap.set({"i", "s"}, "<S-Tab>", function()
		--     if luasnip.jumpable(-1) then
		--         luasnip.jump(-1)
		--     else
		--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n")
		--     end
		-- end, {silent = true})
	end,
}
