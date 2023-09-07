local g = vim.g

-- set `mapleader` before lazy so mappings are correct
g.mapleader = " "
g.maplocalleader = " "

-- disable netrw at the very start of init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- virtual environments settings for ruby, node and perl
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- bootstrap lazy.nvim
require("config.lazy")
