-- FUNCTION: comment for codes
return {
    "numToStr/Comment.nvim",
    opts = {
        padding = true,
        ignore = '^$', -- ignore empty line
    },
    config = function(_, opts)
        require("Comment").setup(opts)
    end
}
