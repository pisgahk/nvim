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

-- Navigation across buffers using CTRL + {j, k, h, l}
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Navigate up" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Navigate down" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Navigate right" })
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Navigate left" })

-- Resize split windows using arrow keys
vim.keymap.set("n", "<c-up>", "<c-w>-", { desc = "Resize split window up" })
vim.keymap.set("n", "<c-down>", "<c-w>+", { desc = "Resize split window down" })
vim.keymap.set("n", "<c-right>", "<c-w>>", { desc = "Resize split window right" })
vim.keymap.set("n", "<c-left>", "<c-w><", { desc = "Resize split window left" })

-- Undo Tree
vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

--Deleting a word at a time.
vim.keymap.set("i", "<C-BS>", "<C-W>", { desc = "Delete word", noremap = true, silent = true })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Typst Live Preview with Zathura
vim.keymap.set("n", "<leader>tl", function()
	local file = vim.fn.expand("%:p") -- full path of current file
	local pdf = vim.fn.expand("%:p:r") .. ".pdf"

	-- Run typst watch in background
	vim.fn.jobstart({ "typst", "watch", file }, { detach = true })

	-- Open Zathura on the PDF
	vim.fn.jobstart({ "zathura", pdf }, { detach = true })
end, { desc = "Typst live preview in Zathura" })

-- -- Disabling Inlay hints for typst to avoid double inlay hints.
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client.name == "typst-lsp" then
--             -- Disable inlay hints for Typst
--             vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
--         end
--     end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "typst-lsp" then
			-- Disable inlay hints for Typst
			vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
		end
	end,
})

-- ============[Scripts]===================================================================================

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

-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" }) -- Change color as needed
-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#55ff55" })
-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#5555ff" })
--
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555", bg = "NONE" }) -- Adjust color to be faded
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#55ff55", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#5555ff", bg = "NONE" })

-- vim.diagnostic.open_float()

-- vim.schedule(function()
--     vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#f53c63", bg = "NONE" })
-- end)

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

-- vim.keymap.set("n", "<leader>hi", function()
--     vim.opt.keymap = "hebrew"
--     vim.opt.iminsert = 1
--     vim.opt.rightleft = true
-- end, { desc = "Enable Hebrew input mode" })
--
-- vim.keymap.set("n", "<leader>hn", function()
--     vim.opt.keymap = ""
--     vim.opt.iminsert = 0
--     vim.opt.rightleft = false
-- end, { desc = "Normal mode (LTR)" })

-- Solid Background for snacks.explorer
-- vim.api.nvim_set_hl(0, "SnacksPicker", {
--     bg = "#1e1e1e", -- Replace with your desired hex color
--     -- fg = "#cdd6f4", -- Optional: set foreground color for contrast
-- })

-- Support for Right to Left coding style.
-- e.g In order to type `let var = 4;`, I find it convenient to type the RIGHT hand side first.
-- thus:
-- I type `4;` then `C-h` then `let var = `

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"rust",
		"scala",
		"sh",
		"lua",
		"conf",
		"cfg",
		"dosini",
		"i3config",
		"markdown",
		"python",
		"html",
		"css",
		"asm",
		"typst",
	}, -- add your language here.
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

-- Adding rendering for .rst files in nvim.
vim.api.nvim_create_user_command("RstPreview", function()
	local input = vim.fn.expand("%:p") -- current .rst file
	local output = vim.fn.tempname() .. ".html" -- temp HTML file
	local cmd = string.format("rst2html.py %s %s", input, output)

	local result = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		vim.notify("rst2html failed:\n" .. result, vim.log.levels.ERROR)
	else
		vim.notify("Previewing rendered .rst file...", vim.log.levels.INFO)
		vim.fn.system("xdg-open " .. output) -- open in browser (Linux)
	end
end, {
	desc = "Preview current .rst file in browser",
})

-- Using kk or jj to exit insert mode in addition to Esc.
vim.api.nvim_set_keymap("i", "kk", "<Esc> <leader>w", { noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

-- Exiting terminal mode while in terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.api.nvim_set_keymap("t", "kk", [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap("t", "jj", [[<C-\><C-n>]], { noremap = true })

-- Mapping B and E to ^ and $ respectively
vim.api.nvim_set_keymap("n", "B", "^", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "$", { noremap = true })

-- :w as <leader>w
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Writes to file." })
