-- PLUGIN: nvim-lspconfig
-- FUNCTIONALITY: Language Server Protocol (LSP) configuration
--
-- SETUP ORDER (important for proper initialization):
-- 1. `mason.nvim` - Package manager for LSP servers, linters, formatters, etc.
-- 2. `mason-lspconfig.nvim` - Bridge between Mason and nvim-lspconfig
-- 3. Setup individual language servers via `lspconfig`
--
-- CONFIGURATION OPTIONS:
-- Uncomment the following sections to enable specific behaviors

-- -- Disable in-line diagnostic messages (shows errors/warnings in the editor)
-- vim.diagnostic.config({
-- 	virtual_text = false,
-- })

-- -- Show line diagnostics automatically in hover window when cursor is stationary
-- vim.o.updatetime = 250 -- Reduce delay before showing hover diagnostics
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Load when opening files (for performance)
	config = function()
		-- Python LSP keymappings
		-- Only applied after LSP attaches to the current buffer
		local common_on_attach = function(_, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			-- Navigation
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go to declaration
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to definition
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Show documentation
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- Go to implementation
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- Show signature help

			-- Workspace management
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)

			-- Code intelligence
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts) -- Go to type definition
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename symbol
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- Show code actions
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- Find references
		end

		-- Python LSP keymappings (extends common keymappings)
		-- local python_on_attach = function(client, bufnr)
		-- 	common_on_attach(client, bufnr)
		-- 	-- Add Python-specific keymappings here if needed
		-- end

		-- LaTeX LSP keymappings
		-- Focused on formatting functionality
		local latex_on_attach = function(_, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "<leader>ft", function()
				vim.lsp.buf.format({ async = true }) -- Format LaTeX document
			end, bufopts)
		end

		-- Lua language server configuration
		vim.lsp.config("lua_ls", {
			on_attach = common_on_attach, -- apply common keymaps
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }, -- Recognize 'vim' as a global variable in Neovim configs
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- LTeX language server for grammar/spell checking (markdown, text, LaTeX)
		vim.lsp.config("ltex", {
			on_attach = common_on_attach, -- Apply common keymaps
			settings = {
				ltex = {
					language = "en-US", -- Set default language for grammar checking
					diagnosticSeverity = "information", -- Show grammar errors as information
				},
			},
		})
		vim.lsp.enable("ltex")

		-- TeX/LaTeX language server with formatting capabilities
		vim.lsp.config("texlab", {
			on_attach = latex_on_attach, -- Apply LaTeX-specific keymaps
			settings = {},
		})
		vim.lsp.enable("texlab")
	end,

	dependencies = {
		{
			"williamboman/mason.nvim", -- Package Manager for LSP servers, DAP, linters, and formatters
			build = ":MasonUpdate", -- Update registry contents when Mason is updated
			cmd = {
				"Mason", -- Open Mason UI
				"MasonInstall", -- Install packages
				"MasonUninstall", -- Remove packages
			},
			config = function()
				local mason = require("mason")
				mason.setup({
					ui = {
						check_outdated_packages_on_open = false, -- Don't check for updates automatically
						border = "single", -- UI border style
						icons = {
							package_pending = " ", -- Package is being installed
							package_installed = " ", -- Package is installed
							package_uninstalled = " ", -- Package is not installed
						},
					},
				})
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim", -- Bridge between Mason and nvim-lspconfig
			config = function()
				local mason_lspconfig = require("mason-lspconfig")

				-- Detect OS for platform-specific installations
				local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
				local Ensure_installed = {} -- Table to hold the list of servers to install
				if binaryformat == "dll" then
					-- Windows-specific packages to install
					Ensure_installed = {
						-- Language Servers
						"lua_ls", -- Lua language server
						"texlab", -- LaTeX language server
						-- "pyright", -- Python language server (commented out)
					}
				else
					-- Unix-like systems (Linux/macOS)
					Ensure_installed = {
						"lua_ls", -- Lua language server
						-- "pyright", -- Python language server (commented out)
					}
				end
				binaryformat = nil -- Clean up variable after use

				-- Configure which servers Mason should automatically install
				mason_lspconfig.setup({
					ensure_installed = Ensure_installed,
				})
			end,
		},
	},
}
