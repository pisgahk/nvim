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
