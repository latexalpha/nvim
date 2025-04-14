-- PLUGIN: lervag/vimtex
-- FUNCTIONALITY: LaTeX support for Neovim
-- FEATURES:
--  - Syntax highlighting for LaTeX documents
--  - Compilation, viewing and error handling
--  - Table of contents navigation
--  - Completion for citations, references, commands, etc.
--  - SyncTeX forward/inverse search
--  - Motion commands for LaTeX environments and sections

-- Detect the operating system by checking binary format in cpath
-- 'dll' indicates Windows, 'so' indicates Linux, 'dylib' indicates macOS
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")

-- Only load VimTeX on Windows systems
-- This is useful if your config is shared across different operating systems
-- and you only want to use VimTeX on Windows
if binaryformat == "dll" then
    return {
        "lervag/vimtex",
        ft = { "tex", "bib" }, -- Only load for LaTeX and BibTeX files
        
        config = function()
            ---------------------------
            -- PDF Viewer Configuration
            ---------------------------
            -- SumatraPDF is a lightweight PDF reader with SyncTeX support
            vim.g.vimtex_view_general_viewer = "SumatraPDF"
            
            -- Options for SumatraPDF:
            -- -reuse-instance: Use existing instance instead of opening a new one
            -- -forward-search: Jump to the position in the PDF corresponding to the cursor in the tex file
            --   @tex: placeholder for the tex filename
            --   @line: placeholder for the line number
            --   @pdf: placeholder for the PDF filename
            vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            
            -------------------------
            -- Compilation Settings
            -------------------------
            -- Use latexmk for compilation (handles dependencies automatically)
            vim.g.vimtex_compiler_method = "latexmk"
            
            -- Detailed latexmk configuration
            vim.g.vimtex_compiler_latexmk = {
                build_dir = "build",   -- Output directory for compiled files
                callback = 1,          -- Enable callback functionality for auto-updates
                continuous = 1,        -- Use continuous mode (keeps running and recompiles on changes)
                executable = "latexmk", -- Compiler executable
                options = {
                    "-verbose",          -- Verbose output for better debugging
                    "-file-line-error",  -- Show file and line info for errors
                    "-synctex=1",        -- Generate SyncTeX data for forward/reverse search
                    "-interaction=nonstopmode", -- Don't stop on errors
                },
            }
            
            -------------------------
            -- General LaTeX Settings
            -------------------------
            vim.g.tex_flavor = "latex"             -- Treat .tex files as LaTeX by default, not plain TeX
            vim.g.vimtex_indent_bib_enabled = true -- Enable smart indentation for BibTeX files
            vim.g.vimtex_format_enabled = true     -- Enable auto-formatting of LaTeX code
            
            -- Disable default insert mode mappings if using snippets (uncomment to disable)
            -- vim.g.vimtex_imaps_enabled = 0
            
            -------------------------
            -- QuickFix Window Setup
            -------------------------
            -- 0: Never open QuickFix
            -- 1: Open on warnings and errors, focus the window
            -- 2: Open on warnings and errors, don't focus the window
            vim.g.vimtex_quickfix_mode = 2
            
            -- Optionally filter out certain warning types (uncomment to enable)
            -- vim.g.vimtex_quickfix_ignore_filters = {
            --     "Underfull \\hbox",
            --     "Overfull \\hbox",
            --     "LaTeX Warning: .*item may have changed",
            -- }
            
            -------------------------
            -- Table of Contents Setup
            -------------------------
            vim.g.vimtex_toc_config = {
                mode = 1,           -- Simple mode (vs. 0 for fancy mode)
                fold_enable = 1,    -- Enable folding in TOC
                split_pos = "vert", -- Split vertically (vs. "leftabove", "rightbelow", etc.)
                split_width = 50,   -- Width of TOC window in columns
                -- Additional options (uncomment to enable)
                -- show_help = 0,      -- Don't show help text
                -- indent_levels = 1,  -- Show section indent levels
            }
            
            -------------------------
            -- Custom Keymappings
            -------------------------

            -- Compile document
            vim.keymap.set("n", "<localleader>t", "<cmd>VimtexCompile<CR>", 
                { buffer = true, desc = "Compile LaTeX document" })
            
            -- Toggle TOC
            vim.keymap.set("n", "<localleader>tt", "<cmd>VimtexTocToggle<CR>", 
                { buffer = true, desc = "Toggle LaTeX TOC" })
            
            -- Clean auxiliary files
            vim.keymap.set("n", "<leader>tc", "<cmd>VimtexClean<CR>", 
                { buffer = true, desc = "Clean LaTeX auxiliary files" })
            
            -- View PDF
            vim.keymap.set("n", "<leader>tv", "<cmd>VimtexView<CR>", 
                { buffer = true, desc = "View LaTeX PDF" })
        end,
    }
else
    -- Skip loading VimTeX on non-Windows platforms
    return {}
end