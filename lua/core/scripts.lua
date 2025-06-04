--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- SCRIPTS

-- Colorscheme
--cmd("colorscheme catppuccin-mocha")

-- Format on save (Commented out because Conform.nvim takes care of this)
--cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")

-- Run ":so" after writing .zshrc
cmd("autocmd BufWritePost ~/.zshrc so %")

-- Run "xrdb" after writing .Xresources
cmd("autocmd BufWritePost ~/.Xresources !xrdb %")

vim.diagnostic.config({
	virtual_text = true, -- Enables inline error messages
	signs = true, -- Shows signs in the gutter
	underline = true, -- Underlines errors in the code
})

vim.keymap.set("n", "<leader>E", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline errors" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" }) -- Change color as needed
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#55ff55" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#5555ff" })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#888888", bg = "NONE" }) -- Adjust color to be faded
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#aaaaaa", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#bbbbbb", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#cccccc", bg = "NONE" })

vim.diagnostic.open_float()

-- Removing the bg colour from inlay hints.
--vim.api.nvim_set_hl(0, "InlayHint", { bg = "NONE" })
