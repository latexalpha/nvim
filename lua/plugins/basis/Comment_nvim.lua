-- PLUGIN: Comment.nvim
-- FUNCTIONALITY: Smart code commenting plugin
-- SHORTCUTS: 
--   Normal mode:
--     - gcc: Toggle line comment
--     - gbc: Toggle block comment
--   Visual mode:
--     - gc: Toggle line comment
--     - gb: Toggle block comment

return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",  -- Load plugin when needed for better startup performance
    opts = {
        -- Basic configuration options
        padding = true,   -- Add a space between comment delimiter and content
        sticky = true,    -- Keep cursor position when commenting
        ignore = "^$",    -- Skip empty lines when commenting multiple lines
        
        -- For language-specific comment string configuration:
        -- To override comment string for a specific language, uncomment and adjust:
        -- languages = {
        --     -- Example: Use different comment style for a language
        --     -- cpp = { '// %s', '/* %s */' },  -- Line and block comments for C++
        --     -- python = { '# %s', '""" %s """' },  -- Line and block comments for Python
        -- },
    },
    config = function(_, opts)
        -- Initialize the plugin with our configuration
        local comment = require("Comment")
        
        -- Setup the plugin
        comment.setup(opts)
        
        -- Advanced configuration can be done here
        -- For example, you could add custom mappings:
        -- vim.keymap.set("n", "<leader>/", "gcc", { remap = true })
    end,
}