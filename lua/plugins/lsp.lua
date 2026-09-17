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
            "j-hui/fidget.nvim",
        },

        config = function()
            -- 🧱 Custom floating borders
            local border = {
                { "꧞", "FloatBorder" },
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

            require("fidget").setup({
                notification = {
                    window = {
                        border = "rounded",
                        relative = "editor",
                        winblend = 100,
                    },
                },
            })

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "basedpyright",
                    -- "rust_analyzer", -- 🚨 Install rust in your system instead.
                    "bashls",
                    "sqlls",
                    "html",
                    "cssls",
                    "ts_ls",
                    "jsonls",
                    "eslint",
                    "emmet_ls",
                    "tinymist",
                    "tailwindcss",
                    "zls",
                    "hyprls",
                    "jsonls",
                },
                automatic_installation = true,
            })

            vim.lsp.enable("qmlls")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 🔔 Diagnostics signs
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
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
                    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                    keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
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

            -- ─────────────────────────────────────────────────────────────
            -- 🔧 LSP SERVER CONFIGS (v3 API: vim.lsp.config + vim.lsp.enable)
            -- ─────────────────────────────────────────────────────────────

            local servers_with_custom_config = {
                lua_ls = true,
                rust_analyzer = true,
                basedpyright = true,
                bashls = true,
                emmet_ls = true,
                tailwindcss = true,
                tinymist = true,
                ast_grep = true,
                qmlls = true,
            }

            -- Auto-enable servers that don't need custom config
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                if not servers_with_custom_config[server] then
                    vim.lsp.config[server] = { capabilities = capabilities }
                    vim.lsp.enable(server)
                end
            end

            -- 🦀 Rust
            vim.lsp.config["rust_analyzer"] = {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        inlayHints = { enable = false },
                        cargo = { allFeatures = true },
                        check = { command = "clippy" },
                        diagnostics = { disabled = { "unresolved-proc-macro" } },
                        imports = {
                            granularity = { group = "crate" },
                            prefix = "by_self",
                        },
                        assist = {
                            importMergeBehavior = "crate",
                        },
                    },
                },
            }
            vim.lsp.enable("rust_analyzer")

            -- 🐍 Python
            -- vim.lsp.config["pyright"] = {
            -- 	capabilities = capabilities,
            -- 	settings = {
            -- 		python = {
            -- 			analysis = {
            -- 				typeCheckingMode = "basic",
            -- 				autoSearchPaths = true,
            -- 				useLibraryCodeForTypes = true,
            -- 				diagonisticMode = "workspace",
            -- 				logLevel = "Information",
            -- 				autoImportCompletions = true,
            -- 				inlayHints = {
            -- 					variableTypes = true,
            -- 					parameterNames = true,
            -- 					functionReturnTypes = true,
            -- 				},
            -- 				diagnosticSeverityOverrides = {
            -- 					reportWildcardImportFromLibrary = "none",
            -- 				},
            -- 			},
            -- 			-- pythonPath = vim.fn.expand("~/.local/share/uv/tools/manim/bin/python"),
            -- 			-- pythonPath = vim.fn.getcwd() .. "/.venv/bin/python3",
            -- 		},
            -- 	},
            -- }

            -- 🐍 Python (basedpyright)
            vim.lsp.config["basedpyright"] = {
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "basic", -- off | basic | standard | strict | all | recommended
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace", -- fixed typo from "diagonisticMode"
                            logLevel = "Information",
                            autoImportCompletions = true,
                            inlayHints = {
                                variableTypes = true,
                                parameterNames = true,
                                functionReturnTypes = true,
                            },
                            diagnosticSeverityOverrides = {
                                reportWildcardImportFromLibrary = "none",
                            },
                        },
                    },
                    -- python = {
                    -- 	pythonPath = vim.fn.expand("~/.local/share/uv/tools/manim/bin/python"),
                    -- 	pythonPath = vim.fn.getcwd() .. "/.venv/bin/python3",
                    -- },
                },
            }
            vim.lsp.enable("basedpyright")

            -- 🌙 Lua
            vim.lsp.config["lua_ls"] = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "Snacks", "opt", "g", "kmap", "cmd" },
                        },
                    },
                },
            }
            vim.lsp.enable("lua_ls")

            -- 🐚 Bash
            vim.lsp.config["bashls"] = {
                capabilities = capabilities,
                filetypes = { "sh" },
                cmd = { "bash-language-server", "start" },
                settings = {
                    bashIde = {
                        globPattern = "*@(.sh|.bash)",
                    },
                },
                root_dir = vim.loop.cwd,
            }
            vim.lsp.enable("bashls")

            -- 📦 JSON
            vim.lsp.config["jsonls"] = {
                capabilities = capabilities,
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            }
            vim.lsp.enable("jsonls")

            -- 🌸 Emmet
            vim.lsp.config["emmet_ls"] = {
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "css",
                    "javascriptreact",
                    "typescriptreact",
                },
                init_options = {
                    html = {
                        options = {
                            ["bem.enabled"] = true,
                        },
                    },
                },
            }
            vim.lsp.enable("emmet_ls")

            -- 🎨 Tailwind CSS
            vim.lsp.config["tailwindcss"] = {
                capabilities = capabilities,
                filetypes = { "html", "css" },
                init_options = {
                    userLanguages = {
                        rust = "html",
                    },
                },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                { "tw`([^`]*)",     "tw" },
                                { 'tw="([^"]*)',    "tw" },
                                { 'tw={"([^"]*)"}', "tw" },
                            },
                        },
                    },
                },
            }
            vim.lsp.enable("tailwindcss")

            -- 📝 Tinymist (Typst)
            vim.lsp.config["tinymist"] = {
                capabilities = capabilities,
                settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onType",
                    pdfOutputPath = "build",
                    compileOnSave = true,
                    diagnostics = { enable = true },
                },
            }
            vim.lsp.enable("tinymist")

            -- 🔍 ast-grep (Dart)
            vim.lsp.config["ast_grep"] = {
                capabilities = capabilities,
                filetypes = { "dart" },
                cmd = { "sg", "lsp" },
            }
            vim.lsp.enable("ast_grep")

            vim.lsp.config["qmlls"] = {
                capabilities = capabilities,
                cmd = { "qmlls", "--import-path", "/usr/lib64/qt6/qml" },
                filetypes = { "qml" },
                -- root_markers = { "shell.qml", ".git" },
            }
        end,
    },
}
