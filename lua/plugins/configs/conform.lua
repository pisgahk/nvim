--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- CONFORM

require("conform").setup({
    formatters_by_ft = {
        css = { "prettier" },
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback"},
        html = { "prettier" },
        markdown = { "prettier" },
        python = { "black", "isort" },
        javascript = { "prettier" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    }
})
