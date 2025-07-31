local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
    s("comment", {
        t({ "<!-- " }),
        i(1, "Your comment here"),
        t({ " -->" }),
    }),
})
