-- PLUGIN: lervag/vimtex
-- FUNCTIONALITY: neovim plugin for LaTeX support
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")

if binaryformat == "dll" then
	return {
		"lervag/vimtex",
	}
else
-- Only return configuration on Windows
	return {}
end
