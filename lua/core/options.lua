-- FUNCTIONALITY: set options
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
opt.list = true -- lists
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")
