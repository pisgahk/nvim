--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝LSP.

-- cooked by P!5g@h.
-- lsp-config, neo-dev, mason, none-ls(formatter)

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "williamboman/mason.nvim",             build = ":MasonUpdate" },
            "williamboman/mason-lspconfig.nvim",
            { "antosha417/nvim-lsp-file-operations", config = true },
            { "folke/neodev.nvim",                   opts = {} },
            "j-hui/fidget.nvim",
        },
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "Snacks" },
                },
            },
        },
        config = function()
            -- 🧱 Custom floating borders
            local border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            }

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or border
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            require("neodev").setup({})
            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "bashls",
                    "gopls",
                    "sqlls",
                    "solang",
                    "html",
                    "cssls",
                    "ts_ls",
                    "jsonls",
                    "eslint",
                },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 🔔 Diagnostics signs
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
            end

            -- 🔑 Keymaps on attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    local keymap = vim.keymap

                    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                    keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
                        --vim.cmd("wincmd w")
                    end, opts)
                end,
            })

            -- ✒️ Inlay hint support (Neovim 0.10+)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspInlayHints", {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                end,
            })

            -- Setup all installed LSP servers
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

            -- Rust setup
            lspconfig["rust_analyzer"].setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        check = { command = "clippy" }, -- ✅ Replaces deprecated 'checkOnSave'
                        diagnostics = { disabled = { "unresolved-proc-macro" } },
                        imports = {
                            granularity = {
                                group = "crate", -- ✅ Must be one of: "preserve", "item", "crate", "module", "one"
                            },
                            prefix = "by_self", -- ✅ Replaces deprecated 'importPrefix'
                        },
                        assist = {
                            importMergeBehavior = "crate", -- ✅ Valid values: `preserve`, `item`, `crate`, `module`, `one`
                        },
                    },
                },
            })

            -- Python setup
            lspconfig["pyright"].setup({
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "Snacks" },
                        },
                    },
                },
            })

            -- Golang setup
            lspconfig["gopls"].setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            -- Solana setup
            lspconfig["solang"].setup({
                capabilities = capabilities,
                settings = {
                    solang = {
                        includePaths = { "/usr/local/include" },
                    },
                },
            })

            -- 🌍 Generic setups
            local servers = { "bashls", "cssls", "html", "jsonls", "ts_ls", "eslint", "sqlls" }

            --[[for _, server in ipairs(servers) do
                lspconfig[server].setup({ capabilities = capabilities })
            end]]

            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                if server ~= "lua_ls" then
                    lspconfig[server].setup({ capabilities = capabilities })
                end
            end
        end,
    },

    -- 🛠 Formatters via null-ls
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" },
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })

            require("mason-null-ls").setup({
                ensure_installed = {
                    "stylua",
                    "black",
                    "shfmt",
                    "goimports",
                    "sqlfluff",
                    "prettier",
                },
                automatic_installation = true,
            })
        end,
    },
}
