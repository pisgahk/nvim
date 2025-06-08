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
					terminal_colors = false,
					styles = {
						comments = "italic",
						--variables = "bold",
					},
				},
			})

			vim.cmd("colorscheme github_dark")
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	--Colourschemes
	"catppuccin/nvim",
	"UtkarshVerma/molokai.nvim",
	"akinsho/horizon.nvim",
	"briones-gabriel/darcula-solid.nvim",
	"rebelot/kanagawa.nvim",
	"shaunsingh/nord.nvim",

	{
		"nvim-lualine/lualine.nvim", -- Status line
		dependencies = { "nvim-tree/nvim-web-devicons" },

		--[[options = {
			icons_enabled = true,
			theme = "github-theme",
			component_separators = " ",
			section_separators = { left = "", right = "" },
		},]]

		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "horizon",
					component_separators = " ",
					section_separators = { left = "", right = "" },
				},
			})
		end,
	},

	-------- Neovim Tools
	require("plugins.configs.snacks"), -- Collection of QoL plugins
	require("plugins.configs.which-key"), -- Show keymaps
	"mbbill/undotree", -- Undo tree

	{
		"nvim-treesitter/nvim-treesitter", -- Treesitter
		build = ":TSUpdate html",
	},
	{
		"hrsh7th/nvim-cmp", -- Auto completion

		lazy = false,
		--event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", --
			"hrsh7th/cmp-buffer", -- source for text in buffer.
			"hrsh7th/cmp-path", -- source for file system paths in  commands.
			--"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip", -- snippet engine.
			"saadparwaiz1/cmp_luasnip", -- for lua autocompletion.
			"rafamadriz/friendly-snippets", --useful snippets library.

			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"onsails/lspkind.nvim", -- vs-code like pictograms.
		},

		--[[config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- loads vscode style snippets from installed plugins (e.g friendly-snippets)
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = { --configure how nvim-cmp interacts with snippets engine.
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), --previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions.
					["<C-e>"] = cmp.mapping.abort(), -- close completion window
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),

				--sources for auto-completion.
				{ name = "nvim-lsp" },
				{ name = "buffer" }, -- text within current buffer.
				{ name = "path" }, --file system paths.
                { name = "luasnip" }, --snippets

			})

			--configure lspkind for vscode like pictograms in completion menu.
			--formatting = {
			--	format = lspkind.cmp_format({
			--		maxwidth = 50,
			--		ellipsis_char = "...",
			--	}),
			--}
		end,]]
	},

	------- LSP
	--"williamboman/mason.nvim", -- LSP packet manager
	--"williamboman/mason-lspconfig.nvim", -- lspconfig integration
	--

	{
		--"neovim/nvim-lspconfig", -- LSP configuration
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Rust LSP
			require("lspconfig").rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
					},
				},
			})

			-- Enable other language servers
			require("lspconfig").pyright.setup({}) -- Python
			require("lspconfig").tsserver.setup({}) -- JavaScript/TypeScript
			require("lspconfig").gopls.setup({}) -- Go
		end,
	},

	------- Editing
	"stevearc/conform.nvim", -- Formatter
	"lewis6991/gitsigns.nvim", -- Git signs

	{
		"windwp/nvim-autopairs", -- Auto closing brackets, parenthesis etc.
		lazy = false,
		event = "InsertEnter",
		config = true,
	},

	"norcalli/nvim-colorizer.lua", -- Hex color highlighting
	"hiphish/rainbow-delimiters.nvim", -- Brackets, parenthesis colorizer

	--add some error lens.
	--[[{
		"chikko80/error-lens.nvim",
		event = "BufRead",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			enabled = false,
			prefix = 4,
			--[[colors = {
				error_fg = "#FF6363",
				warn_fg = "#FA973A",
				info_fg = "#5B38E8",
				hint_fg = "#25E64B",
			},]]

	--opts = {
	-- your options go here
	--},]]

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_rename = true,
				},
			})
		end,
	},

	{
		"folke/trouble.nvim",
		lazy = false,
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or, branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--other plugins
	"simrat39/rust-tools.nvim", -- Rust tools
	{
		"brianhuster/live-preview.nvim",
	},

	{
		"isakbm/gitgraph.nvim",
		opts = {
			git_cmd = "git",
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gx",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},
}
