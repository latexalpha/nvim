local g = vim.g

g.python3_host_prog = "/home/shangyu/miniconda3/bin/python"

-- -- set the Nvim python virtual environment
-- vim.cmd([[
--     if has("nvim") && !empty($CONDA_PREFIX)
--         let g:python3_host_prog = $CONDA_PREFIX . "/bin/python"
-- ]])
