--THESE ARE MY AUTO-COMMANDS.
--[[
-- Set default colorscheme
vim.cmd("colorscheme github_dark") -- Default colorscheme

-- Define an autocommand group
vim.api.nvim_create_augroup("ColorSchemeChange", { clear = true })

-- Change colorscheme based on file type
vim.api.nvim_create_autocmd("FileType", {
	group = "ColorSchemeChange",
	pattern = "python",
	callback = function()
		vim.cmd("colorscheme kanagawa") -- Change 'catppuccin' to your preferred Python colorscheme
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "ColorSchemeChange",
	pattern = "javascript",
	callback = function()
		vim.cmd("colorscheme molokai") -- Change 'nord' to your preferred JavaScript colorscheme
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "ColorSchemeChange",
	pattern = "lua",
	callback = function()
		vim.cmd("colorscheme github_dark") -- Change 'kanagawa' to your preferred Lua colorscheme
	end,
})

-- Add more file types as needed

--Lualine was not loading after adding this colourscheme.
--This line calls the setup function to reload lualine.
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		require("lualine").setup()
	end,
})
]]
