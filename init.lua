--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- INIT FILE

-- Variables
opt = vim.opt
g = vim.g
kmap = vim.keymap
cmd = vim.cmd

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--vim.opt.cmdheight = 1

-- Leader key
vim.g.mapleader = ","

vim.opt.runtimepath:prepend(vim.fn.expand("~/muted.nvim"))
vim.cmd.colorscheme("muted_fire")

-- Imports
require("core.lazy") -- lazy.nvim plugin manager
require("core.mappings") -- Mappings
require("core.settings") -- Editor settings
-- require("core.colour") -- The Vmichael colourscheme.
-- require("core.vmichael")
require("core.langstats")
require("core.langstats_bar")
require("core.langstats_term")
require("plugins.plugins") -- Plugins

-- For the new config: 12.02.2026
-- I need to use `opts` instead of `config` for plugins(specs as folke likes to call it.) Check out: `https://lazy.folke.io/spec`
--
-- This is good:
-- { "folke/todo-comments.nvim", opts = {} },
--
-- This is bad:
--     {
--   "folke/todo-comments.nvim",
--   config = function()
--     require("todo-comments").setup({})
--   end,
-- },
--
-- Always use `opts` instead of `config` whenever possible, `config` is almost never needed.
-- small trigger to see if the nvim syncing wala workflow will work.

-- Let me also add this trigger just to see if it will make
-- a PR in the nvim config file.
-- This is really cool stuff.
-- Because there are actual teams of people that do this and being able to do it efficiently and safely
-- is quite good.
-- how about now what can i do here. some random text to see if this workflow works.
-- :wqa
-- Let me try to make changes to my nvim config file.
--

-- Suppress the default write message and replace with human-readable size
--
-- This avoids the:
-- "~/dev/tests/test.rs" 68L, 1895B written
--
-- to:
-- "~/dev/tests/test.rs" 68L, 1.9 KB written
--
-- And for anything larger it'll show 0.48 MB, 2.31 MB, etc.
-- The KB fallback is there because most of your files will never actually hit MB(depends on your kinda work) — it's more honest than forcing everything into MB (a 400B file showing 0.00 MB would be useless).

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		local path = vim.fn.expand("%:p")
		local size = vim.fn.getfsize(path)
		local formatted

		if size < 0 then
			formatted = "unknown size"
		elseif size < 1024 * 1024 then
			formatted = string.format("%.2f KB", size / 1024)
		elseif size < 1024 * 1024 * 1024 then
			formatted = string.format("%.2f MB", size / (1024 * 1024))
		else
			formatted = string.format("%.2f GB", size / (1024 * 1024 * 1024))
		end

		local lines = vim.fn.line("$")
		local rel = vim.fn.expand("%:~")

		vim.defer_fn(function()
			vim.api.nvim_echo(
				{ { string.format('"%s"  %dL  %s written', rel, lines, formatted), "Normal" } },
				false,
				{}
			)
		end, 1)
	end,
})
