-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Snippets.

-- cooked by P!5g@h
-- LuaSnip, friendly-snippets

return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local luasnip = require("luasnip")

            -- 🔃 Reload snippets on save (for live tweaking)
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = vim.fn.stdpath("config") .. "/lua/snippets/*.lua",
                callback = function()
                    luasnip.cleanup()
                    require("luasnip.loaders.from_lua").lazy_load({
                        paths = vim.fn.stdpath("config") .. "/lua/snippets",
                    })
                end,
            })

            -- 📥 Load community & custom snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({
                paths = vim.fn.stdpath("config") .. "/lua/snippets", -- your snippets here
            })

            -- ⚙️ Options
            luasnip.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })
        end,
    },
}
