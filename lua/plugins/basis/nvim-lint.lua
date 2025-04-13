-- PLUGIN: nvim-lint
-- FUNCTIONALITY: Asynchronous linting for Neovim
--
-- PREREQUISITES:
-- - Linters are automatically installed via Mason tool installer

return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy", -- Load plugin only when needed for better performance
    config = function()
        local lint = require("lint")

        -- Configure linters for specific file types
        lint.linters_by_ft = {
            lua = { "luacheck" }, -- Lua static analyzer
            markdown = { "markdownlint" }, -- Markdown style checker
            -- python = { "ruff" },       -- Fast Python linter (uncomment to enable)
        }

        -- Custom linter configurations for Neovim development
        lint.linters.luacheck.args = {
            "--globals", "vim",        -- Allow 'vim' global in Lua files
            "--no-max-line-length",    -- Disable line length warnings
            "--no-unused-args",        -- Disable unused arguments warnings (useful for callbacks)
        }

        -- Configure markdownlint
        lint.linters.markdownlint.args = {
            "--disable", "MD013",      -- Disable line length warnings
            "--disable", "MD033",      -- Allow inline HTML
        }

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●", -- Use a symbol for virtual text
                source = "if_many",
            },
            severity_sort = true,      -- Show most severe diagnostics first
            underline = true,          -- Underline diagnostic regions
            update_in_insert = false,  -- Only update diagnostics after leaving insert mode
        })

        -- Set up autocommand to trigger linting
        local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                require("lint").try_lint()
            end,
        })

        -- Keymapping to manually trigger lint
        vim.keymap.set("n", "<leader>lt", function()
            require("lint").try_lint()
        end, { desc = "Trigger linting for current file" })
    end,

    -- Add Mason dependencies for automatic linter installation
    dependencies = {
        "williamboman/mason.nvim",
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            config = function()
                require("mason-tool-installer").setup({
                    -- Automatically install these linters
                    ensure_installed = {
                        "luacheck",      -- Lua linter
                        "markdownlint",  -- Markdown linter
                        -- "ruff",       -- Python linter (uncomment to enable)
                    },
                    auto_update = true,   -- Keep tools updated
                    run_on_start = true,  -- Install/update tools when Neovim starts
                })
            end,
        },
    },
}