-- PLUGIN: nvim-lspconfig
-- FUNCTIONALITY: LSP settings
--
-- The setup order should be:
-- 1. `mason.nvim`
-- 2. `mason-lspconfig.nvim`
-- 3. Setup servers via `lspconfig`

-- vim.diagnostic.config({
-- 	virtual_text = false,
-- })

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local python_on_attach = function(_, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		end

		local latex_on_attach = function(_, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "<leader>ft", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end

		-- Language server for lua
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		lspconfig.ltex.setup({})

		-- language server for latex
		lspconfig.texlab.setup({
			on_attach = latex_on_attach,
		})

		-- -- language server for python
		-- lspconfig.pyright.setup({
		-- 	on_attach = python_on_attach,
		-- 	capabilities = (function()
		-- 		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- 		capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
		-- 		return capabilities
		-- 	end)(),
		-- 	settings = {
		-- 		python = {
		-- 			analysis = {
		-- 				typeCheckingMode = "off",
		-- 				diagnosticMode = "off",
		-- 				diagnosticSeverityOverrides = {
		-- 					reportUnusedVariable = "warning", -- or anything
		-- 				},
		-- 				useLibraryCodeForTypes = true,
		-- 			},
		-- 		},
		-- 	},
		-- })
	end,

	dependencies = {
		{
			"williamboman/mason.nvim", -- Package Manager
			build = ":MasonUpdate", -- :MasonUpdate updates registry contents
			cmd = {
				"Mason",
				"MasonInstall",
				"MasonUninstall",
			},
			config = function()
				local mason = require("mason")
				mason.setup({
					ui = {
						check_outdated_packages_on_open = false,
						border = "single",
						icons = {
							package_pending = " ",
							package_installed = " ",
							package_uninstalled = " ",
						},
					},
				})
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				local mason_lspconfig = require("mason-lspconfig")
				local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
				if binaryformat == "dll" then
					Ensure_installed = {
						-- LSP
						"lua_ls", -- lua LSP
						"texlab", -- latex LSP
						-- "pyright", -- python LSP
						-- linter
						-- "ruff", -- python linter
						-- "ltex", -- LSP for text, markdown, latex
					}
				else
					Ensure_installed = {
						"lua_ls", -- lua
						-- "pyright", -- python
					}
				end
				binaryformat = nil

				mason_lspconfig.setup({
					ensure_installed = Ensure_installed,
				})
			end,
		},
	},
}
