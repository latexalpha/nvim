-- FUNCTION: file formatting
return {
    "jose-elias-alvarez/null-ls.nvim",

    config = function()
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local null_ls = require("null-ls")

        local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")
        if binaryformat == "dll" then
            Sources = {
                null_ls.builtins.formatting.black, -- formatting for python
                null_ls.builtins.formatting.latexindent, -- formatting for latex
            }
        else
            Sources = {
                null_ls.builtins.formatting.black, -- formatting for python
            }

        end
        binaryformat = nil

        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
            sources = Sources,
        })
    end
}
