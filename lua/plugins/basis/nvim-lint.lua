-- PLUGIN: nvim-lint
-- FUNCTIONALITY: Asynchronous linting for Neovim
--
-- PREREQUISITES:
-- - Linters are automatically installed via Mason tool installer

return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy", -- Load plugin only when needed for better performance
	config = function()
		local lint = require("lint")

		-- Configure linters for specific file types
		lint.linters_by_ft = {
			lua = { "luacheck" }, -- Lua static analyzer
			markdown = { "markdownlint" }, -- Markdown style checker
			-- python = { "ruff" },       -- Fast Python linter (uncomment to enable)
		}

		-- Custom linter configurations for Neovim development
		lint.linters.luacheck.args = {
			"--globals",
			"vim", -- Allow 'vim' global in Lua files
			"--no-max-line-length", -- Disable line length warnings
			"--no-unused-args", -- Disable unused arguments warnings (useful for callbacks)
		}

		-- Configure markdownlint
		lint.linters.markdownlint.args = {
			"--disable",
			"MD013", -- Disable line length warnings
			"--disable",
			"MD033", -- Allow inline HTML
		}

		-- Diagnostic configuration
		vim.diagnostic.config({
			-- Disable virtual text (inline diagnostics)
			virtual_text = false,

			-- Enable floating window diagnostics on cursor hold
			float = {
				source = true, -- Always show source
				border = "rounded", -- Add border to float window
				header = "", -- No header
				prefix = "▶ ", -- Add bullet point prefix to each diagnostic Left bar prefix (or use "●", "■", ", etc.)
			},

			-- Show diagnostics with underlines
			underline = true,

			-- Update diagnostics after leaving insert mode
			update_in_insert = false,

			-- Sort diagnostics by severity
			severity_sort = true,

			-- Show signs in the sign column
			signs = true,
		})

		-- -- Set up autocommand to show diagnostics in floating window when cursor is stationary
		-- vim.api.nvim_create_autocmd("CursorHold", {
		--     callback = function()
		--         vim.diagnostic.open_float({ focus = false })
		--     end,
		-- })

		-- Set up autocommand to trigger linting
		local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})

		-- Keymapping to manually trigger lint
		vim.keymap.set("n", "<leader>lt", function()
			require("lint").try_lint()
		end, { desc = "Trigger linting for current file" })

		-- Keymapping to show diagnostics in floating window
		vim.keymap.set("n", "<leader>lf", function()
			vim.diagnostic.open_float()
		end, { desc = "Show diagnostics under cursor" })

		-- Diagnostic navigation keymaps (updated for newer Neovim API)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump_prev({ float = { border = "rounded" } })
		end, { desc = "Go to previous diagnostic" })

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump_next({ float = { border = "rounded" } })
		end, { desc = "Go to next diagnostic" })

		-- Additional diagnostic navigation by severity (updated)
		vim.keymap.set("n", "[e", function()
			vim.diagnostic.jump_prev({
				severity = vim.diagnostic.severity.ERROR,
				float = { border = "rounded" },
			})
		end, { desc = "Go to previous error" })

		vim.keymap.set("n", "]e", function()
			vim.diagnostic.jump_next({
				severity = vim.diagnostic.severity.ERROR,
				float = { border = "rounded" },
			})
		end, { desc = "Go to next error" })
		-- List all diagnostics in quickfix window
		vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "List all diagnostics in quickfix" })

		-- List buffer diagnostics in loclist window
		vim.keymap.set("n", "<leader>lw", function()
			vim.diagnostic.setloclist({ open = true })
		end, { desc = "List buffer diagnostics in loclist" })
	end,

	-- Add Mason dependencies for automatic linter installation
	dependencies = {
		"williamboman/mason.nvim",
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			config = function()
				require("mason-tool-installer").setup({
					-- Automatically install these linters
					ensure_installed = {
						"luacheck", -- Lua linter
						"markdownlint", -- Markdown linter
						-- "ruff",       -- Python linter (uncomment to enable)
					},
					auto_update = true, -- Keep tools updated
					run_on_start = true, -- Install/update tools when Neovim starts
				})
			end,
		},
	},
}
