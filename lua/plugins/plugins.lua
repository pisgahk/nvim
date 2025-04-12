--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- PLUGINS

return {
	-------- Appearance
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
					dim_inactive = false,
				},
			})

			vim.cmd("colorscheme github_dark")
		end,
	},
	{
		"morhetz/gruvbox",
		"folke/tokyonight.nvim",
		"sainnhe/everforest",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
                ██████╗ ██╗███████╗ ██████╗  █████╗ ██╗  ██╗   ██████╗ ███████╗██╗   ██╗
                ██╔══██╗██║██╔════╝██╔════╝ ██╔══██╗██║  ██║   ██╔══██╗██╔════╝██║   ██║
                ██████╔╝██║███████╗██║  ███╗███████║███████║   ██║  ██║█████╗  ██║   ██║
                ██╔═══╝ ██║╚════██║██║   ██║██╔══██║██╔══██║   ██║  ██║██╔══╝  ╚██╗ ██╔╝
                ██║     ██║███████║╚██████╔╝██║  ██║██║  ██║██╗██████╔╝███████╗ ╚████╔╝
                ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝  ╚═══╝
                ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
	"nvim-lualine/lualine.nvim", -- Status line

	-------- Neovim Tools
	require("plugins.configs.snacks"), -- Collection of QoL plugins
	require("plugins.configs.which-key"), -- Show keymaps
	"mbbill/undotree", -- Undo tree

	{
		"nvim-treesitter/nvim-treesitter", -- Treesitter
		build = ":TSUpdate",
	},
	{
		"hrsh7th/nvim-cmp", -- Auto completion
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
	},
	------- LSP
	"williamboman/mason.nvim", -- LSP packet manager
	"williamboman/mason-lspconfig.nvim", -- lspconfig integration
	"neovim/nvim-lspconfig", -- LSP configuration

	------- Editing
	"stevearc/conform.nvim", -- Formatter
	"lewis6991/gitsigns.nvim", -- Git signs
	"windwp/nvim-autopairs", -- Auto closing brackets, parenthesis etc.
	"norcalli/nvim-colorizer.lua", -- Hex color highlighting
	"hiphish/rainbow-delimiters.nvim", -- Brackets, parenthesis colorizer

	--others
	"simrat39/rust-tools.nvim", -- Rust tools
	"saadparwaiz1/cmp_luasnip", -- Snippet support
	"L3MON4D3/LuaSnip", --Snippet Engine

	--[[{
		"nvim-telescope/telescope.nvim",
		--tag = '0.1.8', -- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},]]

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 10000,
		},
	},

	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate", -- if you have `nvim-treesitter` installed
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
		},
	},
}
