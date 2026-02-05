return {
    {
        "DariusCorvus/surrealdb.nvim",
        dependencies = { "nvim-treesitter" },
        config = function()
            require("surrealdb-nvim").setup({
                connection = {
                    host = "http://localhost:8000/sql",
                    ns = "test",
                    db = "test",
                    user = "root",
                    pass = "root",
                },
                file = {
                    extension = { "*.sdb", "*.surql", "*.sql" },
                    run_on_safe = false,
                    type = "sql",
                },
                keymaps = {
                    { "n", "<leader>5",  ":SurrealDBRun buf<CR>" },
                    { "n", "<leader>5l", ":SurrealDBRun ln<CR>" },
                    { "v", "<leader>5",  ":<C-U>SurrealDBRun sel<CR>" },
                },
                virtual_texts = {
                    success = { "", "GreenSign" },
                    fail = { "", "RedSign" },
                },
                output = {
                    buf_name = "SurrealDB Response",
                    split = "vertical",
                    format_cmd = ":%!jq --indent 2",
                },
                scratchpad = {
                    buf_name = "SurrealDB Scratchpad",
                    split = "horizontal",
                },
            })
        end,
    },
}
