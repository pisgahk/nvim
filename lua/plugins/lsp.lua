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
			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
			"williamboman/mason-lspconfig.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			-- { "folke/neodev.nvim", opts = {} },
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
				{ "꧞", "FloatBorder" }, -- "╭"
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

			-- require("neodev").setup({})
			-- require("fidget").setup({})
			require("fidget").setup({
				notification = {
					window = {
						border = "rounded", -- choose: "single", "double", "rounded", "solid", "shadow"
						relative = "editor", -- position relative to the editor
						winblend = 100, -- transparency (0 = opaque)
					},
				},
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					-- "lua_language_server",
					"pyright",
					-- "rust_analyzer", -- 🚨Install rust in your system instead.
					"bashls",
					-- "gopls",
					"sqlls",
					-- "solang",
					"html",
					"cssls",
					"ts_ls",
					"jsonls",
					"eslint",
					"emmet_ls",
					"tinymist", -- for .typ
					"tailwindcss",
					"zls",
					"hyprls",
					-- "shellcheck",
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
					-- keymap.set("n", "[d", vim.diagnostic.jump({ count = -1, float = true}), opts)
					-- keymap.set("n", "]d", vim.diagnostic.jump({ count = 1, float = true}), opts)
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
						inlayHints = {
							enable = false,
							-- parameterHints = { enable = true },
							-- typeHints = { enable = true },
						},
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
							typeCheckingMode = "basic", -- "off", "basic" and "strict"
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagonisticMode = "workspace", -- "openFilesOnly" or "workspace"
						},
					},
				},
			})

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "Snacks", "opt", "g", "kmap", "cmd" },
						},
					},
				},
			})

			lspconfig["bashls"].setup({
				capabilities = capabilities,
				filetypes = { "sh" },
				cmd = { "bash-language-server", "start" },
				settings = {
					bashIde = {
						globPattern = "*@(.sh|.bash)",
					},
				},
				root_dir = vim.loop.cwd,
			})

			-- -- Golang setup
			-- lspconfig["gopls"].setup({
			--     capabilities = capabilities,
			--     settings = {
			--         gopls = {
			--             analyses = {
			--                 unusedparams = true,
			--                 shadow = true,
			--             },
			--             staticcheck = true,
			--         },
			--     },
			-- })

			-- Emmet setup
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					-- "javascript",
					-- "typescript",
					"javascriptreact",
					"typescriptreact",
					-- "vue",
					-- "svelte",
					-- "php",
					-- "markdown",
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true, -- optional: enables BEM-style class expansion
						},
					},
				},
			})

			-- Tailwind CSS setup
			lspconfig["tailwindcss"].setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					-- "javascript",
					-- "javascriptreact",
					-- "typescript",
					-- "typescriptreact",
					-- "svelte",
					-- "vue",
				},
				init_options = {
					userLanguages = {
						rust = "html", -- 🦀 For Tailwind in Rust templates
					},
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "tw`([^`]*)", "tw" }, -- tw`...`
								{ 'tw="([^"]*)', "tw" }, -- tw="..." in JSX
								{ 'tw={"([^"]*)"}', "tw" }, -- tw={"..."} in TSX
							},
						},
					},
				},
			})

			lspconfig["tinymist"].setup({
				capabilities = capabilities,
				settings = {
					formatterMode = "typstyle",
					exportPdf = "onType", -- "onSave", "onType", "never"
					pdfOutputPath = "build",
					compileOnSave = true,
					diagnostics = { enable = true },
				},

				-- These methods and keybindings are not working. Double check them and see what the issue is.
				-- ✅ buffer-local keymaps go here
				-- on_attach = function(client, bufnr)
				-- 	local opts = { buffer = bufnr, noremap = true, silent = true }
				--
				-- 	-- 📌 Pin current buffer
				-- 	vim.keymap.set("n", "<leader>tp", function()
				-- 	    client:exec_cmd({
				-- 	        title = "pin",
				-- 	        command = "tinymist.pinMain",
				-- 	        arguments = { vim.api.nvim_buf_get_name(0) },
				-- 	    })
				-- 	end, vim.tbl_extend("force", opts, { desc = "[T]inymist [P]in" }))
				--
				-- 	-- 🗑️ Unpin
				-- 	vim.keymap.set("n", "<leader>tu", function()
				-- 	    client:exec_cmd({
				-- 	        title = "unpin",
				-- 	        command = "tinymist.pinMain",
				-- 	        arguments = { vim.v.null },
				-- 	    })
				-- 	end, vim.tbl_extend("force", opts, { desc = "[T]inymist [U]npin" }))
				--
				-- 	-- 🌐 Web Preview
				-- 	vim.keymap.set("n", "<leader>tw", function()
				-- 	    vim.cmd("TypstPreviewWeb")
				-- 	    vim.notify("🌐 Web preview launched", vim.log.levels.INFO)
				-- 	end, vim.tbl_extend("force", opts, { desc = "[T]ypst [W]eb Preview" }))
				--
				-- 	-- 📄 PDF Preview in Zathura
				-- 	vim.keymap.set("n", "<leader>tpv", function()
				-- 	    local pdf_path = vim.api.nvim_buf_get_name(0):gsub("%.typ$", ".pdf")
				-- 	    vim.fn.jobstart({ "zathura", pdf_path }, { detach = true })
				-- 	    vim.notify("📄 PDF preview opened in Zathura", vim.log.levels.INFO)
				-- 	end, vim.tbl_extend("force", opts, { desc = "[T]ypst [P]DF Preview" }))
				--
				-- 	-- 📦 Compile with format prompt
				-- 	vim.keymap.set("n", "<leader>tc", function()
				-- 	    local formats = { "pdf", "html", "svg" }
				-- 	    vim.ui.select(formats, {
				-- 	        prompt = "Choose Typst output format:",
				-- 	        format_item = function(item)
				-- 	            return item:upper()
				-- 	        end,
				-- 	    }, function(choice)
				-- 	        if not choice then
				-- 	            return
				-- 	        end
				-- 	        local input_file = vim.api.nvim_buf_get_name(0)
				-- 	        local output_file = input_file:gsub("%.typ$", "." .. choice)
				--
				-- 	        vim.lsp.buf.execute_command({
				-- 	            command = "tinymist.export",
				-- 	            arguments = { input_file, choice, output_file },
				-- 	        })
				--
				-- 	        vim.notify("📦 Compiled → " .. output_file, vim.log.levels.INFO)
				-- 	    end)
				-- 	end, vim.tbl_extend("force", opts, { desc = "[T]ypst [C]ompile with format prompt" }))
				-- end,
			})

			lspconfig["ast_grep"].setup({
				capabilities = capabilities,
				filetypes = { "dart" },
				cmd = { "sg", "lsp" },
			})

			-- -- Solana setup
			-- lspconfig["solang"].setup({
			--     capabilities = capabilities,
			--     settings = {
			--         solang = {
			--             includePaths = { "/usr/local/include" },
			--         },
			--     },
			-- })
			--
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
					null_ls.builtins.formatting.dart_format, -- formatter for dart.
					null_ls.builtins.formatting.sqlfluff.with({
						extra_args = { "--dialect", "postgres" },
					}),

					-- 🐍 Adding Python formatting explicitly
					null_ls.builtins.formatting.yapf.with({
						filetypes = { "python" },
						extra_args = { "--style", "pep8" }, -- optional for faster formatting
					}),

					null_ls.builtins.formatting.typstyle.with({
						extra_args = { "--tab-width", "4" },
					}),

					-- 🐚 Adding ShellCheck diagnostics for Bash
					--     null_ls.builtins.diagnostics.shellcheck.with({
					--         diagnostics_format = "#{m} [#{c}]",
					--         filetypes = { "sh" },
					--     }),
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
					"semgrep",
					"ast_grep",
					"typstyle",
					-- "shellcheck",
				},
				automatic_installation = true,
			})
		end,
	},
}
