-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
--
-- return {
--     s("imp", t("import "), i(1, "module")),
--     s("def", {
--         t("def "),
--         i(1, "function"),
--         t("("),
--         i(2),
--         t("):"),
--         t({ "", "\t" }),
--         i(3),
--     }),
-- }

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Parses the __init__ param string and builds one "self.x = x" line per param
local function self_assignments(args)
	local param_str = args[1][1] or ""
	local lines = {}
	for param in string.gmatch(param_str, "([^,]+)") do
		local name = param:match("^%s*([%w_]+)")
		if name then
			table.insert(lines, "\t\tself." .. name .. " = " .. name)
		end
	end
	if #lines == 0 then
		return sn(nil, { t("") })
	end
	return sn(nil, { t(lines) })
end

return {
	-- Import module wala hai.
	s("imp", t("import "), i(1, "module")),

	-- Function definition ka hai.
	s("def", {
		t("def "),
		i(1, "function"),
		t("("),
		i(2),
		t("):"),
		t({ "", "\t" }),
		i(3),
	}),

	-- Class definition ka hai. Todi karab hai, repair karo.
	s("class_def", {
		t("class "),
		i(1, "ClassName"),
		t("("),
		i(2, "ClassParams"),
		t({ "):", "\tdef __init__(self, " }),
		i(3, "params"),
		t({ "):", "\t\tsuper().__init__()" }),
		d(4, self_assignments, { 3 }),
		t({ "", "\tdef " }),
		i(5, "fn"),
		t("(self, "),
		i(6, "x"),
		t({ "):", "\t\t" }),
		i(0),
	}),
}
