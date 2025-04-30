local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	s(
		{
			trig = "env",
			desc = "LaTeX environment",
		},
		fmta(
			[[
            \begin{<>}
                <>
            \end{<>}
            ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			}
		)
	),
	s(
		{
			trig = "eq",
			desc = "LaTeX environment equation",
		},
		fmta(
			[[
                \begin{equation}
                    <>
                    % \label{equation: <>}
                \end{equation}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "equ",
			desc = "LaTeX environment stared equation",
		},
		fmta(
			[[
                \begin{equation*}
                    <>
                    % \label{equation: <>}
                \end{equation*}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "fig",
			desc = "LaTeX environment figure",
		},
		fmta(
			[[
                \begin{figure}[!htb]
                    \centering
                    \includegraphics[width=<>\textwidth]{./figures/<>}
                    % \caption{<>}
                    % \label{figure: <>}
                \end{figure}
            ]],
			{
				i(1),
				i(2),
				i(3),
				rep(2),
			}
		)
	),
	s(
		{
			trig = "table",
			desc = "LaTeX environment table",
		},
		fmta(
			[[
                \begin{table}[!htb]
                    \caption{<>}
                    \centering
                    \begin{tabularx}{\linewidth}{X X}
                    \toprule
                    <>
                    \midrule
                    \bottomrule
                    \end{tabularx}
                    % \label{table: <>}
                \end{table}
            ]],
			{
				i(2),
				i(1),
				i(0),
			}
		)
	),
	s(
		{
			trig = "cases",
			desc = "LaTeX environment cases",
		},
		fmta(
			[[
                \begin{cases}
                    <>
                \end{cases}
            ]],
			{ i(1) }
		)
	),
	s(
		{
			trig = "enum",
			desc = "LaTeX environment enumerate",
		},
		fmta(
			[[
                \begin{enumerate}[label=(<>*)] % \alph, \Alph, \roman, \arabic,
                    \item <>
                \end{enumerate}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "item",
			desc = "LaTeX Beamer itemize",
		},
		fmta(
			[[
                \begin{itemize}
                    \item <>
                    \item <>
                \end{itemize}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "align",
			desc = "LaTeX environment aligned",
		},
		fmta(
			[[
                \begin{aligned}
                    <>
                \end{aligned}
            ]],
			{
				i(1),
			}
		)
	),
	s(
		{
			trig = "part",
			desc = "LaTeX sectioning part",
		},
		fmta(
			[[
                \part{<>} % \label{part: <>}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "chap",
			desc = "LaTeX sectioning chapter",
		},
		fmta(
			[[
                \chapter{<>} % \label{chapter: <>}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "sect",
			desc = "LaTeX sectioning section",
		},
		fmta(
			[[
                \section{<>} % \label{section: <>}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "subsec",
			desc = "LaTeX sectioning subsection",
		},
		fmta(
			[[
                \subsection{<>} % \label{subsection: <>}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		{
			trig = "subsubs",
			desc = "LaTeX sectioning subsubsection",
		},
		fmta(
			[[
                \subsubsection{<>} % \label{subsubsection: <>}
            ]],
			{
				i(1),
				i(2),
			}
		)
	),
}
