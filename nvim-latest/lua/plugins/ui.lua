-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝UI.

-- cooked by Pisgah.
-- Lualine, Notify, Noice.

return {

	-- 🔳 Status Line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"akinsho/horizon.nvim",
		},
		config = function()
			local function set_lualine_highlights()
				local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
				local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })

				local bg = normal.bg and string.format("#%06x", normal.bg) or "#1e1e2e"
				local fg = comment.fg and string.format("#%06x", comment.fg) or "#7aa2f7"

				vim.api.nvim_set_hl(0, "LualineSeparator", { fg = fg, bg = bg })
				vim.api.nvim_set_hl(0, "LualineComponent", { fg = bg, bg = fg })
			end

			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_lualine_highlights })
			set_lualine_highlights()

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "horizon",
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "" },
							right_padding = 2,
							color = "LualineComponent",
						},
					},
					lualine_b = { "branch" },
					lualine_c = { "filename" },
					lualine_x = { "diagnostics", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						{
							"location",
							separator = { right = "" },
							left_padding = 2,
							color = "LualineComponent",
						},
					},
				},
			})
		end,
	},

	-- 🔔 Notification UI
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 3000,
				background_colour = "#1e1e2e",
				render = "compact",
				minimum_width = 50,
				icons = {
					ERROR = " ",
					WARN = " ",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})
			vim.notify = require("notify")
			require("telescope").load_extension("notify")
		end,
	},

	-- 💬 Noice: Better Messages, Hover, and Cmd UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				cmdline = {
					enabled = true,
					format = { default = "classic" },
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
					bottom_search = false,
					command_palette = false,
					long_message_to_split = true,
					lsp_doc_border = true,
				},

				keys = {
					{
						"<leader>n",
						function()
							require("noice").cmd("history")
						end,
						desc = "Notification History",
					},
				},
			})
		end,
	},

	-- 🌟 Icon Layer
	{
		"mskelton/termicons.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("termicons").setup()
		end,
	},

	-- 🗂️ Neo-tree File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
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
	},

	-- 🧮 Alpha Dashboard

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- 🚩 Custom ASCII Header
			dashboard.section.header.val = {
				"██████╗ ██╗███████╗ ██████╗  █████╗ ██╗  ██╗   ██████╗ ███████╗██╗   ██╗",
				"██╔══██╗██║██╔════╝██╔════╝ ██╔══██╗██║  ██║   ██╔══██╗██╔════╝██║   ██║",
				"██████╔╝██║███████╗██║  ███╗███████║███████║   ██║  ██║█████╗  ██║   ██║",
				"██╔═══╝ ╚═╝╚════██║██║   ██║██╔══██║██╔══██║   ██║  ██║██╔══╝  ╚██╗ ██╔╝",
				"██║     ██╗███████║╚██████╔╝██║  ██║██║  ██║██╗██████╔╝███████╗ ╚████╔╝ ",
				"╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝  ╚═══╝  ",
			}

			-- 🧩 Dashboard Buttons
			dashboard.section.buttons.val = {
				dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
				dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("g", "󰱼  Live Grep", ":Telescope live_grep<CR>"),
				dashboard.button("c", "  Config", ":Telescope find_files cwd=~/.config/nvim/<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			-- 🔢 Loaded Plugins Count Footer
			local function footer()
				local stats = require("lazy").stats()
				return string.format(
					"󰚰 %d/%d plugins loaded • Stay sharp. Stay fast. ⚡",
					stats.loaded,
					stats.count
				)
			end

			dashboard.section.footer.val = footer()
			dashboard.opts.opts.noautocmd = true

			alpha.setup(dashboard.opts)

			-- 🎨 Red-themed highlights
			vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ff5f5f" }) -- light red
			vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#ff3030" }) -- medium red
			vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#cc0000" }) -- deep red
		end,
	},
}
