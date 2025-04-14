-- PLUGIN: accelerated-jk
-- FUNCTIONALITY: Provides accelerated j/k motion for smoother scrolling with cursor centered
-- FEATURES:
--  - Cursor speed increases the longer you hold j/k keys
--  - Keeps cursor vertically centered in the window ('zz')
--  - Customizable acceleration curve

return {
	"rhysd/accelerated-jk",

	-- Define keymaps that will be automatically set when the plugin loads
	keys = {
		-- Map 'j' to move down with acceleration and center cursor
		{
			"j", -- Key to map
			"<Plug>(accelerated_jk_gj)zz", -- Move down with gj (respects visual lines) and center view
			buffer = nil, -- Apply globally (not buffer-specific)
			noremap = true, -- Don't allow further remapping
			nowait = true, -- Don't wait for additional keys
			silent = true, -- Don't show command in command line
			desc = "Move down with acceleration (centered)", -- Description for which-key
		},

		-- Map 'k' to move up with acceleration and center cursor
		{
			"k", -- Key to map
			"<Plug>(accelerated_jk_gk)zz", -- Move up with gk (respects visual lines) and center view
			buffer = nil, -- Apply globally (not buffer-specific)
			noremap = true, -- Don't allow further remapping
			nowait = true, -- Don't wait for additional keys
			silent = true, -- Don't show command in command line
			desc = "Move up with acceleration (centered)", -- Description for which-key
		},
	},

	config = function()
		-- Set acceleration curve - this defines how quickly movement speed increases
		-- The numbers represent acceleration steps in milliseconds
		-- Lower values = faster acceleration
		-- Format: [initial_speed, speed2, speed3, ...]
		vim.g.accelerated_jk_acceleration_table = { 7, 13, 20, 33, 53, 86 }

		-- Optional settings (uncomment to enable):
		-- vim.g.accelerated_jk_acceleration_limit = 150  -- Maximum speed limit
		-- vim.g.accelerated_jk_enable_deceleration = 1   -- Enable deceleration when releasing keys
	end,
}
