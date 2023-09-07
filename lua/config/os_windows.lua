local g = vim.g

-- set the Nvim Global python virtual environment
g.python3_host_prog = "C:/Users/heihi/miniconda3/python"

-- use lazy.nvim to manage plugins
require("lazy").setup({
    spec = {
        { import = "plugins.wondows" },
    }
})

-- -------------------VimTeX settings-------------------
g.tex_flavor = 'latex'
g.vimtex_compiler_method = 'latexmk'
g.vimtex_indent_bib_enabled = true
g.vimtex_format_enabled = true
-- g.vimtex_view_general_viewer = 'SumatraPDF' -- pdf reader settings
-- g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

-- VimTeX keymap settings for preventing blank terminal when using <leader>lv
vim.keymap.set("n", "<leader>lv",
    function()
        local cwd = vim.fn.getcwd()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        -- vim.cmd("call jobstart(\'powershell /s /c \"SumatraPDF -reuse-instance -forward-search \"" .. cwd .. "\\main.tex\" " .. line .. " \"" .. cwd .. "\\main.pdf\"\"\')")
        vim.cmd("call jobstart(\'powershell /c \"SumatraPDF -reuse-instance -forward-search \"" .. cwd .. "\\main.tex\" " .. line .. " \"" .. cwd .. "\\main.pdf\"\"\')")
    end,
    {desc = "Windows LaTeX View"}
)
