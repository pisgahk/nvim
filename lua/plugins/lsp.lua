require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "◍",
            package_uninstalled = "✗",
        },
    },
    keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
        toggle_package_install_log = "<CR>",
        toggle_help = "g?",
    },
})
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "basedpyright",
        "rust_analyzer",
        "stylua",
        "ruff",
        "shfmt",
        "prettierd",
        -- "goimports",
        "sqlfluff",
        -- "typstyle",
    },
    auto_update = false,
    run_on_start = true,
})

---[lua_ls]------------------------------------
--- refer to: "https://luals.github.io/wiki/settings/"

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim", "require" },
                disable = { "missing-fields" },
                unusedLocalExclude = { "_*" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                useGitIgnore = true,
                maxPreload = 5000,
                preloadFileSize = 1000,
                ignoreDir = { ".git", "node_modules", ".cache" },
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
                keywordSnippet = "Replace",
                autoRequire = true,
                workspaceWord = true,
            },
            hint = {
                enable = true,
                paramName = "All",
                paramType = true,
                setType = true,
                arrayIndex = "Auto",
                await = true,
            },
            hover = {
                enable = true,
                expandAlias = true,
                previewFields = 50,
            },
            codeLens = {
                enable = true,
            },
            doc = {
                privateName = { "^_" },
            },
            format = {
                enable = false,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                },
            },
        },
    },
})

vim.lsp.enable("lua_ls")

---[rust_analyzer]-----------------------------
-- refer to: "https://rust-analyzer.github.io/book/configuration.html"

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {

            -- ── Cargo ─────────────────────────────────────────────────
            cargo = {
                buildScripts = { enable = true },
                autoreload = true,
            },

            -- ── Check / Clippy ────────────────────────────────────────
            check = {
                command = "check",
            },

            -- ── Proc macros ───────────────────────────────────────────
            procMacro = {
                enable = true,
                attributes = { enable = true },
                ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                },
            },

            -- ── Diagnostics ───────────────────────────────────────────
            diagnostics = {
                enable = true,
            },

            -- ── Inlay hints ───────────────────────────────────────────
            inlayHints = {
                maxLength = 40,
                renderColons = true,
                typeHints = {
                    enable = true,
                },
                parameterHints = { enable = true },
                chainingHints = { enable = true },
                closureReturnTypeHints = { enable = "with_block" },
                lifetimeElisionHints = {
                    enable = "skip_trivial",
                },
                bindingModeHints = { enable = true },
                closingBraceHints = {
                    enable = true,
                    minLines = 25,
                },
            },

            -- ── Completion ────────────────────────────────────────────
            completion = {
                privateEditable = { enable = true },
                postfix = { enable = true },
                autoimport = { enable = true },
                autoself = { enable = true },
                autoAwait = { enable = true },
                autoIter = { enable = true },
                fullFunctionSignatures = { enable = true },
                termSearch = { enable = true },
                callable = {
                    snippets = "fill_arguments",
                },
            },

            -- ── Hover ─────────────────────────────────────────────────
            hover = {
                actions = {
                    enable = true,
                    run = { enable = true },
                    debug = { enable = true },
                    gotoTypeDef = { enable = true },
                    implementations = { enable = true },
                    references = { enable = true },
                    updateTest = { enable = true },
                },
                documentation = {
                    enable = true,
                    keywords = { enable = true },
                },
                links = { enable = true },
                memoryLayout = {
                    enable = true,
                    size = "both",
                    alignment = "hexadecimal",
                    niches = true, -- shows niche optimisations
                },
                show = {
                    fields = 10, -- more fields visible on hover
                    enumVariants = 10,
                    traitAssocItems = 10,
                },
            },

            -- ── Imports ───────────────────────────────────────────────
            imports = {
                granularity = {
                    group = "crate",
                    enforce = true,
                },
                prefix = "crate",
                group = { enable = true },
                merge = { glob = false }, -- no glob imports
            },

            -- ── Lens (code lens) ──────────────────────────────────────
            lens = {
                enable = false,
            },

            -- ── Semantic highlighting ──────────────────────────────────
            semanticHighlighting = {
                operator = { enable = true },
            },

            -- ── Highlight related ─────────────────────────────────────
            highlightRelated = {
                references = { enable = true },
            },

            -- ── Assists ───────────────────────────────────────────────
            assist = {
                preferSelf = true,
            },

            -- ── Rustfmt ───────────────────────────────────────────────
            rustfmt = {
                rangeFormatting = { enable = true },
            },
        },
    },
})

vim.lsp.enable("rust_analyzer")

---[basedpyright]------------------------------------
--- refer to: "https://docs.basedpyright.com/latest/configuration/config-files/"
--- for diagnostic rules: "https://docs.basedpyright.com/latest/configuration/diagnostic-rules/"

-- vim.lsp.config("basedpyright", {
-- 	settings = {
-- 		basedpyright = {
-- 			analysis = {
-- 				-- strict mode — closest to Rust's "everything must be typed"
-- 				typeCheckingMode = "strict",
-- 				autoSearchPaths = true,
-- 				useLibraryCodeForTypes = true,
-- 				autoImportCompletions = true,
-- 				diagnosticMode = "workspace",
--
-- 				inlayHints = {
-- 					variableTypes = true,
-- 					returnTypes = true,
-- 					callArgumentNames = true,
-- 					functionReturnTypes = true,
-- 					genericTypes = true,
-- 				},
--
-- 				diagnosticSeverityOverrides = {
-- 					-- like Rust: no unknown types allowed
-- 					reportUnknownVariableType = "error",
-- 					reportUnknownParameterType = "error",
-- 					reportUnknownArgumentType = "error",
-- 					reportUnknownMemberType = "error",
-- 					reportUnknownLambdaType = "error",
-- 					reportUnknownReturnType = "error",
--
-- 					-- explicit return types on all functions
-- 					reportReturnType = "error",
-- 					reportMissingParameterType = "error",
--
-- 					-- no implicit Optional (like Rust's explicit Option<T>)
-- 					reportImplicitStringConcatenation = "warning",
--
-- 					-- ── Unused code ───────────────────────────────────────
-- 					-- like Rust: unused variables are errors
-- 					reportUnusedVariable = "error",
-- 					reportUnusedImport = "error",
-- 					reportUnusedFunction = "warning",
-- 					reportUnusedClass = "warning",
-- 					reportUnusedExpression = "warning",
--
-- 					-- ── Exhaustiveness ────────────────────────────────────
-- 					-- like Rust: match must be exhaustive
-- 					reportMatchNotExhaustive = "error",
--
-- 					-- ── Access control ────────────────────────────────────
-- 					-- like Rust: private stays private
-- 					reportPrivateUsage = "error",
-- 					reportPrivateImportUsage = "error",
--
-- 					-- ── Undefined / uninitialised ─────────────────────────
-- 					-- like Rust: no use before initialisation
-- 					reportUninitializedInstanceVariable = "error",
-- 					reportPossiblyUnbound = "error",
-- 					reportUndefinedVariable = "error",
--
-- 					-- ── Correctness ───────────────────────────────────────
-- 					reportConstantRedefinition = "error",
-- 					reportDeprecated = "warning",
-- 					reportDuplicateImport = "error",
-- 					reportFunctionMemberAccess = "error",
-- 					reportIncompatibleMethodOverride = "error",
-- 					reportIncompatibleVariableOverride = "error",
-- 					reportOperatorIssue = "error",
-- 					reportIndexIssue = "error",
-- 					reportAttributeAccessIssue = "error",
-- 					reportCallIssue = "error",
-- 					reportArgumentType = "error",
-- 					reportAssignmentType = "error",
-- 					reportGeneralTypeIssues = "error",
-- 					reportAbstractUsage = "error",
--
-- 					-- ── Missing stubs ─────────────────────────────────────
-- 					-- keep as warning — third party libs often lack stubs
-- 					reportMissingImports = "error",
-- 					reportMissingTypeStubs = "warning",
-- 					reportMissingModuleSource = "warning",
--
-- 					-- ── Decorators ────────────────────────────────────────
-- 					reportUntypedFunctionDecorator = "warning",
-- 					reportUntypedClassDecorator = "warning",
-- 					reportUntypedBaseClass = "warning",
-- 				},
-- 			},
-- 			pythonVersion = "3.12",
-- 			pythonPlatform = "Linux",
-- 		},
-- 	},
-- })

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                -- "standard" catches real bugs without demanding full typing everywhere
                typeCheckingMode = "standard",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                inlayHints = {
                    variableTypes = true,
                    returnTypes = true,
                    callArgumentNames = false, -- noisy, turn on later if you miss it
                    functionReturnTypes = true,
                    genericTypes = false,
                },
                diagnosticSeverityOverrides = {
                    -- ── Unused code — still worth catching ────────────────
                    reportUnusedVariable = "warning",
                    reportUnusedImport = "warning",
                    reportUnusedExpression = "warning",
                    -- ── Real correctness bugs, keep loud ──────────────────
                    reportUndefinedVariable = "error",
                    reportPossiblyUnbound = "error",
                    reportCallIssue = "error",
                    reportArgumentType = "error",
                    reportAttributeAccessIssue = "error",
                    reportIndexIssue = "error",
                    reportOperatorIssue = "error",
                    -- ── Everything "Unknown*" — off, this is the noisy stuff ─
                    reportUnknownVariableType = "none",
                    reportUnknownParameterType = "none",
                    reportUnknownArgumentType = "none",
                    reportUnknownMemberType = "none",
                    reportUnknownLambdaType = "none",
                    reportUnknownReturnType = "none",
                    -- ── Style/pedantic stuff — off ─────────────────────────
                    reportMissingParameterType = "none",
                    reportReturnType = "warning", -- still nice as a hint, not a wall
                    reportImplicitStringConcatenation = "none",
                    reportUnusedFunction = "none",
                    reportUnusedClass = "none",
                    reportPrivateUsage = "none",
                    reportPrivateImportUsage = "none",
                    reportUninitializedInstanceVariable = "none",
                    reportConstantRedefinition = "none",
                    reportDeprecated = "none",
                    reportDuplicateImport = "warning",
                    reportFunctionMemberAccess = "none",
                    reportIncompatibleMethodOverride = "warning",
                    reportIncompatibleVariableOverride = "none",
                    reportGeneralTypeIssues = "warning",
                    reportAssignmentType = "warning",
                    reportAbstractUsage = "warning",
                    reportMatchNotExhaustive = "none",
                    -- ── Missing stubs — third party libs, don't punish this ─
                    reportMissingImports = "error", -- still catch typos/genuinely missing pkgs
                    reportMissingTypeStubs = "none",
                    reportMissingModuleSource = "none",
                    -- ── Decorators — off, most libs don't type these ──────
                    reportUntypedFunctionDecorator = "none",
                    reportUntypedClassDecorator = "none",
                    reportUntypedBaseClass = "none",
                },
            },
            pythonVersion = "3.12",
            pythonPlatform = "Linux",
        },
    },
})

vim.lsp.enable("basedpyright")

-- ---[qmlls]--------------------------------------------------------

-- ~/.config/nvim/lua/plugins/quickshell-qml.lua (or wherever you keep LSP config)

vim.lsp.config("qmlls", {
    cmd = { "qmlls", "-E" },
    filetypes = { "qml" },
    root_markers = { ".qmlls.ini", "shell.qml", ".git" },
    -- QuickShell ships its own QML modules (Quickshell, Quickshell.Io, etc).
    -- qmlls needs to know where to find them, otherwise you'll get false
    -- "unknown import" / "unknown type" diagnostics on every Quickshell.* import.
    cmd_env = {
        QML_IMPORT_PATH = table.concat({
            vim.fn.expand("~/.local/share/quickshell/qml"), -- adjust to your actual install path
            "/usr/lib/qt6/qml",
            "/usr/lib64/qt6/qml",
        }, ":"),
    },
    settings = {},
})

vim.lsp.enable("qmlls")

-- Treesitter grammar for QML syntax highlighting/indent/textobjects
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
    ts.setup({
        ensure_installed = { "qmljs" },
        highlight = { enable = true },
        indent = { enable = true },
    })
end

-- Make sure Neovim recognizes .qml files (usually automatic, but explicit
-- is safer with QuickShell's non-standard file layouts like shell.qml)
vim.filetype.add({
    extension = { qml = "qml" },
})

-- Native LSP completion (built-in since 0.11, no plugin needed) — triggers
-- on every keystroke instead of requiring manual <C-x><C-o>

---[I am using blink.cmp hence removing this.]---
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client and client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

-- Quality-of-life diagnostics/hover config that helps a lot with QML's
-- fairly sparse error messages
vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = "●" },
    float = { border = "rounded", source = true },
    severity_sort = true,
})

-- Optional: keymaps scoped to qml buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qml",
    callback = function(args)
        local buf = args.buf
        local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true })
        end
        map("n", "K", vim.lsp.buf.hover)
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("i", "<C-Space>", function()
            vim.lsp.completion.get()
        end)
    end,
})
