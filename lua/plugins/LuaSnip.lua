-- FUNCTION: snippets management
return {
    "L3MON4D3/LuaSnip",
    config = function()
        local snippath = vim.fn.stdpath("config") .. "/lua/snippets"
        require("luasnip.loaders.from_lua").lazy_load(
            { paths = snippath }
        )
    end,
}
