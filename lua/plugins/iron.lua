-- lua/plugins/iron.lua
-- REPL integration via iron.nvim, native vim.pack (Neovim 0.12+)
-- Single self-contained file: install + config + keymaps

-- vim.pack.add({
-- 	{ src = "https://github.com/Vigemus/iron.nvim" },
-- })

require("iron").setup({
    config = {
        scratch_repl = false,

        repl_definition = {
            sh = {
                command = { "sh" },
                format = function(lines)
                    local filtered = vim.tbl_filter(function(line)
                        return not line:match("^%s*#")
                    end, lines)
                    return require("iron.fts.common").bracketed_paste(filtered)
                end,
            },
            python = {
                command = { "ipython", "--no-autoindent" },
                format = function(lines, extras)
                    local filtered = vim.tbl_filter(function(line)
                        return not line:match("^%s*#")
                    end, lines)
                    return require("iron.fts.common").bracketed_paste_python(filtered, extras)
                end,
                block_dividers = { "# %%", "#%%", "###", "# ---[" },
            },
            lua = {
                command = { "lua" },
                format = function(lines)
                    local filtered = vim.tbl_filter(function(line)
                        return not line:match("^%s*%-%-")
                    end, lines)
                    return require("iron.fts.common").bracketed_paste(filtered)
                end,
            },
            rust = {
                command = { "evcxr" },
                format = function(lines)
                    local filtered = vim.tbl_filter(function(line)
                        return not line:match("^%s*//")
                    end, lines)
                    return require("iron.fts.common").bracketed_paste(filtered)
                end,
            },
        },

        repl_filetype = function(_, ft)
            return ft
        end,

        repl_open_cmd = require("iron.view").split.vertical.rightbelow(80),
    },

    keymaps = {
        toggle_repl = "<space>rr",
        restart_repl = "<space>rR",

        send_motion = "<space>sv",
        visual_send = "<space>sv",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_code_block_and_move = "<space>sn",
        send_until_cursor = "<space>sc",
        send_mark = "<space>sm",
        send_code_block = "<space>sb",

        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",

        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },

    highlight = { italic = false, bold = true },
    ignore_blank_lines = true,
})

vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")

local function run_current_file()
    local file = vim.api.nvim_buf_get_name(0)
    local filetype = vim.bo.filetype
    local root = vim.fs.root(0, { "Cargo.toml", "pyproject.toml", "uv.lock", ".git" })

    if file == "" or not root then
        vim.notify("Cannot determine the current project or file", vim.log.levels.ERROR)
        return
    end

    local command

    if filetype == "rust" then
        local relative = vim.fs.relpath(root, file)

        if relative == "src/main.rs" then
            command = { "cargo", "run" }
        else
            local binary = relative:match("^src/bin/(.+)%.rs$")

            if not binary then
                vim.notify("Rust file is not src/main.rs or src/bin/<binary>.rs", vim.log.levels.WARN)
                return
            end

            command = { "cargo", "run", "--bin", binary }
        end
    elseif filetype == "python" then
        if vim.uv.fs_stat(root .. "/pyproject.toml") or vim.uv.fs_stat(root .. "/uv.lock") then
            command = { "uv", "run", "python", file }
        else
            command = { "python3", file }
        end
    else
        vim.notify("Current file is not Rust or Python", vim.log.levels.WARN)
        return
    end

    vim.cmd("botright new")
    local buffer = vim.api.nvim_get_current_buf()
    vim.bo[buffer].bufhidden = "wipe"
    vim.fn.termopen(command, { cwd = root })
    vim.cmd("startinsert")
    vim.api.nvim_buf_set_name(buffer, "Runner: " .. vim.fn.fnamemodify(file, ":t"))
end

vim.keymap.set("n", "<space>rb", run_current_file, {
    silent = true,
    desc = "Run current Rust or Python file",
})
