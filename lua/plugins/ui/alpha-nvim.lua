-- PLUGIN: alpha-nvim
-- FUNCTIONALITY: Customizable dashboard with a start screen
-- FEATURES:
--  - Custom ASCII art header
--  - Quick access buttons for common operations
--  - Startup stats display
--  - Seamless integration with lazy.nvim

return {
	"goolord/alpha-nvim",
	event = "VimEnter", -- Load when Vim starts up
	opts = function()
		local dashboard = require("alpha.themes.dashboard")

		-- ASCII art logo for the header section
		-- To center the logo, each line must start from the first column
		local logo = [[
░██████╗██╗░░██╗░█████╗░███╗░░██╗░██████╗░██╗░░░██╗██╗░░░██╗
██╔════╝██║░░██║██╔══██╗████╗░██║██╔════╝░╚██╗░██╔╝██║░░░██║
╚█████╗░███████║███████║██╔██╗██║██║░░██╗░░╚████╔╝░██║░░░██║
░╚═══██╗██╔══██║██╔══██║██║╚████║██║░░╚██╗░░╚██╔╝░░██║░░░██║
██████╔╝██║░░██║██║░░██║██║░╚███║╚██████╔╝░░░██║░░░╚██████╔╝
╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░░░░╚═╝░░░░╚═════╝░
        ]]

		-- Set the header content to our logo
		dashboard.section.header.val = vim.split(logo, "\n")

		-- Configure dashboard buttons with icons and descriptions
		-- Format: button(shortcut, icon + description, command)
		dashboard.section.buttons.val = {
			dashboard.button("<leader>cf", " " .. " Open config", ":e $MYVIMRC <CR>"),
			dashboard.button("<leader>nf", " " .. " Create file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("<leader>ff", " " .. " Find file", ":Telescope find_files <CR>"),
			dashboard.button("<leader>fg", " " .. " Find text", ":Telescope live_grep <CR>"),
			dashboard.button("<leader>fk", " " .. " Find keymaps", ":Telescope keymaps <CR>"),
			dashboard.button("<leader>fo", " " .. " Find recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("<leader>l", "󰒲 " .. " Open Lazy", ":Lazy<CR>"),
			dashboard.button("<leader>q", " " .. " Quit Nvim", ":qa<CR>"),
		}

		-- Apply consistent highlighting to all buttons
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons" -- Button text highlighting
			button.opts.hl_shortcut = "AlphaShortcut" -- Shortcut highlighting
		end

		-- Set highlight groups for dashboard sections
		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		-- Adjust layout spacing (padding above the logo)
		dashboard.opts.layout[1].val = 4

		-- Optional: Customize the footer with a quote or message
		-- dashboard.section.footer.val = "\"Simplicity is the ultimate sophistication\" - Leonardo da Vinci"

		return dashboard
	end,

	config = function(_, dashboard)
		-- Handle integration with lazy.nvim
		-- If Lazy is open when dashboard loads, close it and reopen after dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		-- Initialize alpha with our dashboard configuration
		local alpha = require("alpha")
		alpha.setup(dashboard.opts)

		-- Display startup stats in the footer
		vim.api.nvim_create_autocmd("User", {
			pattern = "SYNVIM",
			callback = function()
				-- Get plugin statistics from lazy.nvim
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

				-- Update the footer with startup information
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"

				-- Try to redraw Alpha to show the updated stats
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		-- Optional: Add a keymap to return to dashboard
		-- vim.keymap.set("n", "<leader>h", ":Alpha<CR>", { desc = "Return to dashboard", silent = true })
	end,
}
