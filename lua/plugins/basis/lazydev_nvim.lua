-- PLUGIN: lazydev.nvim
-- FUNCTIONALITY: Development tools for Neovim plugin authors
-- FEATURES:
--  - Enhanced documentation and type information for Neovim Lua API
--  - Auto-complete for Neovim API and custom plugin libraries
--  - Integrates with nvim-cmp and LuaLS for better development experience

return {
	-- Main plugin: lazydev.nvim for enhanced Lua development
	{
		"folke/lazydev.nvim",
		ft = "lua", -- Only load when editing Lua files for better performance
		opts = {
			-- Configure which libraries to provide documentation for
			library = {
				-- Include standard Neovim API automatically

				-- Library items can be absolute paths to your own plugins/libraries
				-- "~/projects/my-awesome-lib",

				-- Or relative, which means they will be resolved as a plugin name
				-- "LazyVim",  -- Would add LazyVim's API to documentation

				-- When relative, you can also provide a path to the library in the plugin dir
				"luvit-meta/library", -- Add vim.uv documentation from luvit-meta
			},

			-- Additional configuration options (uncomment to enable)
			-- runtime_path = true,        -- Include runtime path files in docs
			-- plugins = true,             -- Include plugins in docs
			-- auto_install = true,        -- Auto-install missing dependencies
		},
	},

	-- Dependency: luvit-meta provides typings for vim.uv API
	{
		"Bilal2453/luvit-meta",
		lazy = true, -- Only load when needed by lazydev
	},

	-- Integration: Add lazydev as a completion source for nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			-- Add lazydev as a completion source for nvim-cmp
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- Set group index to 0 to skip loading LuaLS completions
				-- (prevents duplicate suggestions from both lazydev and LuaLS)
			})
		end,
	},
}
