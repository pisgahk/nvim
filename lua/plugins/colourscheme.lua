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
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup({
                options = {
                    transparent = true,
                    dim_inactive = false,
                    terminal_colors = false,
                    styles = {
                        comments = "italic",
                        --variables = "bold",
                    },
                },
            })

            vim.cmd("colorscheme github_dark")
        end,
    },

    --Colourschemes
    "catppuccin/nvim",
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
                italics = true,                   -- Enable italics for better aesthetics
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
                    -- solana = { colorscheme = "everforest" },
                    help = { colorscheme = "catppuccin-mocha", background = "dark" },
                },
            })
        end,
    },
}
