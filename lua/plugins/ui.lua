--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝UI.

---[Lualine]-------------------------------------------------------------------------
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "horizon",
        globalstatus = true,
        component_separators = "::",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_x = {
            -- "encoding", -- utf-8
            "fileformat",
            "filetype",
        },
        lualine_y = {
            -- buffer number just before encoding column
            {
                function()
                    return "[" .. vim.fn.bufnr("%") .. "]"
                end,
                color = { gui = "bold" },
            },
            "progress",
        },
        lualine_z = { "location" },
    },
})

---[Which-key]-----------------------------------------------------------------------
require("which-key").setup({
    preset = "helix",
    layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            icons = {
                breadcrumb = "::",
                separator = "➺",
                group = "🖿 ",
            },

})

---[Notify]--------------------------------------------------------------------------
require("notify").setup({
    -- Appearance
    stages = "fade_in_slide_out", -- other options: static, fade, slide
    background_colour = "#ff5555",
    border = "rounded",
    timeout = 1000, -- default duration in ms
    fps = 30,
    minimum_width = 30,
    render = "compact", --"default", "compact" | "minimal" also look good
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

---[Spinner]------------------------------------------------------------------------

-- require("spinner").setup({
--   -- Pre-defined pattern key name in
--   -- https://github.com/xieyonn/spinner.nvim/blob/main/lua/spinner/pattern.lua
--   -- or be a table { intervals = 80, frames = { "1", "2" } }
--   pattern = "dots",
--
--   -- Time-to-live in milliseconds since the most recent start, after which the
--   -- spinner stops, preventing it from running indefinitely.
--   ttl_ms = 0,
--
--   -- Milliseconds to wait after startup before showing the spinner.
--   -- This helps prevent the spinner from briefly flashing for short-lived tasks.
--   initial_delay_ms = 0,
--
--   -- Text displayed when the spinner is idle/stoped.
--   --
--   -- true: show an empty string, with length equal to spinner frames.
--   -- false: equals to "".
--   -- or string value, eg: show ✔ when lsp progress finished.
--   -- or a table value, eg: { init = "", stopped = "", failed = "" }
--   placeholder = false,
--
--   -- Highlight group for text, use fg of `Comment` by default.
--   -- or be a table { init = "", running = "", paused = "", stopped = "", failed = ""}
--   hl_group = "Spinner",
--
--   cursor_spinner = {
--     -- CursorSpinner window option.
--     winblend = 60,
--
--     -- CursorSpinner window option.
--     zindex = 50,
--
--     -- CursorSpinner window position, relative to cursor.
--     -- row = -1 col = 1 means Above-Right.
--     row = -1,
--     col = 1,
--   }
-- })
