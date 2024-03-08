-- FUNCTION: LaTeX support
-- Only return configuration on Windows
local binaryformat = package.cpath:match("%p[\\|/]?%p(%a+)")

if binaryformat == "dll" then
	return {
		"lervag/vimtex",
	}
else
	return {}
end
