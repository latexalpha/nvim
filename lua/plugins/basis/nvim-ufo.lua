-- PLUGIN: nvim-ufo
-- FUNCTIONALITY: Enhanced code folding with modern UI
-- FEATURES:
--  - Uses treesitter for more accurate folding
--  - Clean fold preview with customizable UI
--  - Shows number of folded lines
--  - Supports multiple folding providers

-- Configure global folding behavior
vim.o.foldcolumn = "1" -- Show a column indicating fold levels (set to "0" to disable)
vim.o.foldlevel = 99 -- Use high fold level to keep folds open by default
vim.o.foldlevelstart = 99 -- Start with all folds open when opening a new file
vim.o.foldenable = true -- Enable folding functionality

-- Custom handler for fold text display
-- This function formats how folded text appears in the buffer
-- It shows a summary of the folded region with line count
local function fold_text_handler(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	-- Create suffix showing the number of folded lines
	local suffix = (" 󰁂 %d "):format(endLnum - lnum) -- Unicode icon + line count
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0

	-- Process each chunk of the virtual text
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)

		-- Add chunks until we reach the target width
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			-- Truncate the chunk if it's too long
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)

			-- Add padding if necessary
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end

	-- Add the suffix with line count in MoreMsg highlight group
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

return {
	"kevinhwang91/nvim-ufo",
	-- Dependencies required by nvim-ufo
	dependencies = {
		"kevinhwang91/promise-async", -- Async library for better performance
		"nvim-treesitter/nvim-treesitter", -- Required for treesitter-based folding
	},

	config = function()
		local ufo = require("ufo")

		ufo.setup({
			-- Highlighting timeout for opened folds (in ms)
			open_fold_hl_timeout = 400,

			-- Customize which fold kinds to close for specific filetypes
			close_fold_kinds_for_ft = {
				default = { default = {} }, -- Empty means no automatic fold closing
			},

			-- Use our custom fold text handler
			fold_virt_text_handler = fold_text_handler,

			-- Disable custom virtual text for gets
			enable_get_fold_virt_text = false,

			-- Configure the preview window
			preview = {
				win_config = {
					-- Minimal border (bottom line only)
					border = { "", "─", "", "", "", "─", "", "" },
					-- Use Folded highlight for preview window
					winhighlight = "Normal:Folded",
					-- No transparency
					winblend = 0,
				},
				-- Navigation keymaps within preview window
				mappings = {
					scrollU = "<C-u>", -- Scroll up
					scrollD = "<C-d>", -- Scroll down
					jumpTop = "[", -- Jump to top
					jumpBot = "]", -- Jump to bottom
				},
			},

			-- Configure which providers to use for folding
			provider_selector = function()
				-- Return array of providers in order of preference
				return { "treesitter", "indent" } -- Try treesitter first, fall back to indent
			end,
		})

		-- Keymaps for folding
		-- zR: Open all folds
		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		-- zM: Close all folds
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
		-- zr: Increase fold level
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
		-- zm: Decrease fold level
		vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })
		-- K: Preview fold (if line is folded, otherwise show hover doc)
		vim.keymap.set("n", "K", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				-- If no fold found, show hover documentation instead
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold or hover doc" })
	end,
}
