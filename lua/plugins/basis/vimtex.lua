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

			-------------------------
			-- General LaTeX Settings
			-------------------------
			vim.g.tex_flavor = "latex" -- Treat .tex files as LaTeX by default, not plain TeX
			vim.g.vimtex_indent_bib_enabled = true -- Enable smart indentation for BibTeX files
			vim.g.vimtex_format_enabled = false -- Enable auto-formatting of LaTeX code

			-------------------------
			-- Custom Keymappings
			-------------------------
			-- Toggle TOC
			vim.keymap.set(
				"n",
				"<localleader>tt",
				"<cmd>VimtexTocToggle<CR>",
				{ buffer = true, desc = "Toggle LaTeX TOC" }
			)

			-- Clean auxiliary files
			vim.keymap.set(
				"n",
				"<leader>tc",
				"<cmd>VimtexClean<CR>",
				{ buffer = true, desc = "Clean LaTeX auxiliary files" }
			)
		end,
	}
else
	-- Skip loading VimTeX on non-Windows platforms
	return {}
end
