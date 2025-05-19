return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Import Mason
		local mason = require("mason")

		-- Import Mason-LSPConfig
		local mason_lspconfig = require("mason-lspconfig")

		-- Import Mason Tool Installer
		local mason_tool_installer = require("mason-tool-installer")

		-- Enable Mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Configure Mason-LSPConfig
		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls", -- ✅ Fixed TypeScript LSP name
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"solang",
			},
			automatic_installation = true, -- ✅ Added auto-installation for LSPs
		})

		-- Configure Mason Tool Installer
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- Formatter for JavaScript/TypeScript
				"stylua", -- Lua formatter
				"isort", -- Python formatter
				"black", -- Python formatter
				"pylint", -- Python linter
				"ruff", -- ✅ Added Python linter
				"eslint_d", -- JavaScript/TypeScript linter
			},
		})
	end,
}
