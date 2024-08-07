-- PLUGIN: alpha-nvim
-- FUNCTIONALITY: dashboard with a start screen
return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		-- to center the logo, it have to start from the first column
		local logo = [[
░██████╗██╗░░██╗░█████╗░███╗░░██╗░██████╗░██╗░░░██╗██╗░░░██╗
██╔════╝██║░░██║██╔══██╗████╗░██║██╔════╝░╚██╗░██╔╝██║░░░██║
╚█████╗░███████║███████║██╔██╗██║██║░░██╗░░╚████╔╝░██║░░░██║
░╚═══██╗██╔══██║██╔══██║██║╚████║██║░░╚██╗░░╚██╔╝░░██║░░░██║
██████╔╝██║░░██║██║░░██║██║░╚███║╚██████╔╝░░░██║░░░╚██████╔╝
╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░░░░╚═╝░░░░╚═════╝░
        ]]

		dashboard.section.header.val = vim.split(logo, "\n")
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
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.opts.layout[1].val = 4 -- line number to pad above the startup logo
		return dashboard
	end,

	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		local alpha = require("alpha")
		alpha.setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "SYNVIM",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
