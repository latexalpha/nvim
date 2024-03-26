-- FUNCTIONALITY: keymaps
vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jk", "<ESC>")
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
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window. " }) -- represents diagnostic open_float
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic in the current buffer " }) -- represents diagnostic goto_prev
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Get the next diagnostic closest to the cursor position. " }) -- represents diagnostic goto_next
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list. " }) -- represents diagnostic setloclist

-- --------------------Plugin keymaps--------------------
-- telescope.nvim
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find_files" })
map("n", "<leader>fg", builtin.live_grep, { desc = " Telescope live_grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope bffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help_tags" })
map("n", "<leader>ks", builtin.keymaps, { desc = "Telescope keymaps" })

-- nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTreeToggle" })

-- nvim-dap
map("n", "<F5>", function()
	require("dap").continue()
end, { desc = "DAP continue" })
map("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "Step over" })
map("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "Step into" })
map("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "Step out" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breqkpoint" })
map("n", "<leader>ds", function()
	require("dap").set_breakpoint()
end, { desc = "Set breakpoint" })
map("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "Open Repl" })

map("n", "<leader>dt", function()
	require("dapui").toggle()
end, { desc = "Toggle DAPui" })

-- Noice
map("n", "<leader>nl", function()
	require("noice").cmd("last")
end, { desc = "Noice Last Message." })
map("n", "<leader>nh", function()
	require("noice").cmd("history")
end, { desc = "Noice History" })
map("n", "<leader>na", function()
	require("noice").cmd("all")
end, { desc = "Noice All" })
map("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })
map({ "i", "n", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true, desc = "Scroll forward." })
map({ "i", "n", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true, desc = "Scroll backward." })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
	end,
})
