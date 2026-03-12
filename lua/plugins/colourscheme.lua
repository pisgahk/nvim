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
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true, -- disables setting the background color.
                float = {
                    transparent = false, -- enable transparent floating windows
                    solid = false, -- use solid styling for floating windows, see |winborder|
                },
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
                styles = {         -- Handles the styles of general hi groups (see `:h highlight-args`):
                    -- comments = { "italic" },   -- Change the style of comments
                    -- conditionals = { "italic" },
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                -- custom_highlights = {},
                custom_highlights = {
                    FloatBorder = { fg = "#fd004a" }, -- #ff5555 #f53c63 #fd004a (Beautiful colours🤤) #ff004a
                    TelescopeBorder = { fg = "#ff5555" }, -- if using Telescope
                    WhichKeyBorder = { fg = "#fd004a" }, -- if using WhichKey

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
                    --
                    -- Core UI
                    -- Normal = { fg = "#E6DADA", bg = "#1A0B0B" }, -- off-white on dark red-black
                    Normal = { fg = "#E6DADA" },
                    LineNr = { fg = "#664C4C" },
                    CursorLineNr = { fg = "#FF6666", bold = true },
                    StatusLine = { fg = "#E6DADA", bg = "#330F0F" },
                    TabLineSel = { fg = "#FF4C4C", bold = true },
                    Visual = { bg = "#4C1F1F" },

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

    -- This is my attempt to make a fully red colourscheme.
    -- {
    -- 	"catppuccin/nvim",
    -- 	lazy = false,
    -- 	priority = 1000,
    --
    -- 	config = function()
    -- 		require("catppuccin").setup({
    -- 			flavour = "mocha",
    -- 			background = {
    -- 				light = "latte",
    -- 				dark = "mocha",
    -- 			},
    -- 			transparent_background = true,
    -- 			float = {
    -- 				transparent = false,
    -- 				solid = false,
    -- 			},
    -- 			show_end_of_buffer = false,
    -- 			term_colors = true,
    -- 			styles = {},
    -- 			color_overrides = {},
    -- 			custom_highlights = {
    -- 				-- Borders
    -- 				FloatBorder = { fg = "#CC3333" }, -- deep red
    -- 				TelescopeBorder = { fg = "#FF4C4C" }, -- bright crimson
    -- 				WhichKeyBorder = { fg = "#FF1A1A" }, -- vivid scarlet
    -- 				VertSplit = { fg = "#664C4C" }, -- dim red-grey
    --
    -- 				-- Core UI
    -- 				Normal = { fg = "#E6DADA", bg = "#1A0B0B" }, -- off-white on dark red-black
    -- 				LineNr = { fg = "#664C4C" },
    -- 				CursorLineNr = { fg = "#FF6666", bold = true },
    -- 				StatusLine = { fg = "#E6DADA", bg = "#330F0F" },
    -- 				TabLineSel = { fg = "#FF4C4C", bold = true },
    -- 				Visual = { bg = "#4C1F1F" },
    --
    -- 				-- Syntax overrides
    -- 				Comment = { fg = "#A68A8A", italic = true },
    -- 				Keyword = { fg = "#FF4C4C", bold = true },
    -- 				Type = { fg = "#CC3333" },
    -- 				Function = { fg = "#FF6666" },
    -- 				Macro = { fg = "#FF1A1A" },
    -- 				String = { fg = "#FF9999" },
    -- 				Number = { fg = "#FF8080" },
    -- 				Boolean = { fg = "#CC4444" },
    --
    -- 				-- Diagnostics
    -- 				DiagnosticError = { fg = "#FF0000" },
    -- 				DiagnosticWarn = { fg = "#FF5E5E" },
    -- 				DiagnosticInfo = { fg = "#B3A6A6" },
    -- 				DiagnosticHint = { fg = "#A68A8A" },
    -- 				DiagnosticUnderlineError = { sp = "#FF0000", undercurl = true },
    -- 				DiagnosticUnderlineWarn = { sp = "#FF5E5E", undercurl = true },
    -- 				DiagnosticUnderlineInfo = { sp = "#B3A6A6", undercurl = true },
    -- 				DiagnosticUnderlineHint = { sp = "#A68A8A", undercurl = true },
    -- 			},
    --
    -- 			default_integrations = true,
    -- 			auto_integrations = false,
    -- 			integrations = {
    -- 				cmp = true,
    -- 				gitsigns = true,
    -- 				nvimtree = true,
    -- 				treesitter = true,
    -- 				notify = false,
    -- 				mini = {
    -- 					enabled = true,
    -- 					indentscope_color = "",
    -- 				},
    -- 			},
    -- 		})
    --
    -- 		-- setup must be called before loading
    -- 		vim.cmd.colorscheme("catppuccin")
    -- 	end,
    -- },

    -- Place this file at:
    --   ~/.config/nvim/lua/plugins/github_washed.lua
    -- (or wherever your lazy.nvim plugin specs live)
    --
    -- Palette philosophy:
    --   Every hue has been desaturated ~45% and the luminance range compressed
    --   so darks lift slightly and lights dim slightly.
    --   The result is a calm, fog-over-slate feel that reads cleanly in low light
    --   without any colour ever shouting at you.

    -- {
    --     "projekt0n/github-nvim-theme",
    --     name = "github-theme",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("github-theme").setup({
    --
    --             -- ── palette overrides ────────────────────────────────────────────
    --             -- These replace the raw colour tokens for the github_dark variant.
    --             -- Saturation has been pulled back and contrast compressed throughout.
    --             palettes = {
    --                 github_dark = {
    --                     -- canvas / backgrounds
    --                     canvas = {
    --                         default = "#161b24", -- was #0d1117  (lifted, less pure black)
    --                         overlay = "#1e2430", -- was #161b22
    --                         inset = "#191f29",
    --                         subtle = "#1e2430",
    --                     },
    --
    --                     -- foregrounds
    --                     fg = {
    --                         default = "#b0bac4", -- was #e6edf3  (dimmed, grey-shifted)
    --                         muted = "#6e7d8a", -- was #8b949e
    --                         subtle = "#4e5a66", -- was #30363d
    --                         on_emphasis = "#c8d2db",
    --                     },
    --
    --                     -- border tones
    --                     border = {
    --                         default = "#2e3844",
    --                         muted = "#232b36",
    --                         subtle = "#1e2430",
    --                     },
    --
    --                     -- neutrals / scales
    --                     neutral = {
    --                         emphasis_plus = "#5a6875",
    --                         emphasis = "#3d4a57",
    --                         muted = "#252f3b",
    --                         subtle = "#1e2430",
    --                     },
    --
    --                     -- accent colours – desaturated ~45%
    --                     -- red  (was #ff7b72 → muted coral)
    --                     red = {
    --                         emphasis = "#9e5f5c",
    --                         muted = "#3d2424",
    --                         subtle = "#2a1b1b",
    --                         fg = "#b8847f", -- keywords, errors
    --                     },
    --
    --                     -- orange (was #ffa657 → dusty amber)
    --                     orange = {
    --                         emphasis = "#9e7a47",
    --                         muted = "#3a2c1a",
    --                         subtle = "#271f13",
    --                         fg = "#b89566", -- constants, numbers
    --                     },
    --
    --                     -- yellow (was #e3b341 → pale wheat)
    --                     yellow = {
    --                         emphasis = "#9e8040",
    --                         muted = "#382e18",
    --                         subtle = "#252011",
    --                         fg = "#b8a05e",
    --                     },
    --
    --                     -- green  (was #7ee787 → sage)
    --                     green = {
    --                         emphasis = "#4e8a56",
    --                         muted = "#1e3023",
    --                         subtle = "#16221a",
    --                         fg = "#7aaa82", -- strings
    --                     },
    --
    --                     -- teal   (was #2ea043 → muted teal)
    --                     teal = {
    --                         emphasis = "#3d7a72",
    --                         muted = "#182e2a",
    --                         subtle = "#12201e",
    --                         fg = "#5e9e96",
    --                     },
    --
    --                     -- blue   (was #79c0ff → slate blue)
    --                     blue = {
    --                         emphasis = "#3d6e9e",
    --                         muted = "#182538",
    --                         subtle = "#121b28",
    --                         fg = "#7098b8", -- functions, types
    --                     },
    --
    --                     -- purple (was #d2a8ff → dusty lavender)
    --                     purple = {
    --                         emphasis = "#7a5e9e",
    --                         muted = "#28203a",
    --                         subtle = "#1c1728",
    --                         fg = "#9e84b8", -- builtins
    --                     },
    --
    --                     -- pink   (was #f778ba → muted rose)
    --                     pink = {
    --                         emphasis = "#9e4e72",
    --                         muted = "#38192a",
    --                         subtle = "#281320",
    --                         fg = "#b86e8e",
    --                     },
    --
    --                     -- coral  (was #ff7b72 alias used for some tokens)
    --                     coral = {
    --                         emphasis = "#9e5f5c",
    --                         muted = "#3d2424",
    --                         subtle = "#2a1b1b",
    --                         fg = "#b8847f",
    --                     },
    --                 },
    --             },
    --
    --             -- ── spec overrides ───────────────────────────────────────────────
    --             -- Fine-tune specific highlight roles on top of the palette above.
    --             specs = {
    --                 github_dark = {
    --                     syntax = {
    --                         comment = "#556070", -- readable but clearly recessive
    --                         constant = "#b89566", -- dusty amber
    --                         string = "#7aaa82", -- sage green
    --                         variable = "#b0bac4", -- plain foreground – no colour noise
    --                         keyword = "#b8847f", -- muted coral
    --                         func = "#7098b8", -- slate blue
    --                         builtin = "#9e84b8", -- dusty lavender
    --                         type = "#7098b8",
    --                         operator = "#7a8a96",
    --                         number = "#b89566",
    --                         bracket = "#6e7d8a",
    --                         tag = "#7aaa82",
    --                         delimiter = "#4e5a66",
    --                     },
    --                     diag = {
    --                         error = "#9e5f5c",
    --                         warning = "#9e7a47",
    --                         info = "#3d6e9e",
    --                         hint = "#3d7a72",
    --                     },
    --                     git = {
    --                         add = "#4e8a56",
    --                         changed = "#9e7a47",
    --                         removed = "#9e5f5c",
    --                         conflict = "#9e5f5c",
    --                         ignored = "#3d4a57",
    --                     },
    --                 },
    --             },
    --
    --             -- ── options ──────────────────────────────────────────────────────
    --             options = {
    --                 transparent = true,
    --                 dim_inactive = false,
    --                 terminal_colors = false,
    --                 styles = {
    --                     -- comments = "italic", -- italic keeps comments visually distinct
    --                     -- keywords = "bold",   -- uncomment if you want weight on keywords
    --                 },
    --             },
    --         })
    --
    --         vim.cmd("colorscheme github_dark")
    --     end,
    -- },

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

    -- {
    --     dir = "/home/pisgah/.config/nvim/lua/plugins/ember-washed.nvim",
    --     name = "ember-washed",
    --     -- lazy = false,
    --     -- priority = 1000,
    --     config = function()
    --         require("ember-washed").setup({ transparent = true })
    --         -- vim.cmd("colorscheme ember-washed")
    --     end,
    -- },

    --Colourschemes

    "UtkarshVerma/molokai.nvim",
    "akinsho/horizon.nvim",
    "briones-gabriel/darcula-solid.nvim",
    "rebelot/kanagawa.nvim",
    "shaunsingh/nord.nvim",
    "kdheepak/monochrome.nvim",
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
                background = "medium", -- Options: "soft", "medium", "hard"
                transparent_background_level = 2, -- 0 (no transparency), 1 (some transparency), 2 (full transparency)
                -- italics = true,                  -- Enable italics for better aesthetics
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
                    python = { colorscheme = "everforest" }, --"everforest"
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
