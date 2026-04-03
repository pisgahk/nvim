-- lua/config/langstats_bar.lua
-- Coloured single-bar language stats with floating window + legend.
-- Map: <leader>lL

-- local ext_to_lang = {
-- 	-- Systems
-- 	rs = "Rust",
-- 	c = "C",
-- 	cpp = "C++",
-- 	cc = "C++",
-- 	cxx = "C++",
-- 	h = "C Header",
-- 	hpp = "C++ Header",
-- 	cs = "C#",
-- 	go = "Go",
-- 	zig = "Zig",
-- 	nim = "Nim",
-- 	v = "V",
-- 	d = "D",
-- 	-- Scripting
-- 	py = "Python",
-- 	rb = "Ruby",
-- 	pl = "Perl",
-- 	php = "PHP",
-- 	lua = "Lua",
-- 	r = "R",
-- 	jl = "Julia",
-- 	ex = "Elixir",
-- 	exs = "Elixir",
-- 	erl = "Erlang",
-- 	hrl = "Erlang",
-- 	hs = "Haskell",
-- 	lhs = "Haskell",
-- 	ml = "OCaml",
-- 	mli = "OCaml",
-- 	fs = "F#",
-- 	fsx = "F#",
-- 	clj = "Clojure",
-- 	cljs = "ClojureScript",
-- 	scala = "Scala",
-- 	kt = "Kotlin",
-- 	kts = "Kotlin",
-- 	groovy = "Groovy",
-- 	swift = "Swift",
-- 	m = "Objective-C",
-- 	mm = "Objective-C++",
-- 	-- Web
-- 	js = "JavaScript",
-- 	ts = "TypeScript",
-- 	jsx = "JSX",
-- 	tsx = "TSX",
-- 	html = "HTML",
-- 	htm = "HTML",
-- 	css = "CSS",
-- 	scss = "SCSS",
-- 	sass = "Sass",
-- 	less = "Less",
-- 	vue = "Vue",
-- 	svelte = "Svelte",
-- 	astro = "Astro",
-- 	-- Shell
-- 	sh = "Shell",
-- 	bash = "Bash",
-- 	zsh = "Zsh",
-- 	fish = "Fish",
-- 	ps1 = "PowerShell",
-- 	bat = "Batch",
-- 	cmd = "Batch",
-- 	-- Data / Config
-- 	json = "JSON",
-- 	yaml = "YAML",
-- 	yml = "YAML",
-- 	toml = "TOML",
-- 	xml = "XML",
-- 	csv = "CSV",
-- 	tsv = "TSV",
-- 	ini = "INI",
-- 	cfg = "Config",
-- 	conf = "Config",
-- 	env = "Env",
-- 	plist = "Plist",
-- 	-- Markup / Docs
-- 	md = "Markdown",
-- 	mdx = "MDX",
-- 	rst = "reStructuredText",
-- 	txt = "Text",
-- 	tex = "LaTeX",
-- 	bib = "BibTeX",
-- 	typ = "Typst",
-- 	org = "Org",
-- 	adoc = "AsciiDoc",
-- 	-- Build / Infra
-- 	mk = "Makefile",
-- 	cmake = "CMake",
-- 	tf = "Terraform",
-- 	hcl = "HCL",
-- 	nix = "Nix",
-- 	gradle = "Gradle",
-- 	bzl = "Bazel",
-- 	-- Database
-- 	sql = "SQL",
-- 	graphql = "GraphQL",
-- 	gql = "GraphQL",
-- 	-- Notebook / Scientific
-- 	ipynb = "Jupyter",
-- 	f90 = "Fortran",
-- 	f95 = "Fortran",
-- 	f03 = "Fortran",
-- 	f08 = "Fortran",
-- 	-- Other
-- 	proto = "Protobuf",
-- 	sol = "Solidity",
-- 	elm = "Elm",
-- 	purs = "PureScript",
-- 	rkt = "Racket",
-- 	scm = "Scheme",
-- 	lisp = "Lisp",
-- 	el = "Emacs Lisp",
-- 	vim = "Vimscript",
-- 	fnl = "Fennel",
-- 	asm = "Assembly",
-- 	s = "Assembly",
-- 	pas = "Pascal",
-- 	ada = "Ada",
-- 	pyi = "Python Stub",
-- 	wgsl = "WGSL",
-- 	glsl = "GLSL",
-- 	hlsl = "HLSL",
-- }
--
-- local excluded_paths = {
-- 	"*/.git/*",
-- 	"*/node_modules/*",
-- 	"*/vendor/*",
-- 	"*/target/*",
-- 	"*/__pycache__/*",
-- 	"*/dist/*",
-- 	"*/build/*",
-- 	"*/.cache/*",
-- 	"*/out/*",
-- 	"*/.venv/*",
-- 	"*/venv/*",
-- }
--
-- -- Colour palette: 16 distinct highlight group fg colours (hex).
-- -- Assigned round-robin to languages by rank.
-- local palette = {
-- 	"#61afef", -- blue
-- 	"#e06c75", -- red
-- 	"#98c379", -- green
-- 	"#e5c07b", -- yellow
-- 	"#c678dd", -- purple
-- 	"#56b6c2", -- cyan
-- 	"#d19a66", -- orange
-- 	"#be5046", -- dark red
-- 	"#528bff", -- bright blue
-- 	"#9ec400", -- lime
-- 	"#e5c07b", -- gold (reuse warm)
-- 	"#f92672", -- pink
-- 	"#a6e22e", -- bright green
-- 	"#66d9e8", -- sky
-- 	"#fd971f", -- amber
-- 	"#ae81ff", -- lavender
-- }
--
-- -- Ensure highlight groups exist (LangBar0 … LangBar15).
-- local function ensure_hls()
-- 	for i, hex in ipairs(palette) do
-- 		local name = "LangBar" .. (i - 1)
-- 		-- Only define once per session to avoid flicker.
-- 		if vim.fn.hlID(name) == 0 then
-- 			vim.api.nvim_set_hl(0, name, { fg = hex, bold = true })
-- 		end
-- 	end
-- 	-- Dim group for the legend label line
-- 	if vim.fn.hlID("LangBarDim") == 0 then
-- 		vim.api.nvim_set_hl(0, "LangBarDim", { fg = "#5c6370", italic = true })
-- 	end
-- end
--
-- local function collect_stats()
-- 	local counts = {}
-- 	local total = 0
-- 	local cmd = "find . -type f"
-- 	for _, p in ipairs(excluded_paths) do
-- 		cmd = cmd .. " -not -path '" .. p .. "'"
-- 	end
-- 	local handle = io.popen(cmd)
-- 	if not handle then
-- 		return nil, nil
-- 	end
-- 	for path in handle:lines() do
-- 		local ext = path:match("%.([^%.]+)$")
-- 		if ext then
-- 			local lang = ext_to_lang[ext:lower()]
-- 			if lang then
-- 				local f = io.open(path, "rb")
-- 				if f then
-- 					local size = f:seek("end")
-- 					f:close()
-- 					if size and size > 0 then
-- 						counts[lang] = (counts[lang] or 0) + size
-- 						total = total + size
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	handle:close()
-- 	if total == 0 then
-- 		return nil, nil
-- 	end
-- 	local results = {}
-- 	for lang, bytes in pairs(counts) do
-- 		table.insert(results, { lang = lang, pct = (bytes / total) * 100 })
-- 	end
-- 	table.sort(results, function(a, b)
-- 		return a.pct > b.pct
-- 	end)
-- 	-- Filter out < 0.5 %
-- 	local filtered = {}
-- 	for _, r in ipairs(results) do
-- 		if r.pct >= 0.5 then
-- 			table.insert(filtered, r)
-- 		end
-- 	end
-- 	return filtered, total
-- end
--
-- -- Build the segmented bar as a list of {text, hl_group} chunks.
-- -- BAR_WIDTH chars wide, each language gets floor(pct/100 * BAR_WIDTH) cells.
-- local function build_bar_chunks(results, bar_width)
-- 	local chunks = {}
-- 	local assigned = 0
-- 	local n = #results
-- 	for i, r in ipairs(results) do
-- 		local hl = "LangBar" .. ((i - 1) % #palette)
-- 		local len
-- 		if i == n then
-- 			len = bar_width - assigned -- give remainder to last segment
-- 		else
-- 			len = math.max(1, math.floor((r.pct / 100) * bar_width))
-- 		end
-- 		assigned = assigned + len
-- 		if assigned > bar_width then
-- 			len = len - (assigned - bar_width)
-- 			assigned = bar_width
-- 		end
-- 		if len > 0 then
-- 			table.insert(chunks, { text = string.rep("█", len), hl = hl })
-- 		end
-- 	end
-- 	return chunks
-- end
--
-- -- Build legend lines: "● LangName  12.3%" in columns.
-- -- Returns list of lines and a parallel list of highlight specs per line.
-- local function build_legend(results, win_width)
-- 	-- Each cell: "● LangName  XX.X%"
-- 	-- Measure max cell width then fit as many columns as possible.
-- 	local cell_w = 0
-- 	for _, r in ipairs(results) do
-- 		local w = 2 + #r.lang + 2 + 6 -- "● " + name + "  " + "XX.X%"
-- 		if w > cell_w then
-- 			cell_w = w
-- 		end
-- 	end
-- 	cell_w = cell_w + 2 -- gutter
-- 	local cols = math.max(1, math.floor((win_width - 4) / cell_w))
-- 	local lines = {}
-- 	local hls = {} -- parallel: list of {col_start, col_end, hl}[]
--
-- 	local row_cells = {}
-- 	local row_hls_tmp = {}
-- 	for i, r in ipairs(results) do
-- 		local hl = "LangBar" .. ((i - 1) % #palette)
-- 		local cell = string.format("● %-" .. (cell_w - 9) .. "s %5.1f%%", r.lang, r.pct)
-- 		table.insert(row_cells, { text = cell, hl = hl })
-- 		if #row_cells == cols or i == #results then
-- 			-- Assemble line
-- 			local line = "  "
-- 			local specs = {}
-- 			local col = 2
-- 			for _, c in ipairs(row_cells) do
-- 				table.insert(specs, { s = col, e = col + 1, hl = c.hl }) -- just the ●
-- 				line = line .. c.text
-- 				col = col + #c.text
-- 			end
-- 			table.insert(lines, line)
-- 			table.insert(hls, specs)
-- 			row_cells = {}
-- 		end
-- 	end
-- 	return lines, hls
-- end
--
-- local function open_float(results)
-- 	ensure_hls()
--
-- 	local BAR_WIDTH = 60
-- 	local WIN_W = BAR_WIDTH + 4 -- 2 padding each side
--
-- 	-- Count legend rows
-- 	local legend_lines, legend_hls = build_legend(results, WIN_W)
--
-- 	-- Build content lines:
-- 	-- [1]  blank
-- 	-- [2]  cwd
-- 	-- [3]  blank
-- 	-- [4]  bar line          ← extmarks go here
-- 	-- [5]  blank
-- 	-- [6]  "Language  %" header
-- 	-- [7]  separator
-- 	-- [8..N]  stat rows
-- 	-- [N+1]  blank
-- 	-- [N+2]  "Legend" header
-- 	-- [N+3]  separator
-- 	-- [N+4..M]  legend rows
-- 	-- [M+1]  blank
--
-- 	local cwd_str = string.format("  cwd: %s", vim.fn.getcwd())
-- 	local bar_pad = "  " .. string.rep(" ", math.floor((BAR_WIDTH - BAR_WIDTH) / 2))
--
-- 	local content = {}
-- 	table.insert(content, "")
-- 	table.insert(content, cwd_str)
-- 	table.insert(content, "")
-- 	-- bar placeholder (will be highlighted via extmarks)
-- 	table.insert(content, "  " .. string.rep(" ", BAR_WIDTH)) -- row index 4 (1-based)
-- 	table.insert(content, "")
-- 	table.insert(content, string.format("  %-18s %7s", "Language", "%"))
-- 	table.insert(content, "  " .. string.rep("─", 28))
--
-- 	for _, r in ipairs(results) do
-- 		table.insert(content, string.format("  %-18s %6.1f%%", r.lang, r.pct))
-- 	end
--
-- 	table.insert(content, "")
-- 	table.insert(content, "  Legend")
-- 	table.insert(content, "  " .. string.rep("─", 28))
-- 	for _, ll in ipairs(legend_lines) do
-- 		table.insert(content, ll)
-- 	end
-- 	table.insert(content, "")
--
-- 	-- Window height = number of content lines (capped)
-- 	local WIN_H = math.min(#content, vim.o.lines - 4)
--
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
-- 	vim.bo[buf].modifiable = false
-- 	vim.bo[buf].bufhidden = "wipe"
--
-- 	local ui = vim.api.nvim_list_uis()[1]
-- 	local row = math.floor((ui.height - WIN_H) / 2)
-- 	local col = math.floor((ui.width - WIN_W) / 2)
--
-- 	local win = vim.api.nvim_open_win(buf, true, {
-- 		relative = "editor",
-- 		width = WIN_W,
-- 		height = WIN_H,
-- 		row = row,
-- 		col = col,
-- 		style = "minimal",
-- 		border = "rounded",
-- 		title = " 󰈙 Language Stats ",
-- 		title_pos = "center",
-- 	})
--
-- 	-- ── Extmarks: colour the bar (row index 3, 0-based) ──────────────────
-- 	local ns = vim.api.nvim_create_namespace("LangStatsBar")
-- 	local bar_chunks = build_bar_chunks(results, BAR_WIDTH)
-- 	local bar_row = 3 -- 0-based
-- 	local bar_col = 2 -- after "  " padding
--
-- 	local cur_col = bar_col
-- 	for _, chunk in ipairs(bar_chunks) do
-- 		vim.api.nvim_buf_set_extmark(buf, ns, bar_row, cur_col, {
-- 			end_col = cur_col + #chunk.text,
-- 			hl_group = chunk.hl,
-- 		})
-- 		cur_col = cur_col + #chunk.text
-- 	end
--
-- 	-- ── Extmarks: colour stat rows (language name in its colour) ─────────
-- 	local stat_start_row = 7 -- 0-based index of first stat line
-- 	for i, r in ipairs(results) do
-- 		local hl = "LangBar" .. ((i - 1) % #palette)
-- 		local row_idx = stat_start_row + (i - 1)
-- 		vim.api.nvim_buf_set_extmark(buf, ns, row_idx, 2, {
-- 			end_col = 2 + #r.lang,
-- 			hl_group = hl,
-- 		})
-- 	end
--
-- 	-- ── Extmarks: colour legend bullets ──────────────────────────────────
-- 	local legend_start_row = stat_start_row + #results + 3 -- blank + "Legend" + sep
-- 	for li, specs in ipairs(legend_hls) do
-- 		local row_idx = legend_start_row + (li - 1)
-- 		for _, sp in ipairs(specs) do
-- 			vim.api.nvim_buf_set_extmark(buf, ns, row_idx, sp.s, {
-- 				end_col = sp.e,
-- 				hl_group = sp.hl,
-- 			})
-- 		end
-- 	end
--
-- 	-- Close on q / <Esc>
-- 	for _, key in ipairs({ "q", "<Esc>" }) do
-- 		vim.keymap.set("n", key, function()
-- 			if vim.api.nvim_win_is_valid(win) then
-- 				vim.api.nvim_win_close(win, true)
-- 			end
-- 		end, { buffer = buf, nowait = true, silent = true })
-- 	end
-- end
--
-- local function lang_stats_bar()
-- 	local results, _ = collect_stats()
-- 	if not results then
-- 		vim.notify("LangStats: no recognised source files found (check :pwd)", vim.log.levels.WARN)
-- 		return
-- 	end
-- 	open_float(results)
-- end
--
-- vim.api.nvim_create_user_command("LangStatsBar", lang_stats_bar, {})
-- vim.keymap.set("n", "<leader>lL", "<cmd>LangStatsBar<cr>", { desc = "Language stats (bar)", silent = true })
--
--
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- lua/config/langstats_bar.lua
-- Coloured single-bar language stats with floating window + legend.
-- Map: <leader>lL

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
	"*/.cache/*",
	"*/out/*",
	"*/.venv/*",
	"*/venv/*",
}

-- Colour palette: 16 distinct highlight group fg colours (hex).
-- Assigned round-robin to languages by rank.
local palette = {
	"#61afef", -- blue
	"#e06c75", -- red
	"#98c379", -- green
	"#e5c07b", -- yellow
	"#c678dd", -- purple
	"#56b6c2", -- cyan
	"#d19a66", -- orange
	"#be5046", -- dark red
	"#528bff", -- bright blue
	"#9ec400", -- lime
	"#e5c07b", -- gold (reuse warm)
	"#f92672", -- pink
	"#a6e22e", -- bright green
	"#66d9e8", -- sky
	"#fd971f", -- amber
	"#ae81ff", -- lavender
}

-- Ensure highlight groups exist (LangBar0 … LangBar15).
local function ensure_hls()
	for i, hex in ipairs(palette) do
		local name = "LangBar" .. (i - 1)
		-- Only define once per session to avoid flicker.
		if vim.fn.hlID(name) == 0 then
			vim.api.nvim_set_hl(0, name, { fg = hex, bold = true })
		end
	end
	-- Dim group for the legend label line
	if vim.fn.hlID("LangBarDim") == 0 then
		vim.api.nvim_set_hl(0, "LangBarDim", { fg = "#5c6370", italic = true })
	end
end

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
	-- Filter out < 0.5 %
	local filtered = {}
	for _, r in ipairs(results) do
		if r.pct >= 0.5 then
			table.insert(filtered, r)
		end
	end
	return filtered, total
end

-- Return the byte length of a string (handles multibyte UTF-8 correctly
-- for use with nvim_buf_set_extmark which works in bytes, not characters).
local function byte_len(s)
	return #s
end

-- Build the segmented bar as a list of {text, hl_group, byte_len} chunks.
-- BAR_WIDTH chars wide (each █ is 3 bytes but 1 display cell).
-- We track byte offsets for extmarks and cell counts for width.
local function build_bar_chunks(results, bar_width)
	local chunks = {}
	local assigned_cells = 0
	-- █ is U+2588 FULL BLOCK = 3 UTF-8 bytes, 1 display cell
	local BLOCK = "█"
	local BLOCK_BYTES = #BLOCK -- 3
	local n = #results
	for i, r in ipairs(results) do
		local hl = "LangBar" .. ((i - 1) % #palette)
		local cells
		if i == n then
			cells = bar_width - assigned_cells
		else
			cells = math.max(1, math.floor((r.pct / 100) * bar_width))
		end
		assigned_cells = assigned_cells + cells
		if assigned_cells > bar_width then
			cells = cells - (assigned_cells - bar_width)
			assigned_cells = bar_width
		end
		if cells > 0 then
			local text = string.rep(BLOCK, cells)
			table.insert(chunks, {
				text = text,
				hl = hl,
				byte_len = cells * BLOCK_BYTES, -- correct byte length for extmarks
			})
		end
	end
	return chunks
end

-- Build legend lines: "● LangName  12.3%" in columns.
-- Returns list of lines and a parallel list of highlight specs per line.
-- Specs use BYTE offsets (required by nvim_buf_set_extmark).
-- ● is U+25CF BLACK CIRCLE = 3 UTF-8 bytes, 1 display cell.
local BULLET = "●"
local BULLET_BYTES = #BULLET -- 3

local function build_legend(results, win_width)
	-- Each cell: "● LangName  XX.X%"
	-- Measure max cell width (in display cells) then fit as many columns as possible.
	local cell_w = 0
	for _, r in ipairs(results) do
		-- 1 (bullet cell) + 1 (space) + #name + 2 (spaces) + 6 (XX.X%)
		local w = 2 + #r.lang + 2 + 6
		if w > cell_w then
			cell_w = w
		end
	end
	cell_w = cell_w + 2 -- gutter
	local cols = math.max(1, math.floor((win_width - 4) / cell_w))
	local lines = {}
	local hls = {} -- parallel: list of {col_start, col_end, hl}[] in BYTES

	local row_cells = {}
	for i, r in ipairs(results) do
		local hl = "LangBar" .. ((i - 1) % #palette)
		local cell = string.format("● %-" .. (cell_w - 9) .. "s %5.1f%%", r.lang, r.pct)
		table.insert(row_cells, { text = cell, hl = hl })
		if #row_cells == cols or i == #results then
			-- Assemble line; track byte offset for extmark positions
			local line = "  "
			local specs = {}
			local byte_col = 2 -- start after "  " (2 ASCII bytes)
			for _, c in ipairs(row_cells) do
				-- The bullet ● sits at byte_col and is BULLET_BYTES wide
				table.insert(specs, {
					s = byte_col,
					e = byte_col + BULLET_BYTES, -- correct: 3 bytes, not 1
					hl = c.hl,
				})
				line = line .. c.text
				-- Advance byte_col by the byte length of the cell string.
				-- The cell text starts with ● (3 bytes) then ASCII chars,
				-- so #c.text gives the correct byte length.
				byte_col = byte_col + #c.text
			end
			table.insert(lines, line)
			table.insert(hls, specs)
			row_cells = {}
		end
	end
	return lines, hls
end

local function open_float(results)
	ensure_hls()

	local BAR_WIDTH = 60
	local WIN_W = BAR_WIDTH + 4 -- 2 padding each side

	-- Count legend rows
	local legend_lines, legend_hls = build_legend(results, WIN_W)

	local cwd_str = string.format("  cwd: %s", vim.fn.getcwd())

	local content = {}
	table.insert(content, "")
	table.insert(content, cwd_str)
	table.insert(content, "")
	-- bar placeholder (will be highlighted via extmarks)
	-- We store spaces here; the bar glyphs are painted by extmarks over them.
	-- Actually we put the real █ glyphs in the line so the buffer has the right
	-- byte content and extmarks simply colour it.
	local bar_line = "  " .. string.rep("█", BAR_WIDTH)
	table.insert(content, bar_line) -- row index 4 (1-based), 3 (0-based)
	table.insert(content, "")
	table.insert(content, string.format("  %-18s %7s", "Language", "%"))
	table.insert(content, "  " .. string.rep("─", 28))

	for _, r in ipairs(results) do
		table.insert(content, string.format("  %-18s %6.1f%%", r.lang, r.pct))
	end

	table.insert(content, "")
	table.insert(content, "  Legend")
	table.insert(content, "  " .. string.rep("─", 28))
	for _, ll in ipairs(legend_lines) do
		table.insert(content, ll)
	end
	table.insert(content, "")

	-- Window height = number of content lines (capped)
	local WIN_H = math.min(#content, vim.o.lines - 4)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	local ui = vim.api.nvim_list_uis()[1]
	local row = math.floor((ui.height - WIN_H) / 2)
	local col = math.floor((ui.width - WIN_W) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = WIN_W,
		height = WIN_H,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " 󰈙 Language Stats ",
		title_pos = "center",
	})

	-- ── Extmarks: colour the bar (row index 3, 0-based) ──────────────────
	local ns = vim.api.nvim_create_namespace("LangStatsBar")
	local bar_chunks = build_bar_chunks(results, BAR_WIDTH)
	local bar_row = 3 -- 0-based
	local bar_col = 2 -- after "  " (2 ASCII bytes)

	local cur_col = bar_col
	for _, chunk in ipairs(bar_chunks) do
		vim.api.nvim_buf_set_extmark(buf, ns, bar_row, cur_col, {
			end_col = cur_col + chunk.byte_len, -- use pre-computed byte length
			hl_group = chunk.hl,
		})
		cur_col = cur_col + chunk.byte_len
	end

	-- ── Extmarks: colour stat rows (language name in its colour) ─────────
	local stat_start_row = 7 -- 0-based index of first stat line
	for i, r in ipairs(results) do
		local hl = "LangBar" .. ((i - 1) % #palette)
		local row_idx = stat_start_row + (i - 1)
		-- Language name is ASCII so #r.lang == byte length; safe to use directly.
		vim.api.nvim_buf_set_extmark(buf, ns, row_idx, 2, {
			end_col = 2 + #r.lang,
			hl_group = hl,
		})
	end

	-- ── Extmarks: colour legend bullets ──────────────────────────────────
	local legend_start_row = stat_start_row + #results + 3 -- blank + "Legend" + sep
	for li, specs in ipairs(legend_hls) do
		local row_idx = legend_start_row + (li - 1)
		for _, sp in ipairs(specs) do
			-- sp.s / sp.e are already in bytes (set correctly in build_legend)
			vim.api.nvim_buf_set_extmark(buf, ns, row_idx, sp.s, {
				end_col = sp.e,
				hl_group = sp.hl,
			})
		end
	end

	-- Close on q / <Esc>
	for _, key in ipairs({ "q", "<Esc>" }) do
		vim.keymap.set("n", key, function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end, { buffer = buf, nowait = true, silent = true })
	end
end

local function lang_stats_bar()
	local results, _ = collect_stats()
	if not results then
		vim.notify("LangStats: no recognised source files found (check :pwd)", vim.log.levels.WARN)
		return
	end
	open_float(results)
end

vim.api.nvim_create_user_command("LangStatsBar", lang_stats_bar, {})
vim.keymap.set("n", "<leader>lL", "<cmd>LangStatsBar<cr>", { desc = "Language stats (bar)", silent = true })
