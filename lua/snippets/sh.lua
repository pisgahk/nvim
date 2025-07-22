local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Bash shebang snippet
  s("bash(shebang)", {
    t("#!/usr/bin/env bash"),
    t(""),
    t(""),
    i(0),
  }),

  -- Zsh shebang snippet
  s("zsh(shebang)", {
    t("#!/usr/bin/env zsh"),
    t(""),
    t(""),
    i(0),
  }),
}

