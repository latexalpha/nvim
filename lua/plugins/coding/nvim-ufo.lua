-- PLUGIN: nvim-ufo
-- FUNCTIONALITY: folding and unfolding code blocks
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
-- vim.o.foldenable = false -- show fold level
vim.o.foldenable = true -- show fold level

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		{
			"kevinhwang91/promise-async",
		},
		{
			"nvim-treesitter/nvim-treesitter",
		},
	},
	config = function()
		local ufo = require("ufo")
		ufo.setup({
			open_fold_hl_timeout = 400,
			close_fold_kinds_for_ft = { default = { default = {} } },
			fold_virt_text_handler = handler,
			enable_get_fold_virt_text = false,
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
	end,
}
