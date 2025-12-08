local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("bibtex", {
    s(
        "bibentry",
        fmt(
            [[
@{}{{{},
  author    = {{{}}},
  editor    = {{{}}},
  title     = {{{}}},
  journal   = {{{}}},
  booktitle = {{{}}},
  year      = {{{}}},
  month     = {{{}}},
  publisher = {{{}}},
  institution = {{{}}},
  school    = {{{}}},
  volume    = {{{}}},
  number    = {{{}}},
  series    = {{{}}},
  edition   = {{{}}},
  pages     = {{{}}},
  address   = {{{}}},
  chapter   = {{{}}},
  type      = {{{}}},
  note      = {{{}}},
  url       = {{{}}},
  doi       = {{{}}},
  isbn      = {{{}}},
}}
]],
            {
                i(1, "article"),     -- entry type
                i(2, "citationKey"), -- unique key
                i(3, "Author Name"),
                i(4, "Editor Name"),
                i(5, "Title of Work"),
                i(6, "Journal Name"),
                i(7, "Booktitle (if any)"),
                i(8, "2025"),
                i(9, "Month"),
                i(10, "Publisher"),
                i(11, "Institution"),
                i(12, "School"),
                i(13, "Volume"),
                i(14, "Number"),
                i(15, "Series"),
                i(16, "Edition"),
                i(17, "Pages"),
                i(18, "Address"),
                i(19, "Chapter"),
                i(20, "Type"),
                i(21, "Note"),
                i(22, "https://example.com"),
                i(23, "DOI"),
                i(24, "ISBN"),
            }
        )
    ),
})
