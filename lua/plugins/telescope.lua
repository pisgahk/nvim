-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Telescope.

-- cooked by P!5g@h
-- telescope

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",              -- Required
        "nvim-telescope/telescope-fzf-native.nvim", -- Optional but fast
        "nvim-tree/nvim-web-devicons",        -- For icons
    },
    build = "make",
    opts = {
        defaults = {
            layout_config = {
                horizontal = { width = 0.9, preview_cutoff = 120 },
            },
            prompt_prefix = "🔍 ",
            selection_caret = " ",
            sorting_strategy = "ascending",
            winblend = 10,
            -- mappings = {
            --     i = {
            --         ["<Esc>"] = require("telescope.actions").close,
            --     },
            -- },
        },
        pickers = {
            find_files = {
                hidden = true,
                previewer = false,
            },
            live_grep = {
                only_sort_text = true,
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        pcall(telescope.load_extension, "fzf")
    end,
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>",                     desc = "Find Git Files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers" },
        { "<leader>/",  "<cmd>Telescope live_grep<cr>",                     desc = "Grep Content" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>",                       desc = "Keymaps" },
        { "<leader>fc", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", desc = "Find Config" },
    },
}
