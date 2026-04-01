-- lua/config/langstats.lua

-- Only files whose extension appears here will be counted.
-- Everything else (binaries, media, fonts, no-ext files, etc.) is ignored.
local ext_to_lang = {
  -- Systems
  rs    = "Rust",       c     = "C",           cpp   = "C++",
  cc    = "C++",        cxx   = "C++",          h     = "C Header",
  hpp   = "C++ Header", cs    = "C#",           go    = "Go",
  zig   = "Zig",        nim   = "Nim",          v     = "V",
  d     = "D",

  -- Scripting
  py    = "Python",     rb    = "Ruby",         pl    = "Perl",
  php   = "PHP",        lua   = "Lua",          r     = "R",
  jl    = "Julia",      ex    = "Elixir",       exs   = "Elixir",
  erl   = "Erlang",     hrl   = "Erlang",       hs    = "Haskell",
  lhs   = "Haskell",    ml    = "OCaml",        mli   = "OCaml",
  fs    = "F#",         fsx   = "F#",           clj   = "Clojure",
  cljs  = "ClojureScript", scala = "Scala",     kt    = "Kotlin",
  kts   = "Kotlin",     groovy= "Groovy",       swift = "Swift",
  m     = "Objective-C", mm   = "Objective-C++",

  -- Web
  js    = "JavaScript", ts    = "TypeScript",   jsx   = "JSX",
  tsx   = "TSX",        html  = "HTML",         htm   = "HTML",
  css   = "CSS",        scss  = "SCSS",         sass  = "Sass",
  less  = "Less",       vue   = "Vue",          svelte= "Svelte",
  astro = "Astro",

  -- Shell
  sh    = "Shell",      bash  = "Bash",         zsh   = "Zsh",
  fish  = "Fish",       ps1   = "PowerShell",   bat   = "Batch",
  cmd   = "Batch",

  -- Data / Config
  json  = "JSON",       yaml  = "YAML",         yml   = "YAML",
  toml  = "TOML",       xml   = "XML",          csv   = "CSV",
  tsv   = "TSV",        ini   = "INI",          cfg   = "Config",
  conf  = "Config",     env   = "Env",          plist = "Plist",

  -- Markup / Docs
  md    = "Markdown",   mdx   = "MDX",          rst   = "reStructuredText",
  txt   = "Text",       tex   = "LaTeX",        bib   = "BibTeX",
  typ   = "Typst",      org   = "Org",          adoc  = "AsciiDoc",

  -- Build / Infra
  mk    = "Makefile",   cmake = "CMake",        tf    = "Terraform",
  hcl   = "HCL",        nix   = "Nix",          gradle= "Gradle",
  bzl   = "Bazel",

  -- Database
  sql   = "SQL",        graphql = "GraphQL",    gql   = "GraphQL",

  -- Notebook / Scientific
  ipynb = "Jupyter",    f90   = "Fortran",      f95   = "Fortran",
  f03   = "Fortran",    f08   = "Fortran",

  -- Other
  proto = "Protobuf",   sol   = "Solidity",     elm   = "Elm",
  purs  = "PureScript", rkt   = "Racket",       scm   = "Scheme",
  lisp  = "Lisp",       el    = "Emacs Lisp",   vim   = "Vimscript",
  fnl   = "Fennel",     asm   = "Assembly",     s     = "Assembly",
  pas   = "Pascal",     ada   = "Ada",          pyi   = "Python Stub",
  wgsl  = "WGSL",       glsl  = "GLSL",         hlsl  = "HLSL",
}

local excluded_paths = {
  "*/.git/*",
  "*/node_modules/*",
  "*/vendor/*",
  "*/target/*",
  "*/__pycache__/*",
  "*/dist/*",
  "*/build/*",
  "*/.cache/*",
  "*/out/*",
  "*/.venv/*",
  "*/venv/*",
}

local function project_languages()
  local counts = {}
  local total = 0

  local cmd = "find . -type f"
  for _, p in ipairs(excluded_paths) do
    cmd = cmd .. " -not -path '" .. p .. "'"
  end

  local handle = io.popen(cmd)
  if not handle then
    print("LangStats: failed to run find")
    return
  end

  for path in handle:lines() do
    local ext = path:match("%.([^%.]+)$")
    if ext then
      local lang = ext_to_lang[ext:lower()]
      if lang then
        local f = io.open(path, "rb")
        if f then
          local size = f:seek("end")
          f:close()
          if size and size > 0 then
            counts[lang] = (counts[lang] or 0) + size
            total = total + size
          end
        end
      end
    end
  end
  handle:close()

  if total == 0 then
    print("LangStats: no recognized source files found (check :pwd)")
    return
  end

  local results = {}
  for lang, bytes in pairs(counts) do
    table.insert(results, { lang = lang, pct = (bytes / total) * 100 })
  end
  table.sort(results, function(a, b) return a.pct > b.pct end)

  local bar_max = 30
  local top_pct = results[1] and results[1].pct or 100

  print("")
  print(string.format("  cwd: %s", vim.fn.getcwd()))
  print("")
  print(string.format("  %-18s %7s", "Language", "%"))
  print("  " .. string.rep("─", 55))
  for _, r in ipairs(results) do
    if r.pct >= 0.5 then
      local bar_len = math.max(1, math.floor((r.pct / top_pct) * bar_max))
      local bar = string.rep("█", bar_len)
      print(string.format("  %-18s %6.1f%%  %s", r.lang, r.pct, bar))
    end
  end
  print("")
end

vim.api.nvim_create_user_command("LangStats", project_languages, {})

vim.keymap.set("n", "<leader>ll", "<cmd>LangStats<cr>", { desc = "Language stats", silent = true })
