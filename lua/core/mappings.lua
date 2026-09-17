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

--Deleting a word at a time.
vim.keymap.set("i", "<C-BS>", "<C-W>", { desc = "Delete word", noremap = true, silent = true })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.diagnostic.config({
    virtual_text = true, -- Enables inline error messages
    signs = true, -- Shows signs in the gutter
    underline = true, -- Underlines errors in the code
})

-- Using kk or jj to exit insert mode in addition to Esc.
vim.keymap.set("i", "kk", "<Esc>:w<CR>", { noremap = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Exiting terminal mode while in terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "kk", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true })

-- Mapping B and E to ^ and $ respectively
vim.keymap.set("n", "B", "^", { noremap = true })
vim.keymap.set("n", "E", "$", { noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

-- Highlights the yanked lines temporarily.
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>re", ":restart<CR>", { noremap = true }) -- Restart neovim.
vim.keymap.set("n", "<leader>so", function()
    vim.cmd("source %")
    print("Ho Gaya Reload!💃")
end, { desc = "Source current config file" }) -- Reload Config.

vim.keymap.set("n", "<leader>E", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline errors" })

---[Snacks.nvim]------------------------------------------------------------------

vim.keymap.set("n", "\\", function()
    Snacks.explorer()
end, { desc = "Explorer" })
vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.grep()
    print("Apna Shabd dhoondhen!")
end, { desc = "Grep" })

-- Printing a random word once the keybind is pressed. [30.07.2026]
-- vim.keymap.set("n", "<leader>fg", function()
--     local messages = { "Shabd khojen!", "Apna Shabd Dhoondhen", "Manchaha Shabd Khojen" }
--     math.randomseed(os.time())
--     local random_msg = messages[math.random(#messages)]
--     Snacks.picker.grep()
--     print(random_msg)
-- end, { desc = "Grep" })

vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.smart()
end, { desc = "Smart Find Files" })

vim.keymap.set("n", "<leader>,", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
end, { desc = "File Explorer" })

vim.keymap.set("n", "<leader>fp", function()
    Snacks.picker.projects()
end, { desc = "Projects" })

vim.keymap.set("n", "<leader>fr", function()
    Snacks.picker.recent()
end, { desc = "Recent" })

vim.keymap.set("n", "<leader>gb", function()
    Snacks.picker.git_branches()
end, { desc = "Git Branches" })

vim.keymap.set("n", "<leader>gl", function()
    Snacks.picker.git_log()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gL", function()
    Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })

vim.keymap.set("n", "<leader>gS", function()
    Snacks.picker.git_status()
end, { desc = "Git Status" })

vim.keymap.set("n", "<leader>gd", function()
    Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

vim.keymap.set("n", "<leader>gf", function()
    Snacks.picker.git_log_file()
end, { desc = "Git Log File" })

vim.keymap.set({ "n", "v" }, "<leader>gB", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse" })

vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Buffer Lines" })

vim.keymap.set("n", "<leader>sr", function()
    Snacks.picker.registers()
end, { desc = "Search Registers" })

vim.keymap.set("n", "<leader>s/", function()
    Snacks.picker.search_history()
end, { desc = "Search History" })

vim.keymap.set("n", "<leader>sa", function()
    Snacks.picker.autocmds()
end, { desc = "Search Autocmds" })

vim.keymap.set("n", "<leader>sc", function()
    Snacks.picker.commands()
end, { desc = "Search Commands" })

vim.keymap.set("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Search Diagnostics" })

vim.keymap.set("n", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Search Buffer Diagnostics" })

vim.keymap.set("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Search Help Pages" })

vim.keymap.set("n", "<leader>sH", function()
    Snacks.picker.highlights()
end, { desc = "Search Highlights" })

vim.keymap.set("n", "<leader>si", function()
    Snacks.picker.icons()
end, { desc = "Search Icons" })

vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Search Keymaps" })

vim.keymap.set("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Search Marks" })

vim.keymap.set("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Search Man Pages" })

vim.keymap.set("n", "<leader>sp", function()
    Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })

vim.keymap.set("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Search Undo History" })

vim.keymap.set("n", "<leader>uC", function()
    Snacks.picker.colorschemes()
end, { desc = "Colorschemes..." })

vim.keymap.set("n", "gd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

vim.keymap.set("n", "gD", function()
    Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

vim.keymap.set("n", "gr", function()
    Snacks.picker.lsp_references()
end, { desc = "Goto References" })

vim.keymap.set("n", "gI", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

vim.keymap.set("n", "gy", function()
    Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })

vim.keymap.set("n", "<leader>z", function()
    Snacks.zen()
end, { desc = "Toggle Zen Mode" })

vim.keymap.set("n", "<leader>.", function()
    Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>S", function()
    Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

vim.keymap.set("n", "<leader>n", function()
    Snacks.notifier.show_history()
end, { desc = "Notification History" })

vim.keymap.set("n", "<leader>un", function()
    Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set({ "n", "t" }, "]]", function()
    Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

vim.keymap.set({ "n", "t" }, "[[", function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
vim.keymap.set("n", "<leader>us", function()
    Snacks.toggle.option("spell", { name = "Spelling" }):toggle()
end, { desc = "Toggle Spelling" })

vim.keymap.set("n", "<leader>uw", function()
    Snacks.toggle.option("wrap", { name = "Wrap" }):toggle()
end, { desc = "Toggle Wrap" })

vim.keymap.set("n", "<leader>uL", function()
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle()
end, { desc = "Toggle Relative Number" })

vim.keymap.set("n", "<leader>ud", function()
    Snacks.toggle.diagnostics():toggle()
end, { desc = "Toggle Diagnostics" })

vim.keymap.set("n", "<leader>ul", function()
    Snacks.toggle.line_number():toggle()
end, { desc = "Toggle Line Number" })

vim.keymap.set("n", "<leader>uc", function()
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):toggle()
end, { desc = "Toggle Conceal Level" })

vim.keymap.set("n", "<leader>uT", function()
    Snacks.toggle.treesitter():toggle()
end, { desc = "Toggle Treesitter" })

vim.keymap.set("n", "<leader>ub", function()
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle()
end, { desc = "Toggle Dark Background" })

vim.keymap.set("n", "<leader>uh", function()
    Snacks.toggle.inlay_hints():toggle()
end, { desc = "Toggle Inlay Hints" })

vim.keymap.set("n", "<leader>ug", function()
    Snacks.toggle.indent():toggle()
end, { desc = "Toggle Indent Guides" })

vim.keymap.set("n", "<leader>uD", function()
    Snacks.toggle.dim():toggle()
end, { desc = "Toggle Dim" })

---[Code Runner]------------------------------------------------------------------

vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rt", ":RunFile tab<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })

---[LSP]--------------------------------------------------------------------------

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, { noremap = true, silent = true })

--─[ Treesitter: textobjects — select ]────────────────────────────────────
vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Select outer function" })

vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Select inner function" })

vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Select outer class" })

vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Select inner class" })

--─[ Treesitter: textobjects — move ]───────────────────────────────────────
vim.keymap.set({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

vim.keymap.set({ "n", "x", "o" }, "]C", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Prev function start" })

vim.keymap.set({ "n", "x", "o" }, "[C", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "Prev class start" })

--─[ Gitsigns ]──────────────────────────────────────────────────────────────

vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        package.loaded.gitsigns.next_hunk()
    end)
    return "<Ignore>"
end, { expr = true, desc = "Next Hunk" })

vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        package.loaded.gitsigns.prev_hunk()
    end)
    return "<Ignore>"
end, { expr = true, desc = "Prev Hunk" })

vim.keymap.set("n", "<leader>hs", function()
    package.loaded.gitsigns.stage_hunk()
end, { desc = "Stage Hunk" })

vim.keymap.set("n", "<leader>hr", function()
    package.loaded.gitsigns.reset_hunk()
end, { desc = "Reset Hunk" })

vim.keymap.set("n", "<leader>hp", function()
    package.loaded.gitsigns.preview_hunk()
end, { desc = "Preview Hunk" })

vim.keymap.set("n", "<leader>hb", function()
    package.loaded.gitsigns.blame_line({ full = true })
end, { desc = "Blame Line" })

vim.keymap.set("n", "<leader>tb", function()
    package.loaded.gitsigns.toggle_current_line_blame()
end, { desc = "Toggle Line Blame" })

vim.keymap.set("n", "<leader>hd", function()
    package.loaded.gitsigns.diffthis()
end, { desc = "Diff This" })

vim.keymap.set("n", "<leader>gs", function()
    package.loaded.gitsigns.toggle_signs()
end, { desc = "Toggle GitSigns" })

--─[ GitGraph ]──────────────────────────────────────────────────────────────

vim.keymap.set("n", "<leader>gx", function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, { desc = "GitGraph - Draw" })

---[fidget.nvim]------------------------------------------------------------

vim.keymap.set("n", "<space>fh", "<cmd>Fidget history<cr>", { desc = "Fidget: show notification history" })
vim.keymap.set("n", "<space>fc", "<cmd>Fidget clear<cr>", { desc = "Fidget: clear current notifications" })
vim.keymap.set("n", "<space>fC", "<cmd>Fidget clear_history<cr>", { desc = "Fidget: clear notification history" })
vim.keymap.set("n", "<space>fs", "<cmd>Fidget suppress<cr>", { desc = "Fidget: toggle notification suppression" })

---[iron.nvim]----------------------------------------------------------------

-- local function iron()
--     return require("iron.core")
-- end
--
-- local function iron_marks()
--     return require("iron.marks")
-- end
--
-- -- REPL lifecycle
-- vim.keymap.set("n", "<space>rr", "<cmd>IronRepl<cr>", { silent = true, desc = "Toggle REPL" })
-- vim.keymap.set("n", "<space>rR", "<cmd>IronRestart<cr>", { silent = true, desc = "Restart REPL" })
-- vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>", { silent = true, desc = "Focus REPL" })
-- vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>", { silent = true, desc = "Hide REPL" })
--
-- -- Sending code
-- vim.keymap.set("n", "<space>sv", function()
--     iron().run_motion("send_motion")
-- end, { silent = true, desc = "Send motion" })
--
-- vim.keymap.set("v", "<space>sv", function()
--     iron().visual_send()
-- end, { silent = true, desc = "Send selection" })
--
-- vim.keymap.set("n", "<space>sf", function()
--     iron().send_file()
-- end, { silent = true, desc = "Send file" })
--
-- vim.keymap.set("n", "<space>sl", function()
--     iron().send_line()
-- end, { silent = true, desc = "Send line" })
--
-- vim.keymap.set("n", "<space>sp", function()
--     iron().send_paragraph()
-- end, { silent = true, desc = "Send paragraph" })
--
-- vim.keymap.set("n", "<space>sn", function()
--     iron().send_code_block(true)
-- end, { silent = true, desc = "Send code block and move" })
--
-- vim.keymap.set("n", "<space>sc", function()
--     iron().send_until_cursor()
-- end, { silent = true, desc = "Send until cursor" })
--
-- vim.keymap.set("n", "<space>sm", function()
--     iron().send_mark()
-- end, { silent = true, desc = "Send marked code" })
--
-- vim.keymap.set("n", "<space>sb", function()
--     iron().send_code_block(false)
-- end, { silent = true, desc = "Send code block" })
--
-- -- Marks
-- vim.keymap.set("n", "<space>mc", function()
--     iron().run_motion("mark_motion")
-- end, { silent = true, desc = "Mark motion" })
--
-- vim.keymap.set("v", "<space>mc", function()
--     iron().mark_visual()
-- end, { silent = true, desc = "Mark selection" })
--
-- vim.keymap.set("n", "<space>md", function()
--     iron_marks().drop_last()
-- end, { silent = true, desc = "Remove last mark" })
--
-- -- Special REPL input
-- vim.keymap.set("n", "<space>s<cr>", function()
--     iron().send(nil, string.char(13))
-- end, { silent = true, desc = "Send Enter" })
--
-- vim.keymap.set("n", "<space>s<space>", function()
--     iron().send(nil, string.char(3))
-- end, { silent = true, desc = "Interrupt REPL" })
--
-- vim.keymap.set("n", "<space>sq", function()
--     iron().close_repl()
-- end, { silent = true, desc = "Exit REPL" })
--
-- vim.keymap.set("n", "<space>cl", function()
--     iron().send(nil, string.char(12))
-- end, { silent = true, desc = "Clear REPL" })
