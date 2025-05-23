--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- SETUPS

-- Hex color highlighting
require("colorizer").setup()

-- Git signs
require("gitsigns").setup()

-- Lualine status bar
--[[require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "github-theme",
		component_separators = " ",
		section_separators = { left = "", right = "" },
	},
})]]

-- Nvim Autopairs
require("nvim-autopairs").setup()

-- Noice
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},

	cmdline = {
		enabled = true,
		format = {
			default = "classic",
		},
	},

	routes = {
		{
			filter = {
				event = "cmdline",
				kind = "!",
			},
			opts = { skip = true },
		},
	},

	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})

require("notify").setup({
	background_colour = "#000000",
})

--[[require("nvim-cmp").setup({
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
		})
	end,
})]]
