--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Colourschemes.

-- cooked by P!5g@h.
-- Includes Colour-schemes.

return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {     -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true, -- disables setting the background color.
                float = {
                    transparent = true,        -- enable transparent floating windows
                    solid = false,             -- use solid styling for floating windows, see |winborder|
                },
                show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
                term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
                styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                    -- comments = { "italic" },   -- Change the style of comments
                    -- conditionals = { "italic" },
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                -- custom_highlights = {},
                custom_highlights = {
                    FloatBorder = { fg = "#fd004a" },     -- #ff5555 #f53c63 #fd004a (Beautiful colours🤤) #ff004a
                    TelescopeBorder = { fg = "#ff5555" }, -- if using Telescope
                    WhichKeyBorder = { fg = "#fd004a" },  -- if using WhichKey

                    --🧱 Core UI
                    -- Normal = { fg = "#ff5555" },
                    -- LineNr = { fg = "#ff5555" },
                    -- CursorLineNr = { fg = "#ff5555", bold = true },
                    VertSplit = { fg = "#fdbcb4" },
                    -- WinSeparator = { fg = "#fdbcb4" },
                    -- NormalFloat = { fg = "#50fa7b", bg = "#1a1a1a" },
                    -- Pmenu = { fg = "#ff5555", bg = "#1a1a1a" },
                    -- PmenuSel = { fg = "#1a1a1a", bg = "#ff5555" },
                    -- StatusLine = { fg = "#ff5555", bg = "#1a1a1a" },
                    -- TabLineSel = { fg = "#ff5555", bold = true },

                    -- 🔔 Diagnostics
                    DiagnosticError = { fg = "#fe6f5e" }, -- #ff2c2c, #b22222, #dc143c, #8b0000 #f08080 #ff6961, #ff6961, #ff6961. #fe6f5e. #fdbcb4
                    DiagnosticWarn = { fg = "#ffaa00" },
                    DiagnosticInfo = { fg = "#5555ff" },
                    DiagnosticHint = { fg = "#55ff55" },
                    DiagnosticUnderlineError = { sp = "#ff2c2c", underline = true },
                    -- DiagnosticVirtualTextError = { fg = "#fdbcb4", bg = "#1e1e2e" },
                    -- DiagnosticUnderlineError = { sp = "#ff6f6f", undercurl = true },
                },

                default_integrations = true,
                auto_integrations = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                },
            })

            -- setup must be called before loading
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup({
                options = {
                    transparent = true,
                    dim_inactive = false,
                    terminal_colors = false,
                    styles = {
                        -- comments = "italic",
                        --variables = "bold",
                    },
                },
            })

            -- vim.cmd("colorscheme github_dark")
        end,
    },

    --Colourschemes

    "UtkarshVerma/molokai.nvim",
    "akinsho/horizon.nvim",
    "briones-gabriel/darcula-solid.nvim",
    "rebelot/kanagawa.nvim",
    "shaunsingh/nord.nvim",
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    transparency = true,
                },
            })
        end,
    },

    {
        "Mofiqul/vscode.nvim",
        config = function()
            require("vscode").setup({
                transparent = true,
            })
        end,
    },
    "ntk148v/habamax.nvim",
    {
        "neanias/everforest-nvim",
        config = function()
            require("everforest").setup({
                background = "medium",            -- Options: "soft", "medium", "hard"
                transparent_background_level = 2, -- 0 (no transparency), 1 (some transparency), 2 (full transparency)
                italics = true,                  -- Enable italics for better aesthetics
            })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
                undercurl = true,
                underline = true,
            })
        end,
    },

    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                    terminal_colors = true,
                    dim_inactive = false,
                },
            })
        end,
    },

    { -- to check the filetypes, use `:echo &filetype`

        "folke/styler.nvim",
        config = function()
            require("styler").setup({
                themes = {
                    rust = { colorscheme = "github_dark" },
                    python = { colorscheme = "everforest" },
                    html = { colorscheme = "vscode" },
                    sh = { colorscheme = "gruvbox" },
                    lua = { colorscheme = "github_dark_dimmed" },
                    markdown = { colorscheme = "catppuccin-frappe" },
                    asm = { colorscheme = "rose-pine" },
                    javascript = { colorscheme = "nightfox" },
                    -- leetcode.nvim = { colorscheme = "nightfox" },
                    -- solana = { colorscheme = "everforest" },
                    help = { colorscheme = "catppuccin-mocha", background = "dark" },
                },
            })
        end,
    },
}
