return {
	require("plugins.configs.conform"), -- Formatter
	require("plugins.configs.lsp"), -- LSP setup
	require("plugins.configs.mason"), -- Mason LSP & DAP servers
	require("plugins.configs.nvim-cmp"), -- Autocompletion
	require("plugins.configs.treesitter"), -- Treesitter syntax highlighting
	require("plugins.configs.lspconfig"), -- for the actual lsp setup.
	-- require("plugins.configs.luasnip") -- for luasnip snippets.
	--require("plugins.configs.gitgraph"), -- Adds the visual Graph for git.
}
