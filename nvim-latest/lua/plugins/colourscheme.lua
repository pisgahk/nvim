-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Colourschemes.

-- cooked by Pisgah.
-- Includes Colour-schemes.

return {

	-- Main colour-scheme: Github-theme
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

	-- Other Colourschemes
	"catppuccin/nvim",
	"UtkarshVerma/molokai.nvim",
	"akinsho/horizon.nvim",
	"briones-gabriel/darcula-solid.nvim",
	"rebelot/kanagawa.nvim",
	"shaunsingh/nord.nvim",
	"Mofiqul/vscode.nvim",
	"ntk148v/habamax.nvim",
	"ellisonleao/gruvbox.nvim",

	{
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup({
				background = "medium", -- Options: "soft", "medium", "hard"
				transparent_background_level = 2, -- 0 (no transparency), 1 (some transparency), 2 (full transparency)
				italics = true, -- Enable italics for better aesthetics
			})
		end,
	},

	{
		"EdenEast/nightfox.nvim", -- Comma added here
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					terminal_colors = true,
					dim_inactive = false, -- Fixed spacing issue
				},
			})
		end,
	},

	{
		"folke/styler.nvim",
		config = function()
			require("styler").setup({
				themes = {
					rust = { colorscheme = "github_dark" },
					python = { colorscheme = "gruvbox" },
					html = { colorscheme = "vscode" },
					bash = { colorscheme = "everforest" },
					--sh = { colorscheme = "habamax" },
					lua = { colorscheme = "github_dark_dimmed" },
					markdown = { colorscheme = "molokai" },
					javascript = { colorscheme = "nightfox" },
					solana = { colorscheme = "everforest" },
					help = { colorscheme = "catppuccin-mocha", background = "dark" },
				},
			})
		end,
	},
}
