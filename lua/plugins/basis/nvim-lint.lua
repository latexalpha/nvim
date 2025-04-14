-- PLUGIN: nvim-lint
-- FUNCTIONALITY: Asynchronous linting for Neovim
--
-- PREREQUISITES:
-- - Linters are automatically installed via Mason tool installer
-- - A Nerd Font must be installed and configured in your terminal

return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy", -- Load plugin only when needed for better performance
	config = function()
		local lint = require("lint")

		-- Configure linters for specific file types
		lint.linters_by_ft = {
			lua = { "luacheck" }, -- Lua static analyzer
			markdown = { "markdownlint" }, -- Markdown style checker
			python = { "ruff" },       -- Fast Python linter (uncomment to enable)
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

		-- Set up diagnostic signs with Nerd Font icons
		local signs = {
			Error = "", -- Error icon (could also use '', '')
			Warn = "", -- Warning icon (could also use '', '')
			Info = "", -- Info icon (could also use '', '')
			Hint = "", -- Hint icon (could also use '', '')
		}
		-- Add this after your sign definitions
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#db4b4b" }) -- Vibrant red
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#e0af68" }) -- Amber yellow
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#0db9d7" }) -- Bright blue
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#10B981" }) -- Emerald green
		-- Apply the custom signs
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Diagnostic configuration
		-- vim.diagnostic.config({

		--     -- Enable virtual text with count for multiple diagnostics
		--     virtual_text = {
		--         -- Use severity-based icons in virtual text with count
		--         prefix = function(diagnostic)
		--             local icons = {
		--                 [vim.diagnostic.severity.ERROR] = signs.Error,
		--                 [vim.diagnostic.severity.WARN] = signs.Warn,
		--                 [vim.diagnostic.severity.INFO] = signs.Info,
		--                 [vim.diagnostic.severity.HINT] = signs.Hint
		--             }
		--             return icons[diagnostic.severity]
		--         end,
		--         spacing = 1,       -- Space between prefix and message
		--         source = false,    -- Don't show source
		--         severity = {
		--             min = vim.diagnostic.severity.HINT,
		--         },
		--         -- Format to show count of diagnostics when there are multiple
		--         format = function(diagnostic)
		--             -- Get all diagnostics on the current line
		--             local line_diagnostics = vim.diagnostic.get(0, {
		--                 lnum = diagnostic.lnum,
		--                 severity = diagnostic.severity,
		--             })

		--             -- If there's more than one diagnostic of this severity on this line
		--             if #line_diagnostics > 1 then
		--                 return " " .. #line_diagnostics -- Return the count
		--             end
		--             return "" -- Otherwise return empty string
		--         end,
		--     },
		--     -- Enable floating window diagnostics on cursor hold
		--     float = {
		--         source = true, -- Always show source
		--         border = "rounded", -- Add border to float window
		--         header = "", -- No header
		--         prefix = function(diagnostic)
		--             local icons = {
		--                 [1] = signs.Error .. " Error: ",
		--                 [2] = signs.Warn .. " Warning: ",
		--                 [3] = signs.Info .. " Info: ",
		--                 [4] = signs.Hint .. " Hint: ",
		--             }
		--             return icons[diagnostic.severity]
		--         end,
		--     },

		--     -- Show diagnostics with underlines
		--     underline = true,

		--     -- Update diagnostics after leaving insert mode
		--     update_in_insert = false,

		--     -- Sort diagnostics by severity
		--     severity_sort = true,

		--     -- Show signs in the sign column
		--     signs = {
		--         active = signs,
		--     },
		-- })
		-- Diagnostic configuration
		vim.diagnostic.config({
			-- Configure virtual text diagnostics
			virtual_text = false, -- Turn off default virtual text

			-- Show diagnostics with underlines
			underline = true,

			-- Update diagnostics after leaving insert mode
			update_in_insert = false,

			-- Sort diagnostics by severity
			severity_sort = true,

			-- Show signs in the sign column
			signs = {
				active = signs,
			},

			-- Enable floating window diagnostics on cursor hold
			float = {
				source = true, -- Always show source
				border = "rounded", -- Add border to float window
				header = "", -- No header
				prefix = function(diagnostic)
					local icons = {
						[1] = signs.Error .. " Error: ",
						[2] = signs.Warn .. " Warning: ",
						[3] = signs.Info .. " Info: ",
						[4] = signs.Hint .. " Hint: ",
					}
					-- Default to HINT (4) if severity is nil
					local severity = diagnostic.severity or 4
					return icons[severity], "DiagnosticFloatPrefix" -- Return two values: text and highlight group
				end,
			},
		})

		-- Create custom diagnostics display with a single icon per severity
		local ns = vim.api.nvim_create_namespace("severity_consolidation")
		local orig_signs_handler = vim.diagnostic.handlers.signs

		-- Override the built-in signs handler
		vim.diagnostic.handlers.signs = {
			show = function(_, bufnr, _, opts)
				-- Call the original handler to show signs
				orig_signs_handler.show(ns, bufnr, {}, opts)
			end,
			hide = function(_, bufnr)
				orig_signs_handler.hide(ns, bufnr)
			end,
		}

		-- Function to show consolidated diagnostics without background highlight
		local function show_consolidated_diagnostics()
			local bufnr = vim.api.nvim_get_current_buf()
			local diagnostics = vim.diagnostic.get(bufnr)

			-- Clear existing virtual text
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

			-- Group diagnostics by line and severity
			local line_diagnostics = {}
			for _, diagnostic in ipairs(diagnostics) do
				local lnum = diagnostic.lnum
				-- Default to lowest severity (4/HINT) if severity is nil
				local severity = diagnostic.severity or 4

				line_diagnostics[lnum] = line_diagnostics[lnum] or {}
				line_diagnostics[lnum][severity] = (line_diagnostics[lnum][severity] or 0) + 1
			end

			-- Define custom highlight groups without background colors
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextErrorNoBg", { fg = "#db4b4b", bg = "NONE" })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarnNoBg", { fg = "#e0af68", bg = "NONE" })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfoNoBg", { fg = "#0db9d7", bg = "NONE" })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHintNoBg", { fg = "#10B981", bg = "NONE" })

			-- Display consolidated diagnostics
			for lnum, severities in pairs(line_diagnostics) do
				local virt_texts = {}

				-- Order severities from high to low (ERROR=1, WARN=2, INFO=3, HINT=4)
				for severity = 1, 4 do
					local count = severities[severity]
					if count then
						local icon = ""
						if severity == 1 then
							icon = signs.Error
						elseif severity == 2 then
							icon = signs.Warn
						elseif severity == 3 then
							icon = signs.Info
						elseif severity == 4 then
							icon = signs.Hint
						end

						-- Use our custom no-background highlight groups
						local hl_group = "DiagnosticVirtualText"
							.. (
								severity == 1 and "ErrorNoBg"
								or severity == 2 and "WarnNoBg"
								or severity == 3 and "InfoNoBg"
								or "HintNoBg"
							)

						-- Add icon and optionally the count if more than 1
						local text = icon
						if count >= 1 then
							text = text .. " " .. count
						end

						table.insert(virt_texts, { text .. " ", hl_group })
					end
				end

				-- Add the virtual text to the line
				if #virt_texts > 0 then
					vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
						virt_text = virt_texts,
						virt_text_pos = "eol",
					})
				end
			end
		end
		-- Set up autocmd to update diagnostics display
		vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
			callback = function()
				vim.defer_fn(show_consolidated_diagnostics, 100)
			end,
		})

		-- Set up autocommand to trigger linting
		local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})

		-- Rest of your keymappings remain the same...
		-- Keymapping to manually trigger lint
		vim.keymap.set("n", "<leader>dt", function()
			require("lint").try_lint()
		end, { desc = "Trigger linting for current file" })

		-- Keymapping to show diagnostics in floating window
		vim.keymap.set("n", "<leader>df", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end, { desc = "Show diagnostics under cursor" })

		-- Diagnostic navigation keymaps (using newer Neovim API with jump function)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
		end, { desc = "Go to previous diagnostic" })

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
		end, { desc = "Go to next diagnostic" })

		-- Additional diagnostic navigation by severity (using newer API)
		vim.keymap.set("n", "[e", function()
			vim.diagnostic.jump({
				count = -1,
				severity = vim.diagnostic.severity.ERROR,
				float = { border = "rounded" },
			})
		end, { desc = "Go to previous error" })

		vim.keymap.set("n", "]e", function()
			vim.diagnostic.jump({
				count = 1,
				severity = vim.diagnostic.severity.ERROR,
				float = { border = "rounded" },
			})
		end, { desc = "Go to next error" })

		-- List all diagnostics in quickfix window
		vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "List all diagnostics in quickfix" })

		-- List buffer diagnostics in loclist window
		vim.keymap.set("n", "<leader>dw", function()
			vim.diagnostic.setloclist({ open = true })
		end, { desc = "List buffer diagnostics in loclist" })
	end,
}
