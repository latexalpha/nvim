local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return{
    s(
        {
            trig = "snip",
            desc = "Snippets structure",
        },
        fmta(
            [[
                s(
                    {
                        trig = "<>",
                        desc = "<>",
                    },
                    fmta(
                        [[
                            <>
                        ]-],
                        {
                            i(1),
                        }
                    )
                ),
            ]],
            {
                i(1),
                i(2),
                i(3),
            }
        )
    )
}
