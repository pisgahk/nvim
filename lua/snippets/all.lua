local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("rust", {
    s("drv", {
        t("#[derive("),
        i(1, "Debug, Clone"),
        t(")]"),
        t("Snippet testing from lua/snippets/all.lua"),
    }),
})
