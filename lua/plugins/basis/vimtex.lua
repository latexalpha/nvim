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
			-- Set viewer method
			vim.g.vimtex_view_general_viewer = "SumatraPDF"
			vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

			-- Compiler settings
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build", -- Output directory for compiled files
				callback = 1, -- Enable callback functionality
				continuous = 1, -- Use continuous mode
				executable = "latexmk", -- Compiler executable
				options = {
					"-verbose", -- Verbose output
					"-file-line-error", -- Line error reporting
					"-synctex=1", -- Enable SyncTeX
					"-interaction=nonstopmode", -- Don't stop on errors
				},
			}

			-- Disable imaps (insert mode mappings) if you prefer to use snippets
			-- vim.g.vimtex_imaps_enabled = 0

			-- QuickFix window settings
			vim.g.vimtex_quickfix_mode = 2 -- Open quickfix automatically if there are errors

			-- TOC settings
			vim.g.vimtex_toc_config = {
				mode = 1, -- Simple mode
				fold_enable = 1, -- Enable folding
				split_pos = "vert", -- Split vertically
				split_width = 30, -- Width of TOC window
			}
		end,
	}
else
	-- Skip loading VimTeX on non-Windows platforms
	return {}
end
