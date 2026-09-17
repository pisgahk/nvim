---[Code Runner]---------------------------------------------------
require("code_runner").setup({
    mode = "float",
    focus = true,
    startinsert = false,
    float = {
        -- Window border (see ':h nvim_open_win')
        border = "rounded", -- options: 'none', 'single', 'double', 'rounded'

        -- Num from `0 - 1` for measurements
        height = 0.25, -- relative height (e.g. 0.4 = 40% of screen height)
        width = 0.7,
        x = 0.5,
        y = 0.9,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        blend = 0, -- Transparency (see ':h winblend')
    },
    filetype = {
        python = "uv run python3", -- Will work when the python project uses `uv`.
        javascript = "node",
        rust = "cargo run",
        go = "go run",
        lua = "lua",
        sh = "bash",
        c = "gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        cpp = "g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
    },
})

---[Live Preview]-------------------------------------------------

require("live-preview").setup({
    port = 5500,
    browser = "default",
    dynamic_root = false,
    sync_scroll = true,
    picker = "",
    address = "127.0.0.1",
})

---[Typst Preview]------------------------------------------------

require("typst-preview").setup({
    follow_cursor = true,
    host = "127.0.0.1",
    port = 0,
    partial_rendering = true,
    invert_colors = "never", -- "always", "auto". Depends on the dark mode feature of the browser.
})

---[Nvim Autopairs]------------------------------------------------

require("nvim-autopairs").setup({
    event = "InsertEnter",
})

---[fidget.nvim]---------------------------------------------------

-- lua/plugins/fidget.lua
-- LSP progress + notification UI, native vim.pack (Neovim 0.12+)

-- vim.pack.add({
--     { src = "https://github.com/j-hui/fidget.nvim" },
-- })

require("fidget").setup({
    progress = {
        poll_rate = 0,
        suppress_on_insert = true, -- don't spam progress while you're typing
        ignore_done_already = false,
        ignore_empty_message = true,

        display = {
            render_limit = 8,
            done_ttl = 3,
            progress_ttl = math.huge,
            progress_icon = { "dots" },
            done_icon = "✔",
            done_style = "Constant",
            progress_style = "WarningMsg",
            group_style = "Title",
            icon_style = "Question",
            overrides = {
                rust_analyzer = { name = "rust-analyzer" },
                lua_ls = { name = "lua_ls" },
                basedpyright = { name = "basedpyright" },
            },
        },

        lsp = {
            progress_ringbuf_size = 0,
        },
    },

    notification = {
        poll_rate = 10,
        filter = vim.log.levels.INFO,
        history_size = 128,
        override_vim_notify = true, -- fidget becomes your vim.notify() backend

        view = {
            stack_upwards = true,
            icon_separator = " ",
            group_separator = "---",
            group_separator_hl = "Comment",
        },

        window = {
            winblend = 0,
            border = "rounded",
            relative = "editor",
            align = "bottom",
            h_align = "right",
            x_padding = 1,
            y_padding = 0,
            max_width = 0,
            max_height = 0,
        },
    },

    logger = {
        enable = false, -- flip to true if you need to debug fidget itself
        level = vim.log.levels.WARN,
    },
})
