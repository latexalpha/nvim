local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	s({ -- add inline math environments
		trig = "e,",
		desc = "add inline math environment",
	}, {
		t("$"),
		i(1),
		t("$"),
	}),
	s({
		trig = "a,",
		desc = "alpha",
	}, {
		t("\\alpha"),
	}),
	s({
		trig = "b,",
		desc = "beta",
	}, {
		t("\\beta"),
	}),
	s({
		trig = "g,",
		desc = "gamma",
	}, {
		t({ "\\gamma" }),
	}),
	s({
		trig = "G,",
		desc = "Gamma",
	}, {
		t({ "\\Gamma" }),
	}),
	s({
		trig = "l,",
		desc = "lambda",
	}, {
		t({ "\\lambda" }),
	}),
	s({
		trig = "L,",
		desc = "Lambda",
	}, {
		t({ "\\Lambda" }),
	}),
	s({
		trig = "t,",
		desc = "theta",
	}, {
		t({ "\\theta" }),
	}),
	s({
		trig = "T,",
		desc = "Theta",
	}, {
		t({ "\\Theta" }),
	}),
	s({
		trig = "frac",
		desc = "Expands 'frac' into '\\frac{}{}' ",
	}, {
		t("\\frac{"),
		i(1), -- insert node 1
		t("}{"),
		i(2), -- insert node 2
		t("}"),
	}),
	s({
		trig = "mbb",
		desc = "Expand 'mbb' into  '\\mathbb' ",
	}, {
		t("$\\mathbb{"),
		i(1), --insert node 1
		t("}$"),
	}),
}
