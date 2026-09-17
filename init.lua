--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Pisgah

-- Leader Key
vim.g.mapleader = ","

require("core.settings")
require("core.mappings")

vim.pack.add({
    -- UI
    -- "https://github.com/pisgahk/muted.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/xieyonn/spinner.nvim",
    -- Snacks.
    "https://github.com/folke/snacks.nvim",
    -- LSP, Completion [Language Features / Development Layer]
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    -- {
    -- 	src = "https://github.com/saghen/blink.cmp",
    -- 	-- build = "cargo build --release",
    -- 	version = vim.version.range("1.*"),
    -- },
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/isakbm/gitgraph.nvim",
    -- Tools.
    "https://github.com/CRAG666/code_runner.nvim",
    "https://github.com/brianhuster/live-preview.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/Vigemus/iron.nvim",
    "https://github.com/j-hui/fidget.nvim",
    -- Misc
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/nvim-tree/nvim-web-devicons",
    -- Colorschemes
    "https://github.com/amedoeyes/eyes.nvim",
    "https://github.com/RedsXDD/neopywal.nvim",
})

require("plugins.ui")
require("plugins.snacks")
require("plugins.completion")
require("plugins.lsp")
require("plugins.tools")
require("plugins.git")
require("plugins.treesitter")
require("plugins.iron")

vim.opt.runtimepath:prepend(vim.fn.expand("~/muted.nvim"))
vim.cmd.colorscheme("muted_earth")

-- Removing the bg_color from the inlay Hints.
vim.api.nvim_set_hl(0, "LspInlayHint", {
    fg = "#555555",
    bg = "none",
})

-- Suppress the default write message and replace with human-readable size
--
-- This avoids the:
-- "~/dev/tests/test.rs" 68L, 1895B written
--
-- to:
-- "~/dev/tests/test.rs" 68L, 1.9 KB written

-- And for anything larger it'll show 0.48 MB, 2.31 MB, etc.
-- The KB fallback is there because most of your files will never actually hit MB(depends on your kinda work) — it's more honest than forcing everything into MB (a 400B file showing 0.00 MB would be useless).

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        local path = vim.fn.expand("%:p")
        local size = vim.fn.getfsize(path)
        local formatted

        if size < 0 then
            formatted = "unknown size"
        elseif size < 1024 * 1024 then
            formatted = string.format("%.2f KB", size / 1024)
        elseif size < 1024 * 1024 * 1024 then
            formatted = string.format("%.2f MB", size / (1024 * 1024))
        else
            formatted = string.format("%.2f GB", size / (1024 * 1024 * 1024))
        end

        local lines = vim.fn.line("$")
        local rel = vim.fn.expand("%:~")

        vim.defer_fn(function()
            vim.api.nvim_echo({ { string.format('"%s"  %dL  %s written', rel, lines, formatted), "Normal" } }, false, {})
        end, 1)
    end,
})

-- This is to make the bg color of nvim disappear and use the bg of the terminal.
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#444444", bg = "none" })
-- vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
--
--Changing the color of the file explorer
vim.api.nvim_set_hl(0, "SnacksPickerList", { bg = "#1e1e2e" })
-- vim.api.nvim_set_hl(0, "SnacksPickerListBorder", { bg = "#1e1e2e", fg = "#585b70" })
-- vim.api.nvim_set_hl(0, "SnacksPickerInput", { bg = "#1e1e2e" })
-- vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { bg = "#1e1e2e", fg = "#585b70" })
