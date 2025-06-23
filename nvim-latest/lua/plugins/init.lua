-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

require("plugins.ui")
require("plugins.colourscheme")
require("plugins.lsp")
require("plugins.completion")
require("plugins.snippets")
require("plugins.treesitter")
require("plugins.extras")
require("plugins.git")
require("plugins.telescope")

-- Syncing hover docs with coloursheme.
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd([[
      highlight! link NormalFloat Normal
      highlight! link FloatBorder Normal
      highlight! link Pmenu Normal
      highlight! link PmenuBorder FloatBorder
      highlight! link CmpDocumentationBorder FloatBorder
      highlight! link CmpDocBorder FloatBorder
      highlight! link NoiceCmdlinePopupBorder FloatBorder
      highlight! link NoiceCmdlinePopupTitle Title
      highlight! link NotifyBackground Normal
    ]])
	end,
})
