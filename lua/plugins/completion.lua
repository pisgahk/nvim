-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝Completion

-- cooked by P!5g@h
-- cmp core + sources

return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer", -- source for text in buffer.
			"hrsh7th/cmp-path", -- source for file system paths in commands.
			"hrsh7th/cmp-cmdline",
			-- "hrsh7th/vim-vsnip",
			-- "hrsh7th/cmp-vsnip",
			"L3MOND3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- ─[ Icon Styling ]────────────────────────────────────────────────────
			local cmp_kinds = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}

			-- ─[ Visual Highlights ]───────────────────────────────────────────────
			local hl = vim.api.nvim_set_hl
			hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
			hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
			hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
			hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
			hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
			hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
			hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
			hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
			hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
			hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
			--
			-- ─[ CMP Setup ]───────────────────────────────────────────────────────
			cmp.setup({
				completion = { completeopt = "menu,menuone,noselect" },
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif
							vim.fn.col(".") ~= 1
							and vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s") == nil
						then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),

					["<C-e>"] = cmp.mapping.abort(),

					["<leader>ue"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.abort()
						end
						local current = require("cmp.config").get().completion.autocomplete
						if current and #current > 0 then
							cmp.setup({ completion = { autocomplete = false } })
							vim.notify("Autocomplete disabled", vim.log.levels.INFO)
						else
							cmp.setup({
								completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } },
							})
							vim.notify("Autocomplete enabled", vim.log.levels.INFO)
						end
					end, { "n", "i" }),
				},

				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
				}, {
					-- { name = "luasnip" },
					{ name = "buffer" }, -- Text within current buffer
					{ name = "path" }, -- File system paths
					{ name = "spell" },
				}),
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
						return vim_item
					end,
				},
				preselect = cmp.PreselectMode.None,
			})
		end,
	},
}
