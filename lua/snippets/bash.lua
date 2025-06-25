local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Bash shebang snippet
  s("bash", {
    t("#!/usr/bin/env bash"),
    t(""), -- empty line
    t(""),
    i(0),
  }),

  -- Zsh shebang snippet
  s("zsh", {
    t("#!/usr/bin/env zsh"),
    t(""), -- empty line
    t(""),
    i(0),
  }),
}

