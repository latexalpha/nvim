-- FUNCTIONALITY: keymaps
vim.g.mapleader = " "

local map = vim.keymap.set

map({ "n", "i", "x" }, "jk", "<ESC>")
map("t", "jk", "C-\\><C-n>")

-- move selected line / block of text in visual mode
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected texts down. " })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected texts up. " })
map("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit buffer " }) -- set :q keymap
map("n", "<leader>wt", "<CMD>w<CR>", { desc = "Write buffer. " }) -- set :w keymap
map("n", "<leader>wq", "<CMD>wq<CR>", { desc = "Write and quit " }) -- set :wq keymap
map("n", "<leader>hl", "<cmd>noh<CR>", { desc = "NO highlight " }) -- set no highlight keymap
map("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Checkhealth" })

-- keymaps for diagnostics
-- map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window. " }) -- represents diagnostic open_float
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic in the current buffer " }) -- represents diagnostic goto_prev
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Get the next diagnostic closest to the cursor position. " }) -- represents diagnostic goto_next
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list. " }) -- represents diagnostic setloclist

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
	end,
})
