---[Display]---------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = false
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.fillchars = { eob = " " }
vim.opt.winborder = "rounded"

---[Indentation]-----------------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

---[Editing]---------------------------------------------------------------------
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.showmatch = true
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

---[Search]----------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

---[Completion]------------------------------------------------------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.autocomplete = false
vim.opt.pumheight = 10

---[Window Appearance]-----------------------------------------------------------
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.synmaxcol = 300

---[Files and Clipboard]---------------------------------------------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
