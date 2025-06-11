local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta

local substitute = function(str)
	local ret = str
	local p, n = ret:gsub("[vsx]", ".")
	if str:match("v") or n > 1 then
		ret = p:gsub(string.rep(".", n), "v")
	end
	p, n = ret:gsub("!", ".")
	if n then
		p, n = p:gsub("[ic]", ".")
		ret = str:gsub(string.rep(".", n), "ic")
	end
	return ret
end

local keymap_make_modes = function(args)
	local ret = ""
	local pattern = ""
	if args == "" then
		pattern = "nvo"
	else
		local modes = { "n", "!", "i", "c", "v", "x", "s", "o", "t", "l" }
		for char in modes do
			pattern = pattern .. args:match(char)
		end
		pattern = substitute(pattern) -- remove equivalent mode args
	end

	if pattern:len() > 1 then
		ret = "{ "
		pattern:gsub(".", function(char)
			ret = ret .. string.format("'%s', ", char)
		end)
		ret = ret:gsub(".%s$", " }") -- remove last comma
	else
		ret = string.format("'%s'", pattern)
	end
	return ret
end

-- "<buffer>", "<nowait>", "<silent>", "<script>", "<expr>" and "<unique>"
-- see :h map-modes
-- modes "" norm vis sel opr, "n" norm, "i" ins, "v" vis and select, 
-- "x" vis, "!" ins and cmd, "s" select, "o" opr, "t" term 
-- ia abbreviation in insert, "ca" abbr. cmdline, !a both
local snippets = {
	s({ trig = "keymap", name = "vim.keymap.set", desc = "Dynamic keymap set"},
		fmta("vim.keymap.set(<mode>, '<lhs>', <rhs>, { <><><><><><><> })", {
			mode = sn(1, { i(1, "n"), f(keymap_make_modes, {1}, {})}),
		  lhs = i(2, "lhs"), rhs = i(3, "rhs"),
		c(4, { t(""), t("remap = true, ") }),
		c(5, { t(""), t("silent = true, ") }),
		c(6, { t(""), t("nowait = true, ") }),
		c(7, { t(""), t("expr = true, ")}),
		c(8, { t(""), t("unique = true, ")}),
		c(9, { t(""), sn(nil, {t("buffer = "), i(1, "true"), t(", ")})}),
		c(10, { sn(nil, {t("desc = "), i(1)}), t("")}),
		})
	),
}

local autosnippets = {}

local M = { snippets = snippets, autosnippets = snippets, ft = "lua"}
return M
