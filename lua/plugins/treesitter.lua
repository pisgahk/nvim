-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Treesitter.

-- cooked by P!5g@h.
-- treesitter
--
--
--
--
-- You have to install the cli tool in your terminal with `cargo install tree-sitter-cli`.

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- modules = {},
    build = ":TSUpdate",
    -- event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- "nvim-treesitter/playground",
    },
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "comment",
                "css",
                "diff",
                "dot",
                "hjson",
                "html",
                "http",
                "java",
                "javascript",
                "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "php",
                "python",
                "query",
                "regex",
                "rust",
                "scss",
                "sql",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "scala",
                "dockerfile",
                "go",
                "typst",
                "zig",
            },
            sync_install = true,
            auto_install = true,
            ignore_install = {},

            -- 🎨 Syntax highlighting
            highlight = {
                enable = false,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },

            -- 🧱 Smart indenting
            indent = {
                enable = true,
            },

            -- 🎯 Incremental selection
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = "<BS>",
                    scope_incremental = "<C-s>",
                },
            },

            -- 🧠 Textobjects (selection + movement)
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                },
            },
        })

        -- Optional: Enable smart folding
        --
        --     vim.o.foldenable = false -- disable folding on startup
        --     vim.o.foldmethod = "expr"
        --     vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        --
        --     -- Keymap to toggle folding logic
        --     vim.keymap.set("n", "<leader>tf", function()
        --         if vim.o.foldmethod == "manual" then
        --             vim.o.foldmethod = "expr"
        --             vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        --             print("Folding enabled")
        --         else
        --             vim.o.foldmethod = "manual"
        --             print("Folding disabled")
        --         end
        --     end, { desc = "Toggle folding (Treesitter)" })
    end,
}
