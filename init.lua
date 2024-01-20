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

    if vim.g.vscode then
        -- VSCode extension
    else
        -- ordinary Neovim
    end

    g.python3_host_prog = "C:/Users/heihi/miniconda3/python"
    -- set the Nvim python virtual environment
    vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "\\python.exe"
    ]])

    -- -------------------VimTeX settings-------------------
    g.tex_flavor = 'latex'
    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_indent_bib_enabled = true
    g.vimtex_format_enabled = false
    g.vimtex_view_general_viewer = 'SumatraPDF'
    g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    --
elseif binaryformat == "so" then

    g.python3_host_prog = "/home/shangyu/miniconda3/bin/python"
    -- set the Nvim python virtual environment
    vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
    ]])
    end
binaryformat = nil

-- bootstrap lazy.nvim
require("core.lazy")
