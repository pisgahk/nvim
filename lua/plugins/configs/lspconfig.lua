return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap
        
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"dotls",
				"eslint",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"rust_analyzer",
				"sqlls",
				"taplo",
				"ts_ls",
				"yamlls",
				"pyright",
				"gopls",
				"solang", -- Added Python, Golang, Solana support
			},
			automatic_installation = true,
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
					assist = { importMergeBehavior = "last", importPrefix = "by_self" },
					cargo = { allFeatures = true },
					checkOnSave = { command = "clippy" },
					diagnostics = { disabled = { "unresolved-proc-macro" } },
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

		-- Web development setup
		lspconfig["html"].setup({ capabilities = capabilities })
		lspconfig["cssls"].setup({ capabilities = capabilities })
		lspconfig["ts_ls"].setup({ capabilities = capabilities })
		lspconfig["jsonls"].setup({ capabilities = capabilities })
		lspconfig["eslint"].setup({ capabilities = capabilities })
	end,
}
