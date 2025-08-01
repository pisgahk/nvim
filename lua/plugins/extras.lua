--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Extras.

-- cooked by P!5g@h
-- snacks.nvim, auto-pairs, which-key, colourizer, rainbow-delimiters.
-- rust-tools, live-preview, auto-tag, snake-game

return {

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                colors = {
                    header = "#ff5f5f", -- Red header text
                    center = "#ff8787", -- Slightly lighter red for main options
                    footer = "#dcdccc", -- Neutral footer for contrast
                    icon = "#ff5f5f",   -- Red icons for consistency
                    key = "#ff8787",    -- Keybind hints in red
                },
                preset = {              -- Add your own header here.
                    header = [[
██████╗ ██╗███████╗ ██████╗  █████╗ ██╗  ██╗   ██████╗ ███████╗██╗   ██╗
██╔══██╗██║██╔════╝██╔════╝ ██╔══██╗██║  ██║   ██╔══██╗██╔════╝██║   ██║
██████╔╝██║███████╗██║  ███╗███████║███████║   ██║  ██║█████╗  ██║   ██║
██╔═══╝ ██║╚════██║██║   ██║██╔══██║██╔══██║   ██║  ██║██╔══╝  ╚██╗ ██╔╝
█║     ██║███████║╚██████╔╝██║  ██║██║  ██║██╗██████╔╝███████╗ ╚████╔╝
╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝  ╚═══╝
=========================[Better Your Best🌹]==========================
Build so much volume that there would be no option than to be successful.
 
]],
                },
            },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        layout = { layout = { position = "right", width = 30 } },
                        hidden = true,
                        ignored = true,
                    },
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            image = {
                enabled = true,
                doc = {
                    enabled = true,
                    inline = true, -- set to true if you want inline rendering
                    float = true,
                    max_width = 60,
                    max_height = 30,
                },
                convert = {
                    notify = true,     -- whether to show notifications on image render
                    magick = "magick", -- or path to your ImageMagick binary
                    mermaid = "mmdc",  -- or path to Mermaid CLI if used
                    formats = {
                        "png",
                        "jpg",
                        "jpeg",
                        "gif",
                        "bmp",
                        "webp",
                        "tiff",
                        "heic",
                        "avif",
                        "mp4",
                        "mov",
                        "avi",
                        "mkv",
                        "webm",
                        "pdf",
                        "ico",
                        "svg",
                        "psd",
                        "dds",
                        "jp2",
                        "jxl",
                        "icns",
                    },
                },
                math = {
                    enabled = true,
                },
                force = true,
            },

            styles = {
                notification = {
                    relative = "editor",
                    -- wo = { wrap = true } -- Wrap notifications
                },
                snacks_image = {
                    relative = "editor",
                    col = -1, -- top-right corner
                },
            },
        },
        keys = {
            -- Top Pickers & Explorer
            {
                "<leader><space>",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Smart Find Files",
            },
            {
                "<leader>,",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            -- {
            --     "<leader>/",
            --     function()
            --         Snacks.picker.grep()
            --     end,
            --     desc = "Grep",
            -- },
            {
                "<leader>:",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>n",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notification History",
            },
            {
                "<leader>e",
                function()
                    Snacks.explorer()
                end,
                desc = "File Explorer",
            },
            --[find]--------------------------------------------------------------------------------------------------------
            -- {
            --     "<leader>fb",
            --     function()
            --         Snacks.picker.buffers()
            --     end,
            --     desc = "Buffers",
            -- },
            -- {
            --     "<leader>fc",
            --     function()
            --         Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            --     end,
            --     desc = "Find Config File",
            -- },
            -- {
            --     "<leader>ff",
            --     function()
            --         Snacks.picker.files()
            --     end,
            --     desc = "Find Files",
            -- },
            -- {
            --     "<leader>fg",
            --     function()
            --         Snacks.picker.git_files()
            --     end,
            --     desc = "Find Git Files",
            -- },
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Projects",
            },
            {
                "<leader>fr",
                function()
                    Snacks.picker.recent()
                end,
                desc = "Recent",
            },
            --[git]---------------------------------------------------------------------------------------------------------------
            {
                "<leader>gb",
                function()
                    Snacks.picker.git_branches()
                end,
                desc = "Git Branches",
            },
            {
                "<leader>gl",
                function()
                    Snacks.picker.git_log()
                end,
                desc = "Git Log",
            },
            {
                "<leader>gL",
                function()
                    Snacks.picker.git_log_line()
                end,
                desc = "Git Log Line",
            },
            {
                "<leader>gs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            {
                "<leader>gS",
                function()
                    Snacks.picker.git_stash()
                end,
                desc = "Git Stash",
            },
            {
                "<leader>gd",
                function()
                    Snacks.picker.git_diff()
                end,
                desc = "Git Diff (Hunks)",
            },
            {
                "<leader>gf",
                function()
                    Snacks.picker.git_log_file()
                end,
                desc = "Git Log File",
            },
            --[Grep]--------------------------------------------------------------------------------------------------------------------
            {
                "<leader>sb",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Buffer Lines",
            },
            -- {
            --     "<leader>sB",
            --     function()
            --         Snacks.picker.grep_buffers()
            --     end,
            --     desc = "Grep Open Buffers",
            -- },
            -- {
            --     "<leader>sg",
            --     function()
            --         Snacks.picker.grep()
            --     end,
            --     desc = "Grep",
            -- },
            -- {
            --     "<leader>sw",
            --     function()
            --         Snacks.picker.grep_word()
            --     end,
            --     desc = "Visual selection or word",
            --     mode = { "n", "x" },
            -- },
            -- search
            {
                "<leader>sr",
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<leader>s/",
                function()
                    Snacks.picker.search_history()
                end,
                desc = "Search History",
            },
            {
                "<leader>sa",
                function()
                    Snacks.picker.autocmds()
                end,
                desc = "Autocmds",
            },
            -- {
            --     "<leader>sb",
            --     function()
            --         Snacks.picker.lines()
            --     end,
            --     desc = "Buffer Lines",
            -- },
            -- {
            --     "<leader>sc",
            --     function()
            --         Snacks.picker.command_history()
            --     end,
            --     desc = "Command History",
            -- },
            {
                "<leader>sc",
                function()
                    Snacks.picker.commands()
                end,
                desc = "Commands",
            },
            {
                "<leader>sd",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>sD",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>sh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>sH",
                function()
                    Snacks.picker.highlights()
                end,
                desc = "Highlights",
            },
            {
                "<leader>si",
                function()
                    Snacks.picker.icons()
                end,
                desc = "Icons",
            },
            -- {
            --     "<leader>sj",
            --     function()
            --         Snacks.picker.jumps()
            --     end,
            --     desc = "Jumps",
            -- },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            -- {
            --     "<leader>sl",
            --     function()
            --         Snacks.picker.loclist()
            --     end,
            --     desc = "Location List",
            -- },
            {
                "<leader>sm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Marks",
            },
            {
                "<leader>sM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                "<leader>sp",
                function()
                    Snacks.picker.lazy()
                end,
                desc = "Search for Plugin Spec",
            },
            -- {
            --     "<leader>sq",
            --     function()
            --         Snacks.picker.qflist()
            --     end,
            --     desc = "Quickfix List",
            -- },
            -- {
            --     "<leader>sR",
            --     function()
            --         Snacks.picker.resume()
            --     end,
            --     desc = "Resume",
            -- },
            {
                "<leader>su",
                function()
                    Snacks.picker.undo()
                end,
                desc = "Undo History",
            },
            {
                "<leader>uC",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            -- LSP
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Goto Definition",
            },
            {
                "gD",
                function()
                    Snacks.picker.lsp_declarations()
                end,
                desc = "Goto Declaration",
            },
            {
                "gr",
                function()
                    Snacks.picker.lsp_references()
                end,
                nowait = true,
                desc = "References",
            },
            {
                "gI",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Goto Implementation",
            },
            {
                "gy",
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "Goto Type Definition",
            },
            -- {
            --     "<leader>ss",
            --     function()
            --         Snacks.picker.lsp_symbols()
            --     end,
            --     desc = "LSP Symbols",
            -- },
            -- {
            --     "<leader>sS",
            --     function()
            --         Snacks.picker.lsp_workspace_symbols()
            --     end,
            --     desc = "LSP Workspace Symbols",
            -- },
            -- Other
            {
                "<leader>z",
                function()
                    Snacks.zen()
                end,
                desc = "Toggle Zen Mode",
            },
            -- {
            --     "<leader>Z",
            --     function()
            --         Snacks.zen.zoom()
            --     end,
            --     desc = "Toggle Zoom",
            -- },
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>n",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Notification History",
            },
            -- {
            --     "<leader>bd",
            --     function()
            --         Snacks.bufdelete()
            --     end,
            --     desc = "Delete Buffer",
            -- },
            -- {
            --     "<leader>cR",
            --     function()
            --         Snacks.rename.rename_file()
            --     end,
            --     desc = "Rename File",
            -- },
            {
                "<leader>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
                mode = { "n", "v" },
            },
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>un",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Dismiss All Notifications",
            },
            {
                "<c-/>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
            -- {
            --     "<c-_>",
            --     function()
            --         Snacks.terminal()
            --     end,
            --     desc = "which_key_ignore",
            -- },
            {
                "]]",
                function()
                    Snacks.words.jump(vim.v.count1)
                end,
                desc = "Next Reference",
                mode = { "n", "t" },
            },
            {
                "[[",
                function()
                    Snacks.words.jump(-vim.v.count1)
                end,
                desc = "Prev Reference",
                mode = { "n", "t" },
            },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle
                        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                        :map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle
                        .option("background", { off = "light", on = "dark", name = "Dark Background" })
                        :map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")

                    -- override inlay snacks.nvim background
                    -- vim.api.nvim_set_hl(0, "SnacksInlayHint", { bg = "NONE" })
                end,
            })
        end,
    },
    {
        "windwp/nvim-autopairs", -- Auto closing brackets, parenthesis etc.
        lazy = false,
        event = "InsertEnter",
        config = true,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.icons",
        },
        opts = {
            preset = "helix",
            windows = true,
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            icons = {
                breadcrumb = "::",
                separator = "~",
                group = "+",
            },
        },
    },

    {
        "norcalli/nvim-colorizer.lua", -- Hex Colour Highlighting.
        config = function()
            require("colorizer").setup({
                "*",
            }, {
                mode = "background",
            })
        end,
    },

    "hiphish/rainbow-delimiters.nvim", -- Brackets, parenthesis colorizer

    "simrat39/rust-tools.nvim",        -- Rust tools

    {
        "brianhuster/live-preview.nvim", --Render .html & .md files.
    },

    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        lazy = false,
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_rename = true,
                },
                did_setup = function() end,
                setup = function() end,
                get_opts = function()
                    return {}
                end,
            })
        end,
    },

    "someguy0555/snake.nvim", -- run `Snake`
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            enabled = true,
            smear_between_buffers = true,
            smear_insert_mode = true,
            cursor_color = "#d3cdc3", -- match your theme
            stiffness = 0.9,
            trailing_stiffness = 0.8,
            distance_stop_animating = 0.3,
        },
    },
}
