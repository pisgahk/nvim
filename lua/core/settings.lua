--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- SETTINGS

-- settings.lua

-------------------------------
-- 🖼 Visual & UI Settings
-------------------------------

vim.opt.termguicolors = true                       -- Enable true color support
vim.opt.cursorline = true                          -- Highlight the current cursor line
vim.opt.cursorcolumn = false                       -- Disable vertical cursor line
vim.opt.signcolumn = "yes"                         -- Always show the sign column
vim.opt.wrap = true                                -- Enable line wrapping
vim.opt.breakindent = true                         -- Preserve indentation for wrapped lines
vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor
vim.opt.guifont = { "FiraCode Nerd Font", ":h14" } -- Set GUI font

vim.opt.list = true                                -- Show hidden characters
vim.opt.fillchars:append({ eob = " " })            -- Replace End-of-Buffer (~) with blank

-------------------------------
-- 🧠 Encoding, Clipboard, Undo
-------------------------------

vim.opt.encoding = "UTF-8"        -- Set encoding to UTF-8
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.undofile = true           -- Enable persistent undo

-------------------------------
-- 🔢 Line Numbers & Columns
-------------------------------

vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-------------------------------
-- 📝 Tabs & Indentation
-------------------------------

vim.opt.shiftwidth = 4   -- Number of spaces for indentation
vim.opt.tabstop = 4      -- Number of spaces a tab counts for
vim.opt.expandtab = true -- Use spaces instead of tabs

-------------------------------
-- 🔍 Searching
-------------------------------

vim.opt.hlsearch = true   -- Highlight search matches
vim.opt.incsearch = true  -- Incremental search
vim.opt.ignorecase = true -- Ignore case unless capital letters used
vim.opt.smartcase = true  -- Override ignorecase if capital used
vim.opt.showmatch = true  -- Highlight matching parentheses

-------------------------------
-- 💬 Command Line Behavior
-------------------------------

vim.opt.showcmd = true   -- Show incomplete commands
vim.opt.showmode = false -- Don't show current mode
vim.opt.history = 1000   -- Set command history limit

-------------------------------
-- 🌐 Completion Settings
-------------------------------

vim.opt.wildmenu = true        -- Enable command-line completion menu
vim.opt.wildmode = "list:full" -- Bash-style completion
vim.opt.wildoptions = "pum"    -- Use popup menu for completion
vim.opt.pumheight = 20         -- Limit completion item height

-------------------------------
-- 🖱 Mouse & Spell
-------------------------------

vim.opt.mouse = "a"             -- Enable mouse in all modes
vim.opt.spell = true            -- Enable spell checking
vim.opt.spelllang = { "en_us" } -- Set spell language

-------------------------------
-- 📐 Splits Behavior
-------------------------------

vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-------------------------------
-- 🚫 Disabling Built-ins
-------------------------------

vim.g.loaded_netrw = 1            -- Disable netrw
vim.g.loaded_netrwPlugin = 1      -- Disable netrw plugin

vim.g.loaded_python3_provider = 0 -- Disable Python 3 provider
vim.g.loaded_ruby_provider = 0    -- Disable Ruby provider
vim.g.loaded_perl_provider = 0    -- Disable Perl provider
vim.g.loaded_node_provider = 0    -- Disable Node.js provider

-------------------------------
-- 🛡 Backup Settings
-------------------------------

vim.opt.backup = false      -- Disable backup files
vim.opt.writebackup = false -- Disable write-backup files
