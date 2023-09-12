local g = vim.g

-- set the Nvim Global python virtual environment
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
g.vimtex_format_enabled = true
-- g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
