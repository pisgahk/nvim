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

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- UTF8 encoding
vim.opt.encoding = "UTF-8"

-- Enabling clipboard
vim.opt.clipboard = "unnamedplus"

-- Persistent undo
vim.opt.undofile = true

-- Line numbers
vim.opt.number = true

-- Relative line numbers
vim.opt.relativenumber = true

-- Horizontal cursor line
vim.opt.cursorline = true

-- Vertical cursor line
vim.opt.cursorcolumn = false

-- Shift width
vim.opt.shiftwidth = 4

-- Tab width
vim.opt.tabstop = 4

-- Space characters instead of tabs
vim.opt.expandtab = true

-- Disable backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

-- Do not let cursor scroll below or above N number of lines when scrolling
vim.opt.scrolloff = 10

-- Wrap lines
vim.opt.wrap = true

-- Preserve indentation of virtual line
vim.opt.breakindent = true

-- Search highlighting
vim.opt.hlsearch = false

-- Incrementally highlight matching characters while typing
vim.opt.incsearch = true

-- Ignoring capital letters during search
vim.opt.ignorecase = true

-- Overriding ignorecase vim.option if searching for capital letters
vim.opt.smartcase = true

-- Showing matching words during search
vim.opt.showmatch = true

-- Showing partial command on last line
vim.opt.showcmd = true

-- Showing mode on last line
vim.opt.showmode = false

-- Command history
vim.opt.history = 1000

-- Auto completion menu after pressing TAB
vim.opt.wildmenu = true

-- Bash-like completion
vim.opt.wildmode = "list:full"

-- Ignoring files with certain extensions
--vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Command completion in popup menu
vim.opt.wildoptions = "pum"
--vim.opt.pumblend = 7   -- Make popup translucent
vim.opt.pumheight = 20 -- Max amount of items

-- Mouse support
vim.opt.mouse = "a"

-- Hide End-Of-Buffer symbol (~)
vim.opt.fillchars:append({ eob = " " })

-- Settings for line highlighting
vim.opt.list = true

-- Settings for cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Opening new split panes to right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Disable netrw (native VIM file explorer)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- GUI settings
vim.opt.guifont = { "FiraCode Nerd Font", ":h14" }

-- Disabling providers (if downloaded Neovim from one of this providers don't delete!)
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0
