local g = vim.g

-- set `mapleader` before lazy so mappings are correct
g.mapleader = " "
g.maplocalleader = " "

-- disable netrw at the very start of init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- require settings according to the OS
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
if binaryformat == "dll" then
	require("config.os_windows")
    function os.name()
        return "windows"
    end
elseif binaryformat == "so" then
	require("config.os_linux")
    function os.name()
        return "linux"
    end
end
binaryformat = nil

-- bootstrap lazy.nvim
require("config.lazy")
