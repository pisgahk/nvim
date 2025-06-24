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

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#cccccc", bg = "NONE" }) -- Adjust color to be faded
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#aaaaaa", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#bbbbbb", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#cccccc", bg = "NONE" })

vim.diagnostic.open_float()

vim.schedule(function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#f53c63", bg = "NONE" })
end)

-- =================[Autocommands]============================================================================

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
