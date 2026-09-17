---[luasnip]----------------------------------------------------------------------

require("luasnip").setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.fn.stdpath("config") .. "/lua/snippets", -- your snippets are from here
})

---[blink.cmp]-------------------------------------------------------------------

local cmp = require("blink.cmp")
cmp.build():pwait() -- builds/downloads the native fuzzy-matching library, blocking until done

cmp.setup({
    keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
    },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
            auto_show = true,
            window = { border = "rounded" },
        },
        menu = { border = "rounded" },
        ghost_text = { enabled = false },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    cmdline = { enabled = true },
})

---Formatter----
---[conform.nvim]----------------------------------------------------------------

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" }, -- or { "ruff_format" } — see note below
        rust = { "rustfmt" },
        qml = { "qmlformat" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        go = { "goimports" },
        dart = { "dart_format" },
        sql = { "sqlfluff" },
        typst = { "typstyle" },
    },
    formatters = {
        stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "4", "--column-width", "150" },
        },
        rustfmt = {
            prepend_args = { "--config", "tab_spaces=4", "--config", "max_width=120" },
        },
        ruff_format = {
            prepend_args = { "--line-length", "120" },
        },
        qmlformat = {
            prepend_args = { "--indent-width", "4", "--column-width", "130" },
        },
        sqlfluff = {
            prepend_args = { "--dialect", "postgres" },
        },
        typstyle = {
            prepend_args = { "--tab-width", "4" },
        },
        black = {
            -- black doesn't take a --style flag like yapf did (pep8 is its only style,
            -- always 4-space indent, non-configurable), so nothing needed here
        },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback", -- use LSP formatting only if no conform formatter matches
    },
})
