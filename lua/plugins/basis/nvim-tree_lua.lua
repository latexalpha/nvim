-- PLUGIN: nvim-tree.lua
-- FUNCTIONALITY: File explorer for Neovim
-- FEATURES:
--  - Tree-style file browser with icons
--  - File operations (create, delete, rename, etc.)
--  - Git integration showing file status
--  - Customizable interface and behavior

local map = vim.keymap.set

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, -- Must set lazy to false to load at startup
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Required for file icons
	},

	opts = {
		-- Core behavior settings
		sort_by = "case_sensitive", -- Sort files case-sensitively
		hijack_cursor = true, -- Keep cursor on filename when navigating
		sync_root_with_cwd = true, -- Sync root with current working directory

		-- Renderer configuration
		renderer = {
			group_empty = true, -- Group empty folders together
			icons = {
				show = {
					file = true, -- Show file icons
					folder = true, -- Show folder icons
					folder_arrow = true, -- Show folder arrows
					git = true, -- Show git status icons
				},
			},
			indent_markers = {
				enable = true, -- Show indent markers for nested folders
			},
			highlight_git = true, -- Highlight files based on git status
		},

		-- Filter settings
		filters = {
			dotfiles = true, -- Hide dotfiles by default (toggle with H)
			custom = { ".git", "node_modules", ".cache" }, -- Additional files to hide
		},

		-- View configuration
		view = {
			width = 40, -- Width of the tree panel
			side = "left", -- Show on left side of window
			number = false, -- Hide line numbers
			relativenumber = false, -- Hide relative line numbers
			signcolumn = "yes", -- Show sign column for git status
		},

		-- Git integration
		git = {
			enable = true, -- Enable git integration
			ignore = true, -- Respect .gitignore
			timeout = 500, -- Git status update timeout in ms
		},

		-- Actions configuration
		actions = {
			open_file = {
				quit_on_open = false, -- Keep tree open when opening files
				resize_window = true, -- Resize tree when opening files
			},
		},
	},

	config = function(_, opts)
		-- Define keymappings
		-- Toggle file explorer
		map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		-- Focus file explorer (open if closed)
		map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
		-- Find current file in tree
		map("n", "<leader>fe", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in explorer" })

		-- Initialize nvim-tree with our options
		local nvim_tree = require("nvim-tree")
		nvim_tree.setup(opts)

		-- Automatically close NvimTree when it's the last window
		vim.api.nvim_create_autocmd("BufEnter", {
			nested = true,
			callback = function()
				-- If NvimTree is the only buffer left, quit Neovim
				if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
					vim.cmd("quit")
				end
			end,
		})
	end,
}
