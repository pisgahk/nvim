-- lua/config/langstats_term.lua
-- Language stats rendered inside a Neovim :terminal split.
-- Uses ANSI escape codes — no floating window, no extmarks, no UTF-8 offset math.
-- Map: <leader>lf

local ext_to_lang = {
	-- Systems
	rs = "Rust",
	c = "C",
	cpp = "C++",
	cc = "C++",
	cxx = "C++",
	h = "C Header",
	hpp = "C++ Header",
	cs = "C#",
	go = "Go",
	zig = "Zig",
	nim = "Nim",
	v = "V",
	d = "D",
	-- Scripting
	py = "Python",
	rb = "Ruby",
	pl = "Perl",
	php = "PHP",
	lua = "Lua",
	r = "R",
	jl = "Julia",
	ex = "Elixir",
	exs = "Elixir",
	erl = "Erlang",
	hrl = "Erlang",
	hs = "Haskell",
	lhs = "Haskell",
	ml = "OCaml",
	mli = "OCaml",
	fs = "F#",
	fsx = "F#",
	clj = "Clojure",
	cljs = "ClojureScript",
	scala = "Scala",
	kt = "Kotlin",
	kts = "Kotlin",
	groovy = "Groovy",
	swift = "Swift",
	m = "Objective-C",
	mm = "Objective-C++",
	-- Web
	js = "JavaScript",
	ts = "TypeScript",
	jsx = "JSX",
	tsx = "TSX",
	html = "HTML",
	htm = "HTML",
	css = "CSS",
	scss = "SCSS",
	sass = "Sass",
	less = "Less",
	vue = "Vue",
	svelte = "Svelte",
	astro = "Astro",
	-- Shell
	sh = "Shell",
	bash = "Bash",
	zsh = "Zsh",
	fish = "Fish",
	ps1 = "PowerShell",
	bat = "Batch",
	cmd = "Batch",
	-- Data / Config
	json = "JSON",
	yaml = "YAML",
	yml = "YAML",
	toml = "TOML",
	xml = "XML",
	csv = "CSV",
	tsv = "TSV",
	ini = "INI",
	cfg = "Config",
	conf = "Config",
	env = "Env",
	plist = "Plist",
	-- Markup / Docs
	md = "Markdown",
	mdx = "MDX",
	rst = "reStructuredText",
	txt = "Text",
	tex = "LaTeX",
	bib = "BibTeX",
	typ = "Typst",
	org = "Org",
	adoc = "AsciiDoc",
	-- Build / Infra
	mk = "Makefile",
	cmake = "CMake",
	tf = "Terraform",
	hcl = "HCL",
	nix = "Nix",
	gradle = "Gradle",
	bzl = "Bazel",
	-- Database
	sql = "SQL",
	graphql = "GraphQL",
	gql = "GraphQL",
	-- Notebook / Scientific
	ipynb = "Jupyter",
	f90 = "Fortran",
	f95 = "Fortran",
	f03 = "Fortran",
	f08 = "Fortran",
	-- Other
	proto = "Protobuf",
	sol = "Solidity",
	elm = "Elm",
	purs = "PureScript",
	rkt = "Racket",
	scm = "Scheme",
	lisp = "Lisp",
	el = "Emacs Lisp",
	vim = "Vimscript",
	fnl = "Fennel",
	asm = "Assembly",
	s = "Assembly",
	pas = "Pascal",
	ada = "Ada",
	pyi = "Python Stub",
	wgsl = "WGSL",
	glsl = "GLSL",
	hlsl = "HLSL",
}

local excluded_paths = {
	"*/.git/*",
	"*/node_modules/*",
	"*/vendor/*",
	"*/target/*",
	"*/__pycache__/*",
	"*/dist/*",
	"*/build/*",
	"*/dist-packages/*",
	"*/.cache/*",
	"*/out/*",
	"*/.venv/*",
	"*/venv/*",
}

-- 16 ANSI 256-colour codes that map visually to the floating-window palette.
-- Each entry is an xterm-256 colour index used as foreground via \27[38;5;Xm
local palette_256 = {
	75, -- blue       (#61afef approx)
	203, -- red        (#e06c75 approx)
	114, -- green      (#98c379 approx)
	221, -- yellow     (#e5c07b approx)
	176, -- purple     (#c678dd approx)
	73, -- cyan       (#56b6c2 approx)
	173, -- orange     (#d19a66 approx)
	131, -- dark red   (#be5046 approx)
	63, -- bright blue(#528bff approx)
	148, -- lime       (#9ec400 approx)
	214, -- amber      (#fd971f approx)
	197, -- pink       (#f92672 approx)
	154, -- bright grn (#a6e22e approx)
	87, -- sky        (#66d9e8 approx)
	208, -- amber2     (#fd971f approx)
	141, -- lavender   (#ae81ff approx)
}

local RESET = "\27[0m"
local BOLD = "\27[1m"
local DIM = "\27[2m"

local function ansi_fg(idx)
	-- idx is 1-based into palette_256
	local code = palette_256[((idx - 1) % #palette_256) + 1]
	return string.format("\27[38;5;%dm", code)
end

-- ── Data collection (identical logic to langstats_bar) ───────────────────────

local function collect_stats()
	local counts = {}
	local total = 0
	local cmd = "find . -type f"
	for _, p in ipairs(excluded_paths) do
		cmd = cmd .. " -not -path '" .. p .. "'"
	end
	local handle = io.popen(cmd)
	if not handle then
		return nil, nil
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
		return nil, nil
	end
	local results = {}
	for lang, bytes in pairs(counts) do
		table.insert(results, { lang = lang, pct = (bytes / total) * 100 })
	end
	table.sort(results, function(a, b)
		return a.pct > b.pct
	end)
	local filtered = {}
	for _, r in ipairs(results) do
		if r.pct >= 0.5 then
			table.insert(filtered, r)
		end
	end
	return filtered, total
end

-- ── ANSI rendering helpers ────────────────────────────────────────────────────

local BAR_WIDTH = 60

local function render_bar(results)
	local out = {}
	local assigned = 0
	local n = #results
	for i, r in ipairs(results) do
		local cells
		if i == n then
			cells = BAR_WIDTH - assigned
		else
			cells = math.max(1, math.floor((r.pct / 100) * BAR_WIDTH))
		end
		assigned = assigned + cells
		if assigned > BAR_WIDTH then
			cells = cells - (assigned - BAR_WIDTH)
			assigned = BAR_WIDTH
		end
		if cells > 0 then
			table.insert(out, ansi_fg(i) .. BOLD .. string.rep("█", cells) .. RESET)
		end
	end
	return table.concat(out)
end

local function render_stat_table(results)
	local lines = {}
	table.insert(lines, string.format("  %s%-20s%s %s%7s%s", BOLD, "Language", RESET, BOLD, "%", RESET))
	table.insert(lines, "  " .. string.rep("─", 30))
	for i, r in ipairs(results) do
		table.insert(
			lines,
			string.format("  %s%-20s%s %s%6.1f%%%s", ansi_fg(i) .. BOLD, r.lang, RESET, DIM, r.pct, RESET)
		)
	end
	return lines
end

-- Lay legend out in columns; each cell = "● Name  XX.X%"
local function render_legend(results, term_width)
	local cell_w = 0
	for _, r in ipairs(results) do
		local w = 2 + #r.lang + 2 + 6 -- "● " + name + "  " + "XX.X%"
		if w > cell_w then
			cell_w = w
		end
	end
	cell_w = cell_w + 2 -- gutter
	local cols = math.max(1, math.floor((term_width - 4) / cell_w))

	local lines = {}
	local row_buf = {}
	for i, r in ipairs(results) do
		local fmt = string.format("%-" .. (cell_w - 9) .. "s", r.lang)
		local cell = ansi_fg(i) .. BOLD .. "●" .. RESET .. string.format(" %s %s%5.1f%%%s", fmt, DIM, r.pct, RESET)
		table.insert(row_buf, cell)
		if #row_buf == cols or i == #results then
			table.insert(lines, "  " .. table.concat(row_buf, "  "))
			row_buf = {}
		end
	end
	return lines
end

-- ── Script builder ────────────────────────────────────────────────────────────
-- We write a small shell script to a temp file, then open it in :terminal.
-- The script just cats pre-rendered ANSI output, then waits for a keypress.

local function build_script(results, cwd)
	local term_width = vim.o.columns - 4
	local lines = {}

	local function push(s)
		table.insert(lines, s)
	end

	-- Header
	push("")
	push(string.format("  %s%s Language Stats %s", BOLD, "󰈙 ", RESET))
	push(string.format("  %scwd: %s%s", DIM, cwd, RESET))
	push("")

	-- Bar
	push("  " .. render_bar(results))
	push("")

	-- Stat table
	for _, l in ipairs(render_stat_table(results)) do
		push(l)
	end
	push("")

	-- Legend header
	push(string.format("  %sLegend%s", BOLD, RESET))
	push("  " .. string.rep("─", 28))
	for _, l in ipairs(render_legend(results, term_width)) do
		push(l)
	end
	push("")
	push(string.format("  %sPress any key to close…%s", DIM, RESET))

	-- Escape each line for printf/echo safety by using a heredoc in the script
	local body = table.concat(lines, "\n")

	-- Write the body to a temp file, script just cats it then reads one key
	local tmp_body = os.tmpname()
	local tmp_script = os.tmpname() .. ".sh"

	local bf = io.open(tmp_body, "w")
	if not bf then
		return nil, nil
	end
	bf:write(body)
	bf:close()

	local sf = io.open(tmp_script, "w")
	if not sf then
		return nil, nil
	end
	sf:write(string.format(
		[[#!/usr/bin/env sh
cat '%s'
old=$(stty -g 2>/dev/null)
stty -icanon min 1 time 0 2>/dev/null
dd bs=1 count=1 2>/dev/null
stty "$old" 2>/dev/null
rm -f '%s' '%s'
]],
		tmp_body,
		tmp_body,
		tmp_script
	))
	sf:close()
	os.execute("chmod +x " .. tmp_script)

	return tmp_script
end

-- ── Entry point ───────────────────────────────────────────────────────────────

local function lang_stats_term()
	local results, _ = collect_stats()
	if not results then
		vim.notify("LangStats: no recognised source files found (check :pwd)", vim.log.levels.WARN)
		return
	end

	local cwd = vim.fn.getcwd()
	local script = build_script(results, cwd)
	if not script then
		vim.notify("LangStats: failed to write temp script", vim.log.levels.ERROR)
		return
	end

	-- Open a horizontal split terminal at the bottom, sized to content.
	-- Estimate height: 2(header) + 2(bar) + #results + 4(legend rows approx) + 6(chrome)
	local height = math.min(#results + 14, math.floor(vim.o.lines * 0.6))
	vim.cmd(string.format("botright %dnew", height))
	local buf = vim.api.nvim_get_current_buf()
	vim.fn.termopen(script, {
		on_exit = function()
			-- Close the terminal buffer automatically when the script exits.
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end)
		end,
	})
	vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("LangStatsTerm", lang_stats_term, {})
vim.keymap.set("n", "<leader>lf", "<cmd>LangStatsTerm<cr>", { desc = "Language stats (terminal)", silent = true })
