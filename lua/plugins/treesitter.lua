require("nvim-treesitter").setup()

local ensure_installed = {
  "bash", "c", "cmake", "comment", "css", "diff", "dockerfile", "dot",
  "go", "hjson", "html", "http", "java", "javascript", "latex", "lua",
  "markdown", "markdown_inline", "php", "python", "query", "regex",
  "rust", "scala", "scss", "sql", "toml", "typescript", "typst",
  "vim", "vimdoc", "yaml", "zig",
}

local installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(ensure_installed)
  :filter(function(lang) return not vim.tbl_contains(installed, lang) end)
  :totable()

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

local MAX_FILESIZE = 100 * 1024 -- 100 KB

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok_stat, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok_stat and stats and stats.size > MAX_FILESIZE then
      return -- skip treesitter on huge files, same as your old `disable` function
    end

    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- ─[ Textobjects: select ]────────────────────────────────────────────────
require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
})

