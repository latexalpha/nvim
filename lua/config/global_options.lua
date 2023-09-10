local opt = vim.opt

opt.clipboard = "unnamedplus" -- clipboard
opt.relativenumber = true -- number line
opt.number = true
opt.tabstop = 4 -- indent
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = true -- wrap
opt.cursorline = true -- cursor
opt.mouse:append("a") -- mouse
opt.splitright = true -- new window location
opt.splitbelow = true
opt.ignorecase = true -- search
opt.smartcase = true
opt.termguicolors = true -- true colors
opt.signcolumn = "yes"

-- add for plugin indent-blankline
opt.list = true
opt.listchars:append "eol:↴"

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
    virtual_text = false,
})

