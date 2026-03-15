-- return {
--     "dccsillag/magma-nvim",
--     build = ":UpdateRemotePlugins",
--     config = function()
--         -- Magma settings
--         vim.g.magma_image_provider = "kitty"    -- or "ueberzug" depending on your terminal
--         vim.g.magma_automatically_open_output = false -- don’t auto-open inline results
--         vim.g.magma_wrap_output = true
--         vim.g.magma_output_window_borders = true
--
--         -- Define custom cell delimiters (Python style + your Iron marker)
--         -- vim.g.magma_cell_delimiters = { "# %%", "#%%", "###", "# ---[" },
--
--         -- Keymaps (mirroring your Iron.nvim style)
--         local opts = { silent = true }
--
--         -- Toggle/init kernel
--         vim.keymap.set("n", "<space>rr", ":MagmaInit python3<CR>", opts)
--         vim.keymap.set("n", "<space>rR", ":MagmaRestart!<CR>", opts)
--
--         -- Send code
--         vim.keymap.set("n", "<space>sl", ":MagmaEvaluateLine<CR>", opts)
--         vim.keymap.set("n", "<space>sp", ":MagmaEvaluateParagraph<CR>", opts)
--         vim.keymap.set("v", "<space>sv", ":<C-u>MagmaEvaluateVisual<CR>", opts)
--         vim.keymap.set("n", "<space>sf", ":MagmaEvaluateFile<CR>", opts)
--
--         -- Cell execution (like Jupyter # %% blocks)
--         vim.keymap.set("n", "<space>sc", ":MagmaEvaluateOperator<CR>", opts)
--         vim.keymap.set("n", "<space>sb", ":MagmaEvaluateCell<CR>", opts)
--
--         -- Control
--         vim.keymap.set("n", "<space>sq", ":MagmaInterrupt<CR>", opts)
--         vim.keymap.set("n", "<space>cl", ":MagmaClear<CR>", opts)
--
--         -- Focus/hide output (similar to IronFocus/IronHide)
--         vim.keymap.set("n", "<space>rf", ":MagmaShowOutput<CR>", opts)
--         vim.keymap.set("n", "<space>rh", ":MagmaHideOutput<CR>", opts)
--     end,
-- }

-- return {
--     "benlubas/molten-nvim",
--     build = ":UpdateRemotePlugins",
--     config = function()
--         -- Molten settings
--         vim.g.molten_image_provider = "kitty" -- or "ueberzug" depending on your terminal
--         vim.g.molten_auto_open_output = false
--         vim.g.molten_wrap_output = true
--         vim.g.molten_output_win_borders = true
--
--         -- Define custom cell delimiters (Python style + your Iron marker)
--         vim.g.molten_cell_delimiters = { "# %%", "#%%", "###", "# ---[" }
--
--         local opts = { silent = true }
--
--         -- Kernel management
--         vim.keymap.set("n", "<space>rr", ":MoltenInit python3<CR>", opts)
--         vim.keymap.set("n", "<space>rR", ":MoltenRestart!<CR>", opts)
--
--         -- Sending code
--         vim.keymap.set("n", "<space>sl", ":MoltenEvaluateLine<CR>", opts)
--         vim.keymap.set("n", "<space>sp", ":MoltenEvaluateParagraph<CR>", opts)
--         vim.keymap.set("v", "<space>sv", ":<C-u>MoltenEvaluateVisual<CR>", opts)
--         vim.keymap.set("n", "<space>sf", ":MoltenEvaluateFile<CR>", opts)
--
--         -- Cell execution (using your custom delimiters)
--         vim.keymap.set("n", "<space>sb", ":MoltenEvaluateCell<CR>", opts)
--         vim.keymap.set("n", "<space>sc", ":MoltenEvaluateOperator<CR>", opts)
--
--         -- Control
--         vim.keymap.set("n", "<space>sq", ":MoltenInterrupt<CR>", opts)
--         vim.keymap.set("n", "<space>cl", ":MoltenClear<CR>", opts)
--
--         -- Output focus/hide (similar to IronFocus/IronHide)
--         vim.keymap.set("n", "<space>rf", ":MoltenShowOutput<CR>", opts)
--         vim.keymap.set("n", "<space>rh", ":MoltenHideOutput<CR>", opts)
--     end,
-- }

-- return {
--   {
--     "benlubas/molten-nvim",
--     version = "^1.0.0",
--     dependencies = {
--       "3rd/image.nvim",
--     },
--     build = ":UpdateRemotePlugins",
--     init = function()
--       vim.g.molten_image_provider        = "image.nvim"
--       vim.g.molten_output_win_max_height = 20
--       vim.g.molten_auto_open_output      = true
--       vim.g.molten_wrap_output           = true
--       vim.g.molten_virt_text_output      = true
--       vim.g.molten_virt_lines_off_by_1   = true
--     end,
--     config = function()
--       -- Auto-init correct kernel by filetype
--       vim.api.nvim_create_autocmd("BufEnter", {
--         pattern = "*.py",
--         callback = function()
--           pcall(vim.cmd, "MoltenInit python3")
--         end,
--       })
--
--       vim.api.nvim_create_autocmd("BufEnter", {
--         pattern = "*.rs",
--         callback = function()
--           pcall(vim.cmd, "MoltenInit rust")
--         end,
--       })
--
--       -- Keymaps
--       local opts = { noremap = true, silent = true }
--
--       vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",                    opts)
--       vim.keymap.set("n", "<localleader>e",  ":MoltenEvaluateOperator<CR>",        opts)
--       vim.keymap.set("n", "<localleader>el", ":MoltenEvaluateLine<CR>",            opts)
--       vim.keymap.set("n", "<localleader>ec", ":MoltenReevaluateCell<CR>",          opts)
--       vim.keymap.set("v", "<localleader>ev", ":<C-u>MoltenEvaluateVisual<CR>",     opts)
--       vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",              opts)
--       vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",   opts)
--       vim.keymap.set("n", "<localleader>od", ":MoltenDelete<CR>",                  opts)
--       vim.keymap.set("n", "<localleader>kr", ":MoltenRestart<CR>",                 opts)
--       vim.keymap.set("n", "<localleader>ki", ":MoltenInterrupt<CR>",               opts)
--     end,
--   },
--
--   {
--     "3rd/image.nvim",
--     opts = {
--       backend                    = "kitty", -- or "ueberzug" if not on kitty/wezterm
--       integrations               = {},
--       max_width_window_percentage = 50,
--       max_height_window_percentage = 25,
--       window_overlap_clear_enabled = true,
--       window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
--     },
--   },
-- }

-- return {
--     "Vigemus/iron.nvim",
--     config = function()
--         require("iron.core").setup({
--             config = {
--                 scratch_repl = true,
--                 repl_definition = {
--                     python = {
--                         command = { "ipython", "--no-autoindent" },
--                         format = require("iron.fts.common").bracketed_paste_python,
--                     },
--                     rust = {
--                         command = { "evcxr" },
--                     },
--                 },
--                 repl_open_cmd = require("iron.view").bottom(40),
--             },
--             keymaps = {
--                 send_motion = "<space>sc",
--                 visual_send = "<space>sc",
--                 send_file = "<space>sf",
--                 send_line = "<space>sl",
--                 send_paragraph = "<space>sp",
--                 send_until_cursor = "<space>su",
--                 send_mark = "<space>sm",
--                 mark_motion = "<space>mc",
--                 mark_visual = "<space>mc",
--                 remove_mark = "<space>md",
--                 cr = "<space>s<cr>",
--                 interrupt = "<space>s<space>",
--                 exit = "<space>sq",
--                 clear = "<space>cl",
--             },
--             highlight = {
--                 italic = true,
--             },
--             ignore_blank_lines = true,
--         })
--     end,
-- }
--


return {
    "Vigemus/iron.nvim",
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")
        local common = require("iron.fts.common")

        -- 🔧 Formatter: strip full-line comments before bracketed paste
        local function strip_comments(lines, ft)
            local comment_patterns = {
                python = "^%s*#",
                rust   = "^%s*//",
                lua    = "^%s*--",
                sh     = "^%s*#",
            }
            local pat = comment_patterns[ft]
            return vim.tbl_filter(function(line)
                return not (pat and line:match(pat))
            end, lines)
        end

        iron.setup({
            config = {
                scratch_repl = false,

                repl_definition = {
                    sh = {
                        command = { "sh" },
                        format = function(lines)
                            return common.bracketed_paste(strip_comments(lines, "sh"))
                        end,
                    },
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = function(lines, extras)
                            return common.bracketed_paste_python(strip_comments(lines, "python"), extras)
                        end,
                        block_dividers = { "# %%", "#%%", "###", "# ---[" },
                    },
                    lua = {
                        command = { "lua" },
                        format = function(lines)
                            return common.bracketed_paste(strip_comments(lines, "lua"))
                        end,
                    },
                    rust = {
                        command = { "evcxr" },
                        format = function(lines)
                            return common.bracketed_paste(strip_comments(lines, "rust"))
                        end,
                    },
                },

                repl_filetype = function(_, ft)
                    return ft
                end,

                repl_open_cmd = view.split.vertical.rightbelow(80),
            },

            keymaps = {
                toggle_repl              = "<space>rr",
                restart_repl             = "<space>rR",

                send_motion              = "<space>sv",
                visual_send              = "<space>sv",
                send_file                = "<space>sf",
                send_line                = "<space>sl",
                send_paragraph           = "<space>sp",
                send_code_block_and_move = "<space>sn",
                send_until_cursor        = "<space>sc",
                send_mark                = "<space>sm",
                send_code_block          = "<space>sb",

                mark_motion              = "<space>mc",
                mark_visual              = "<space>mc",
                remove_mark              = "<space>md",

                cr                       = "<space>s<cr>",
                interrupt                = "<space>s<space>",
                exit                     = "<space>sq",
                clear                    = "<space>cl",
            },

            highlight        = { italic = false, bold = true },
            ignore_blank_lines = true,
        })

        vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
        vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
}
