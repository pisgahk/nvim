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
g.mapleader = ","

-- Imports
require("core.lazy")       -- lazy.nvim plugin manager
require("core.mappings")   -- Mappings
require("core.settings")   -- Editor settings

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
