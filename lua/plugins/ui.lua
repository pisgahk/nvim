--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝UI.

-- cooked by Pisgah.
-- Notify, Noice, Lualine.

return {
    {
        "rcarriga/nvim-notify",
        lazy = false,
        priority = 1000,
        config = function()
            vim.notify = require("notify")

            require("notify").setup({
                -- Appearance
                stages = "fade_in_slide_out", -- other options: static, fade, slide
                background_colour = "#000000",
                timeout = 3000,   -- default duration in ms
                fps = 60,
                minimum_width = 30,
                render = "default", -- "compact" | "minimal" also look good
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎",
                },

                -- Behavior
                top_down = true, -- display new notifications on top
                max_width = function()
                    return math.floor(vim.o.columns * 0.35)
                end,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
            })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.opt.cmdheight = 1
            vim.opt.laststatus = 2

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "horizon",
                    globalstatus = false,
                    component_separators = " ",
                    section_separators = { left = "", right = "" },
                },
            })
        end,
    },
}
