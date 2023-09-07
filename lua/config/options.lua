-- ---------------Global settings-----------------------
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
opt.splitbelow = true -- new window location
opt.ignorecase = true -- search
opt.smartcase = true
opt.termguicolors = true -- true colors
opt.signcolumn = "yes"
opt.list = true -- add for plugin indent-blankline
opt.listchars:append "eol:↴"

-- -----------------Settings according to the OS---------------------------
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
local g = vim.g

if binaryformat == "dll" then
-- --------------------Settings for Windows--------------------------------
    -- set the Nvim Global python virtual environment
    g.python3_host_prog = "C:/Users/heihi/miniconda3/python"

    -- -------------------VimTeX settings-------------------
    g.tex_flavor = 'latex'
    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_indent_bib_enabled = true
    g.vimtex_format_enabled = true

    vim.keymap.set("n", "<leader>lv",
    -- VimTeX keymap settings for preventing blank terminal when using <leader>lv
        function()
            local cwd = vim.fn.getcwd()
            local line = vim.api.nvim_win_get_cursor(0)[1]
            -- vim.cmd("call jobstart(\'powershell /s /c \"SumatraPDF -reuse-instance -forward-search \"" .. cwd .. "\\main.tex\" " .. line .. " \"" .. cwd .. "\\main.pdf\"\"\')")
            vim.cmd("call jobstart(\'powershell /c \"SumatraPDF -reuse-instance -forward-search \"" .. cwd .. "\\main.tex\" " .. line .. " \"" .. cwd .. "\\main.pdf\"\"\')")
        end,
        {desc = "Windows LaTeX View"}
    )
    function os.name()
        return "windows"
    end

elseif binaryformat == "so" then
-- ---------------------Settings for Linux----------------------------------
    g.python3_host_prog = "/home/shangyu/miniconda3/bin/python"

    -- set the Nvim python virtual environment
    vim.cmd([[
        if has("nvim") && !empty($CONDA_PREFIX)
            let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
    ]])

    function os.name()
        return "linux"
    end
end
binaryformat = nil
