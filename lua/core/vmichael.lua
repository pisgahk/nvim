-- vmichael.lua
-- Translated from vmichael.vim
-- Original colors sourced from github.com/CosecSecCot/cosec-twilight.nvim

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "vmichael"

local hi = vim.api.nvim_set_hl

-- ── Core UI ─────────────────────────────────────────────────────────
hi(0, "Normal", { fg = "#FEFEFE", bg = "#202020" })
hi(0, "NormalFloat", { fg = "#FEFEFE", bg = "#202020" })
hi(0, "Conceal", { bg = "#262626" })
hi(0, "NonText", { fg = "#303030" })
hi(0, "VertSplit", { fg = "#303030" })
hi(0, "WinSeparator", { fg = "#888888", bg = "#111111" })
hi(0, "Visual", { bg = "#454545" })

-- ── Line numbers ────────────────────────────────────────────────────
hi(0, "LineNr", { fg = "#d6d2c8" })
hi(0, "LineNrAbove", { fg = "#888888", bg = "#222222" })
hi(0, "LineNrBelow", { fg = "#888888", bg = "#222222" })

-- ── Syntax ──────────────────────────────────────────────────────────
hi(0, "Comment", { fg = "#6f7b68" })
hi(0, "TSComment", { fg = "#6f7b68" })
hi(0, "Constant", { fg = "#cccccc" })
hi(0, "String", { fg = "#A2A970" })
hi(0, "Float", { fg = "#6f7b68" })
hi(0, "Number", { fg = "#6f7b68" })
hi(0, "Boolean", { fg = "#6f7b68" })
hi(0, "Function", { fg = "#AA9AAC" })
hi(0, "Identifier", { fg = "#8B9698" })
hi(0, "Operator", { fg = "#DEBF7C" })
hi(0, "PreProc", { fg = "#8B9698" })
hi(0, "Special", { fg = "#cccccc" })
hi(0, "SpecialChar", { fg = "#C1C88D" })
hi(0, "SpecialKey", { fg = "#676767" })
hi(0, "Statement", { fg = "#cccccc" })
hi(0, "Structure", { fg = "#AA9AAC" })
hi(0, "Todo", { fg = "#8B9698" })
hi(0, "Type", { fg = "#E3D896" })
hi(0, "Underlined", { undercurl = true })
hi(0, "Directory", { fg = "#C1C88D" })

-- ── Errors & warnings ───────────────────────────────────────────────
hi(0, "Error", { fg = "#C34143", undercurl = true })
hi(0, "ErrorMsg", { fg = "#FFFEDB" })
hi(0, "WarningMsg", { fg = "#FFFEDB" })

-- ── Diff ────────────────────────────────────────────────────────────
hi(0, "DiffAdd", { fg = "#FFFEDB", bg = "#2B3328" })
hi(0, "DiffChange", { fg = "#FFFEDB", bg = "#262636" })
hi(0, "DiffDelete", { fg = "#C34143", bg = "#42242B" })
hi(0, "DiffText", { fg = "#FFFEDB", bg = "#49443C" })

-- ── Popup menu ──────────────────────────────────────────────────────
hi(0, "Pmenu", { fg = "#918988", bg = "#303030" })
hi(0, "PmenuSbar", { fg = "#918988", bg = "#262626" })
hi(0, "PmenuSel", { fg = "#BFBBBA", bg = "#303030" })
hi(0, "PmenuThumb", { fg = "#918988", bg = "#262626", reverse = true })

-- ── Search ──────────────────────────────────────────────────────────
hi(0, "Search", { bg = "#5F5958" })
hi(0, "Substitute", { fg = "#1A1A1A", bg = "#C1C88D" })
hi(0, "MatchParen", { fg = "#FFFEDB" })
hi(0, "QuickFixLine", { bg = "#303030" })

-- ── Status & tabs ───────────────────────────────────────────────────
hi(0, "StatusLine", { fg = "#FFFEDB", bg = "#34383C" })
hi(0, "TabLine", { fg = "#A09998", bg = "#212121" })
hi(0, "TabLineFill", { fg = "#A09998", bg = "#212121" })
hi(0, "TabLineSel", { fg = "#A09998", bg = "#40474F" })

-- ── Misc ────────────────────────────────────────────────────────────
hi(0, "Question", { fg = "#9b8d7f" })
hi(0, "Title", { fg = "#FFFEDB", bold = false, italic = false })

-- ── Treesitter / markdown ────────────────────────────────────────────
hi(0, "@markup.link.label.markdown_inline", { cterm = {} })
