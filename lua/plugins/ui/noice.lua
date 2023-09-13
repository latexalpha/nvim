return {-- noicer ui
    "folke/noice.nvim",
    event = "VeryLazy",

    dependencies = {
        {
            "MunifTanjim/nui.nvim",
            lazy = true,
        },
        {
            "rcarriga/nvim-notify",
            config = function ()
                require("notify").setup({
                    background_colour = "#1e1e2e",
                })
            end
        },
    },

    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
        },
    },

}
