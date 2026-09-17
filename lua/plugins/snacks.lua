require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        width = 60,
        sections = {
            {
                text = [[
██████╗ ██╗███████╗ ██████╗  █████╗ ██╗  ██╗   ██████╗ ███████╗██╗   ██╗
██╔══██╗██║██╔════╝██╔════╝ ██╔══██╗██║  ██║   ██╔══██╗██╔════╝██║   ██║
██████╔╝██║███████╗██║  ███╗███████║███████║   ██║  ██║█████╗  ██║   ██║
██╔═══╝ ██║╚════██║██║   ██║██╔══██║██╔══██║   ██║  ██║██╔══╝  ╚██╗ ██╔╝
█║     ██║███████║╚██████╔╝██║  ██║██║  ██║██╗██████╔╝███████╗ ╚████╔╝
╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝  ╚═══╝
=========================[Better Your Best🌹]=========================
Build so much volume that there would be no option than to be successful.
                                

            We do it even for those we never meet.
           (It is what makes us human, you know🤗)
   😀😁😇😚🤪🤑🤗🤭🫣🤫🤔🫡🤐🤨😶‍🌫️🫥😏😮‍💨🫨😴😪🤒🤮🥵🤯🥸😎🥹😭😤🥱😡😂🥰

     Ain't nobody else that can do what you do the way you do.

        Good code is not written, it is "re-written"!

        ]],
            },
        },
    },
    explorer = { enabled = true, trash = true },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
        enabled = true,
        sources = {
            explorer = {
                layout = { layout = { position = "right", width = 30, height = 0.9, border = "rounded" } },
                hidden = true,
                ignored = true,
                auto_close = false,
            },
        },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    image = {
        enabled = true,
        relative = "cursor",
        border = "rounded",
        focusable = false, -- was the string "false" in your original, fixed to boolean
        backdrop = false, -- same fix
        doc = { enabled = true, inline = false, float = true, max_width = 80, max_height = 40 },
        convert = {
            notify = true,
            magick = "magick",
            mermaid = "mmdc",
            formats = {
                "png",
                "jpg",
                "jpeg",
                "gif",
                "bmp",
                "webp",
                "tiff",
                "heic",
                "avif",
                "mp4",
                "mov",
                "avi",
                "mkv",
                "webm",
                "pdf",
                "ico",
                "svg",
                "psd",
                "dds",
                "jp2",
                "jxl",
                "icns",
            },
        },
        math = { enabled = true },
        force = false,
    },
    styles = {
        notification = { relative = "editor" },
        snacks_image = { relative = "editor", col = -1 },
    },
})

-- keymaps: { lhs, rhs, desc, mode?, nowait? }
-- local keys = {
--     { "<leader><space>", function() Snacks.picker.smart() end, "Smart Find Files" },
--     { "<leader>,", function() Snacks.picker.buffers() end, "Buffers" },
--     { "<leader>:", function() Snacks.picker.command_history() end, "Command History" },
--     { "<leader>e", function() Snacks.explorer() end, "File Explorer" },
--     { "<leader>fp", function() Snacks.picker.projects() end, "Projects" },
--     { "<leader>fr", function() Snacks.picker.recent() end, "Recent" },
--     { "<leader>gb", function() Snacks.picker.git_branches() end, "Git Branches" },
--     { "<leader>gl", function() Snacks.picker.git_log() end, "Git Log" },
--     { "<leader>gL", function() Snacks.picker.git_log_line() end, "Git Log Line" },
--     { "<leader>gS", function() Snacks.picker.git_status() end, "Git Status" },
--     { "<leader>gd", function() Snacks.picker.git_diff() end, "Git Diff (Hunks)" },
--     { "<leader>gf", function() Snacks.picker.git_log_file() end, "Git Log File" },
--     { "<leader>gB", function() Snacks.gitbrowse() end, "Git Browse", { "n", "v" } },
--     { "<leader>gg", function() Snacks.lazygit() end, "Lazygit" },
--     { "<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines" },
--     { "<leader>sr", function() Snacks.picker.registers() end, "Search Registers" },
--     { "<leader>s/", function() Snacks.picker.search_history() end, "Search History" },
--     { "<leader>sa", function() Snacks.picker.autocmds() end, "Search Autocmds" },
--     { "<leader>sc", function() Snacks.picker.commands() end, "Search Commands" },
--     { "<leader>sd", function() Snacks.picker.diagnostics() end, "Search Diagnostics" },
--     { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Search Buffer Diagnostics" },
--     { "<leader>sh", function() Snacks.picker.help() end, "Search Help Pages" },
--     { "<leader>sH", function() Snacks.picker.highlights() end, "Search Highlights" },
--     { "<leader>si", function() Snacks.picker.icons() end, "Search Icons" },
--     { "<leader>sk", function() Snacks.picker.keymaps() end, "Search Keymaps" },
--     { "<leader>sm", function() Snacks.picker.marks() end, "Search Marks" },
--     { "<leader>sM", function() Snacks.picker.man() end, "Search Man Pages" },
--     { "<leader>sp", function() Snacks.picker.lazy() end, "Search for Plugin Spec" },
--     { "<leader>su", function() Snacks.picker.undo() end, "Search Undo History" },
--     { "<leader>uC", function() Snacks.picker.colorschemes() end, "Colorschemes..." },
--     { "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition" },
--     { "gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration" },
--     { "gr", function() Snacks.picker.lsp_references() end, "Goto References", "n", true },
--     { "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation" },
--     { "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition" },
--     { "<leader>z", function() Snacks.zen() end, "Toggle Zen Mode" },
--     { "<leader>.", function() Snacks.scratch() end, "Toggle Scratch Buffer" },
--     { "<leader>S", function() Snacks.scratch.select() end, "Select Scratch Buffer" },
--     { "<leader>n", function() Snacks.notifier.show_history() end, "Notification History" },
--     { "<leader>un", function() Snacks.notifier.hide() end, "Dismiss All Notifications" },
--     { "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference", { "n", "t" } },
--     { "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference", { "n", "t" } },
-- }
--
-- for _, k in ipairs(keys) do
--     vim.keymap.set(k[4] or "n", k[1], k[2], { desc = k[3], nowait = k[5] })
-- end

-- debug helpers + toggle keymaps (no VeryLazy event needed — vim.pack loads eagerly)
-- _G.dd = function(...) Snacks.debug.inspect(...) end
-- _G.bt = function() Snacks.debug.backtrace() end
-- vim.print = _G.dd
