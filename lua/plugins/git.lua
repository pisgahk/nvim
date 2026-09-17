require("gitsigns").setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    current_line_blame = false,
})

---[gitgraph]-------------------------------------------------------------------------

require("gitgraph").setup({
    git_cmd = "git",
    symbols = {
        merge_commit = "M",
        commit = "*",
    },
    format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
    hooks = {
        on_select_commit = function(commit)
            print("selected commit:", commit.hash)
        end,
        on_select_range_commit = function(from, to)
            print("selected range:", from.hash, to.hash)
        end,
    },
})

vim.keymap.set("n", "<leader>gx", function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, { desc = "GitGraph - Draw" })
