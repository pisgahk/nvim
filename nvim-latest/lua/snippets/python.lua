-- snippets/python.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("imp", t("import "), i(1, "module")),
	s("def", {
		t("def "),
		i(1, "function"),
		t("("),
		i(2),
		t("):"),
		t({ "", "\t" }),
		i(3),
	}),
}
