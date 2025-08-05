local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
        s("htmx-script", {
            t({
            '<script src="https://unpkg.com/htmx.org@1.9.10"',
            'integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC"',
            'crossorigin="anonymous"></script>'

            }),
        }),

    s("tailwindcss-script", {
        t({
            '<script src="https://cdn.tailwindcss.com"></script>'
        }),
    }),
}
