-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

--- Variables
opt = vim.opt
g = vim.g
kmap = vim.keymap
cmd = vim.cmd

-- Leader key
g.mapleader = ","

-- Imports
require("core.lazy") -- lazy.nvim plugin manager
require("core.mappings") -- Mappings
--require("core.scripts") -- Scripts
require("core.settings") -- Editor settings

--require("plugins.configs") -- All setups and configurations
require("plugins") -- Loads `Plugins/init.lua` and cascades.
--require("plugins.setups") -- Setup of plugins
--require("plugins.autocmds") -- Includes all my custom auto-commands.- Variables
--
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				-- Snacks.explorer() -- ⛔ Original Snacks explorer
				vim.cmd("Neotree toggle")
			end,
			desc = "File Explorer",
		},
	},
	opts = {
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
		window = {
			width = 30,
			mappings = {
				["<space>"] = "toggle_node",
				["o"] = "open",
			},
		},
	},
}
