## Here's a comprehensive breakdown of every major `vim.*` API namespace in Neovim:

## Quick reference

| Namespace        | Scope          | What it does                      |
| ---------------- | -------------- | --------------------------------- |
| `vim.opt`        | global/win/buf | Set options with operator support |
| `vim.o`          | global         | Raw option get/set                |
| `vim.wo`         | window         | Window-local options              |
| `vim.bo`         | buffer         | Buffer-local options              |
| `vim.g`          | global         | Global variables                  |
| `vim.b`          | buffer         | Buffer variables                  |
| `vim.w`          | window         | Window variables                  |
| `vim.v`          | built-in       | Vim predefined variables          |
| `vim.env`        | process        | Environment variables             |
| `vim.keymap`     | —              | Key mappings                      |
| `vim.api`        | —              | Core low-level API                |
| `vim.cmd`        | —              | Run Ex commands                   |
| `vim.fn`         | —              | Call Vimscript functions          |
| `vim.diagnostic` | —              | Diagnostic management             |
| `vim.lsp`        | —              | LSP client control                |
| `vim.treesitter` | —              | Treesitter interface              |
| `vim.ui`         | —              | Overridable UI primitives         |
| `vim.notify`     | —              | Notifications                     |
| `vim.schedule`   | —              | Defer to event loop               |
| `vim.uv`         | —              | Async I/O via LibUV               |
| `vim.filetype`   | —              | Filetype detection                |
| `vim.pack`       | —              | Built-in package manager (0.12)   |

## ---[`vim.opt`]------------------------------------------------------------------------------------------------

Sets Neovim options. The Lua-idiomatic replacement for `:set`. Returns option objects that support operators.

```lua
vim.opt.number         = true
vim.opt.tabstop        = 4
vim.opt.clipboard      = "unnamedplus"

-- operator methods for list/set/map options
vim.opt.runtimepath:append("/some/path")
vim.opt.wildignore:prepend("*.o")
vim.opt.shortmess:remove("F")
```

---

## `vim.o`

Same as `vim.opt` but raw — gets/sets global options as plain values without the operator methods. Faster for simple reads.

```lua
vim.o.background = "dark"
vim.o.termguicolors = true
print(vim.o.cmdheight)   -- read a value
```

---

## `vim.wo`

Window-local options. Applies only to the current window.

```lua
vim.wo.wrap           = false
vim.wo.signcolumn     = "yes"
vim.wo.relativenumber = true
```

---

## `vim.bo`

Buffer-local options. Applies only to the current buffer.

```lua
vim.bo.filetype    = "lua"
vim.bo.expandtab   = true
vim.bo.shiftwidth  = 2
```

---

## `vim.g`

Global variables. Equivalent to `let g:variable` in Vimscript. Used heavily for plugin configuration and feature flags.

```lua
vim.g.mapleader        = " "
vim.g.maplocalleader   = "\\"
vim.g.loaded_netrw     = 1       -- disable netrw
vim.g.colors_name      = "muted" -- set by colorschemes
```

---

## `vim.b`

Buffer-local variables. Equivalent to `b:variable`.

```lua
vim.b.gitsigns_head    -- read git branch (set by gitsigns)
vim.b.my_var = "hello" -- set your own
```

---

## `vim.w`

Window-local variables. Equivalent to `w:variable`.

```lua
vim.w.my_window_flag = true
```

---

## `vim.t`

Tab-local variables. Equivalent to `t:variable`.

```lua
vim.t.my_tab_state = {}
```

---

## `vim.v`

Vim's built-in predefined variables. Read-mostly, set by Neovim itself.

```lua
vim.v.count    -- number prefix before a motion (e.g. 3 in "3j")
vim.v.count1   -- same but defaults to 1 instead of 0
vim.v.errmsg   -- last error message
vim.v.version  -- Neovim version number
vim.v.event    -- data from the current autocmd event
```

---

## `vim.env`

Environment variables.

```lua
vim.env.PATH     -- read $PATH
vim.env.MYVAR = "hello"  -- set an env var for the session
```

---

## `vim.keymap`

Sets keymappings. The modern replacement for `vim.api.nvim_set_keymap`.

```lua
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- with a Lua function
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("source $MYVIMRC")
end, { desc = "Reload config", silent = true })

-- delete a mapping
vim.keymap.del("n", "<leader>w")
```

Options you can pass: `silent`, `noremap`, `expr`, `buffer`, `desc`, `nowait`, `remap`.

---

## `vim.api`

The core low-level Neovim API. Everything else is built on top of this. Prefixed with `nvim_`.

```lua
-- buffers
vim.api.nvim_get_current_buf()
vim.api.nvim_buf_get_name(0)
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "line1", "line2" })
vim.api.nvim_buf_get_lines(0, 0, -1, false)

-- windows
vim.api.nvim_get_current_win()
vim.api.nvim_win_set_cursor(0, { 10, 0 })
vim.api.nvim_win_get_cursor(0)

-- highlight groups
vim.api.nvim_set_hl(0, "Normal", { fg = "#d4c9b8", bg = "#1e1d1b" })
vim.api.nvim_get_hl(0, { name = "Normal" })

-- commands
vim.api.nvim_create_user_command("MyCmd", function(opts)
  print(opts.args)
end, { nargs = "*" })

-- autocmds
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = function() print("saved!") end,
})

-- augroups
local group = vim.api.nvim_create_augroup("MyGroup", { clear = true })

-- getting mode
vim.api.nvim_get_mode()  -- returns { mode = "n", blocking = false }

-- echo/notify
vim.api.nvim_echo({ { "hello", "WarningMsg" } }, true, {})
```

---

## `vim.cmd`

Runs Ex commands. Can be called as a function or with dot notation.

```lua
vim.cmd("colorscheme muted")
vim.cmd("set number")
vim.cmd.colorscheme("muted")   -- dot notation (cleaner)
vim.cmd.write()
vim.cmd.bdelete(3)             -- delete buffer 3

-- multiline
vim.cmd([[
  highlight Normal guibg=#1e1d1b
  highlight Comment guifg=#6a6a6a
]])
```

---

## `vim.fn`

Calls any Vimscript function. Huge surface area — anything from the `:h function-list`.

```lua
vim.fn.bufnr("%")          -- current buffer number
vim.fn.expand("%:t")       -- current filename tail
vim.fn.expand("%:p")       -- full path
vim.fn.line(".")           -- current line number
vim.fn.line("$")           -- last line number
vim.fn.col(".")            -- current column
vim.fn.getcwd()            -- current working directory
vim.fn.system("ls")        -- run shell command, return output
vim.fn.executable("rg")    -- check if binary exists, returns 1/0
vim.fn.input("prompt: ")   -- interactive input
vim.fn.has("nvim-0.10")    -- feature check
vim.fn.stdpath("config")   -- ~/.config/nvim
vim.fn.stdpath("data")     -- ~/.local/share/nvim
vim.fn.glob("*.lua")       -- glob pattern
```

---

## `vim.diagnostic`

Manages LSP and other diagnostics.

```lua
vim.diagnostic.get(0)      -- all diagnostics in current buffer
vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
vim.diagnostic.goto_next()
vim.diagnostic.goto_prev()
vim.diagnostic.open_float()   -- show diagnostic in float
vim.diagnostic.setloclist()   -- send to location list

-- configure appearance
vim.diagnostic.config({
  virtual_text  = true,
  signs         = true,
  underline     = true,
  update_in_insert = false,
  float = { border = "rounded" },
})
```

---

## `vim.lsp`

Controls LSP client behaviour.

```lua
vim.lsp.get_clients()                     -- list active clients
vim.lsp.get_clients({ bufnr = 0 })        -- clients for current buffer
vim.lsp.buf.hover()                        -- show hover doc
vim.lsp.buf.definition()                   -- go to definition
vim.lsp.buf.references()                   -- list references
vim.lsp.buf.rename()                       -- rename symbol
vim.lsp.buf.code_action()                  -- code actions
vim.lsp.buf.format({ async = true })       -- format buffer

-- 0.12 new API
vim.lsp.config("lua_ls", { ... })         -- configure a server
vim.lsp.enable("lua_ls")                  -- enable it
```

---

## `vim.treesitter`

Interfaces with Treesitter parsers.

```lua
vim.treesitter.get_parser(0)              -- parser for current buffer
vim.treesitter.get_node()                 -- node under cursor
vim.treesitter.language.get_filetypes("lua")
vim.treesitter.start(0, "lua")            -- start highlighting
vim.treesitter.stop(0)
```

---

## `vim.ui`

Provides overridable UI primitives. Plugins like `dressing.nvim` override these.

```lua
vim.ui.select({ "option1", "option2" }, { prompt = "Pick:" }, function(choice)
  print(choice)
end)

vim.ui.input({ prompt = "Enter name: " }, function(input)
  print(input)
end)
```

---

## `vim.notify`

Shows notifications. Overridable by `nvim-notify` or `noice.nvim`.

```lua
vim.notify("hello")
vim.notify("something went wrong", vim.log.levels.ERROR)
vim.notify("heads up", vim.log.levels.WARN)
vim.notify("info", vim.log.levels.INFO)
```

---

## `vim.schedule` / `vim.defer_fn`

Defers execution — useful for async callbacks.

```lua
-- run on next event loop tick (safe for UI updates from async context)
vim.schedule(function()
  vim.notify("done")
end)

-- run after N milliseconds
vim.defer_fn(function()
  print("delayed")
end, 1000)
```

---

## `vim.loop` / `vim.uv`

LibUV bindings for async I/O, timers, file system. `vim.uv` is the modern name (0.10+).

```lua
-- timer
local timer = vim.uv.new_timer()
timer:start(1000, 0, vim.schedule_wrap(function()
  print("fired after 1s")
end))

-- async file read
vim.uv.fs_read(fd, 1024, 0, function(err, data)
  print(data)
end)
```

---

## `vim.filetype`

File type detection.

```lua
vim.filetype.add({
  extension = { rasi = "rasi" },
  filename  = { [".env"] = "sh" },
  pattern   = { ["*.conf"] = "conf" },
})
```

---

## `vim.pack` _(0.12 new)_

Built-in package manager, new in 0.12.

```lua
vim.pack.add("https://github.com/user/plugin.nvim")
vim.pack.update()
vim.pack.update("user/plugin.nvim")
vim.pack.del("user/plugin.nvim")
```

---
