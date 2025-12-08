-- redrust.lua
-- A red-centric Neovim colourscheme for Rust

local redrust = {}

-- Define palette
local palette = {
    bg = "#1A0B0B",
    fg = "#E6DADA",
    cursorln = "#2A1414",
    comment = "#A68A8A",
    keyword = "#FF4C4C",
    type = "#CC3333",
    func = "#FF6666",
    macro = "#FF1A1A",
    string = "#FF9999",
    number = "#FF8080",
    boolean = "#CC4444",
    error = "#FF0000",
    warning = "#FF5E5E",
    info = "#B3A6A6",
    linenr = "#664C4C",
    statusln = "#330F0F",
    visual = "#4C1F1F",
}

-- Apply highlights
local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Core UI
hi("Normal", { fg = palette.fg, bg = palette.bg })
hi("CursorLine", { bg = palette.cursorln })
hi("LineNr", { fg = palette.linenr })
hi("StatusLine", { fg = palette.fg, bg = palette.statusln })
hi("Visual", { bg = palette.visual })

-- Syntax
hi("Comment", { fg = palette.comment, italic = true })
hi("Keyword", { fg = palette.keyword, bold = true })
hi("Type", { fg = palette.type })
hi("Function", { fg = palette.func })
hi("Macro", { fg = palette.macro })
hi("String", { fg = palette.string })
hi("Number", { fg = palette.number })
hi("Boolean", { fg = palette.boolean })

-- Diagnostics
hi("Error", { fg = palette.error, bold = true })
hi("WarningMsg", { fg = palette.warning })
hi("InfoMsg", { fg = palette.info })

-- Rust-specific tweaks (treesitter groups)
hi("@keyword.rust", { fg = palette.keyword, bold = true })
hi("@type.rust", { fg = palette.type })
hi("@function.rust", { fg = palette.func })
hi("@macro.rust", { fg = palette.macro })
hi("@string.rust", { fg = palette.string })
hi("@number.rust", { fg = palette.number })
hi("@boolean.rust", { fg = palette.boolean })

return redrust
