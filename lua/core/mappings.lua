--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- MAPPINGS

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Split navigation using CTRL + {j, k, h, l}
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Split window up" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Split window down" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Split window right" })
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Split window left" })

-- Resize split windows using arrow keys
vim.keymap.set("n", "<c-up>", "<c-w>-", { desc = "Resize split window up" })
vim.keymap.set("n", "<c-down>", "<c-w>+", { desc = "Resize split window down" })
vim.keymap.set("n", "<c-right>", "<c-w>>", { desc = "Resize split window right" })
vim.keymap.set("n", "<c-left>", "<c-w><", { desc = "Resize split window left" })

-- Undo Tree
vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

--Deleting a word at a time.
vim.keymap.set("i", "<C-BS>", "<C-W>", { desc = "Delete word", noremap = true, silent = true })

-- ============[Scripts]===================================================================================

-- Run ":so" after writing .zshrc
cmd("autocmd BufWritePost ~/.zshrc so %")

-- Run "xrdb" after writing .Xresources
cmd("autocmd BufWritePost ~/.Xresources !xrdb %")

vim.diagnostic.config({
    virtual_text = true, -- Enables inline error messages
    signs = true,        -- Shows signs in the gutter
    underline = true,    -- Underlines errors in the code
})

vim.keymap.set("n", "<leader>E", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline errors" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" }) -- Change color as needed
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#55ff55" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#5555ff" })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555", bg = "NONE" }) -- Adjust color to be faded
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#55ff55", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#5555ff", bg = "NONE" })

vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "NONE" })

vim.diagnostic.open_float()

vim.schedule(function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#f53c63", bg = "NONE" })
end)

-- =================[Auto-commands]============================================================================

-- Auto-save after __ time.
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            if vim.bo.modified and vim.bo.filetype ~= "" and vim.fn.expand("%") ~= "" then
                vim.cmd("silent! write")
            end
        end, 3000) -- 3000 ms = 3 seconds
    end,
})

-- for hebrew and English language directions.

vim.keymap.set("n", "<leader>hi", function()
    vim.opt.keymap = "hebrew"
    vim.opt.iminsert = 1
    vim.opt.rightleft = true
end, { desc = "Enable Hebrew input mode" })

vim.keymap.set("n", "<leader>hn", function()
    vim.opt.keymap = ""
    vim.opt.iminsert = 0
    vim.opt.rightleft = false
end, { desc = "Normal mode (LTR)" })

-- Solid Background for snacks.explorer
vim.api.nvim_set_hl(0, "SnacksPicker", {
    bg = "#1e1e1e", -- Replace with your desired hex color
    -- fg = "#cdd6f4", -- Optional: set foreground color for contrast
})

-- Support for Right to Left coding style.
-- e.g inorder to type `let var = 4;`, I find it convenient to type the RIGHT hand side first.
-- thus:
-- I type `4;` then `C-h` then `let var = `

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "scala", "sh", "lua" }, -- add your language here.
    callback = function()
        local feed = function(keys)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
        end

        local luasnip = require("luasnip")

        -- Start of line
        vim.keymap.set("i", "<C-h>", function()
            feed("<Esc>I")
        end, { buffer = true })

        -- End of line
        vim.keymap.set("i", "<C-l>", function()
            feed("<Esc>A")
        end, { buffer = true })

        -- Conditional move up
        vim.keymap.set("i", "<C-k>", function()
            if not luasnip.in_snippet() then
                feed("<Esc>k^i")
            end
        end, { buffer = true })

        -- Conditional move down
        vim.keymap.set("i", "<C-j>", function()
            if not luasnip.in_snippet() then
                feed("<Esc>j^i")
            end
        end, { buffer = true })
    end,
})
