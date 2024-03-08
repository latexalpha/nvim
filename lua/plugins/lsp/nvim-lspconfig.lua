-- FUNCTION: LSP settings

vim.diagnostic.config({
	virtual_text = false,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(client, bufnr)
			local rc = client.server_capabilities

			if client.name == "pyright" then
				rc.hover = false
			end

			if client.name == "black" then
				rc.rename = false
				rc.signature_help = false
			end

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
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end

		-- Language server settings for per language
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

		-- language server for latex
		lspconfig.texlab.setup({})

		-- language server for python with pyright and ruff_lsp
		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = (function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
				return capabilities
			end)(),
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						diagnosticMode = "off",
						diagnosticSeverityOverrides = {
							reportUnusedVariable = "warning", -- or anything
						},
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		lspconfig.ruff_lsp.setup({
			on_attach = on_attach,
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = {},
				},
			},
		})
	end,

	dependencies = {
		{
			"williamboman/mason.nvim", -- Package Manager
			build = ":MasonUpdate", -- :MasonUpdate updates registry contents
			cmd = {
				"Mason",
				"MasonInstall",
				"MasonUninstall",
				"MasonUninstallAll",
			},
			dependencies = "williamboman/mason-lspconfig.nvim",
			config = function()
				local mason = require("mason")
				local mason_lspconfig = require("mason-lspconfig")

				local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
				if binaryformat == "dll" then
					Ensure_installed = {
						-- ensured installed language servers
						"lua_ls", -- lua
						"texlab", -- latex
						"pyright", -- python
					}
				else
					Ensure_installed = {
						-- ensured installed language servers
						"lua_ls", -- lua
						"pyright", -- python
					}
				end
				binaryformat = nil

				mason.setup({
					ui = {
						-- Whether to automatically check for new versions when opening the :Mason window.
						check_outdated_packages_on_open = false,
						border = "single",
						icons = {
							package_pending = " ",
							package_installed = " ",
							package_uninstalled = " ",
						},
					},
				})
				mason_lspconfig.setup({
					ensure_installed = Ensure_installed,
				})
			end,
		},
	},
}
