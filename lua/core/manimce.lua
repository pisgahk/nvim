-- Manim: render the enclosing class, but only through the cursor's line
local function manim_partial_run(quality_flag)
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		vim.notify("Buffer has no file on disk", vim.log.levels.ERROR)
		return
	end

	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

	-- walk upward from the cursor to find the enclosing `class Foo(Scene):`
	local class_name = nil
	for lnum = cursor_line, 1, -1 do
		local line = vim.fn.getline(lnum)
		local name = line:match("^%s*class%s+([%w_]+)%s*%(") or line:match("^%s*class%s+([%w_]+)%s*:")
		if name then
			class_name = name
			break
		end
	end

	if not class_name then
		vim.notify("No enclosing Manim class found above cursor", vim.log.levels.ERROR)
		return
	end

	-- lines 1..cursor_line keeps imports and any code above the class intact
	local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line, false)

	local tmpfile = vim.fn.tempname() .. ".py"
	vim.fn.writefile(lines, tmpfile)

	local cmd =
		string.format("!manim %s %s %s", quality_flag, vim.fn.shellescape(tmpfile), vim.fn.shellescape(class_name))
	vim.cmd(cmd)
end

vim.keymap.set("n", "<leader>ml", function()
	manim_partial_run("-pql")
end, { desc = "Manim: render up to cursor (low quality)" })
vim.keymap.set("n", "<leader>mh", function()
	manim_partial_run("-pqh")
end, { desc = "Manim: render up to cursor (high quality)" })

------------------------------------------------------------------------------------

-- Manim: render the enclosing class (up to cursor) in a floating terminal
-- local function manim_partial_run_float(quality_flag)
-- 	local bufname = vim.api.nvim_buf_get_name(0)
-- 	if bufname == "" then
-- 		vim.notify("Buffer has no file on disk", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
--
-- 	local class_name = nil
-- 	for lnum = cursor_line, 1, -1 do
-- 		local line = vim.fn.getline(lnum)
-- 		local name = line:match("^%s*class%s+([%w_]+)%s*%(") or line:match("^%s*class%s+([%w_]+)%s*:")
-- 		if name then
-- 			class_name = name
-- 			break
-- 		end
-- 	end
--
-- 	if not class_name then
-- 		vim.notify("No enclosing Manim class found above cursor", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line, false)
-- 	local tmpfile = vim.fn.tempname() .. ".py"
-- 	vim.fn.writefile(lines, tmpfile)
--
-- 	local cmd =
-- 		string.format("manim %s %s %s", quality_flag, vim.fn.shellescape(tmpfile), vim.fn.shellescape(class_name))
--
-- 	-- floating window
-- 	local width = math.floor(vim.o.columns * 0.8)
-- 	local height = math.floor(vim.o.lines * 0.8)
-- 	local row = math.floor((vim.o.lines - height) / 2)
-- 	local col = math.floor((vim.o.columns - width) / 2)
--
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	local win = vim.api.nvim_open_win(buf, true, {
-- 		relative = "editor",
-- 		width = width,
-- 		height = height,
-- 		row = row,
-- 		col = col,
-- 		style = "minimal",
-- 		border = "rounded",
-- 		title = string.format(" manim: %s (%s) ", class_name, quality_flag),
-- 		title_pos = "center",
-- 	})
--
-- 	vim.fn.termopen(cmd, {
-- 		on_exit = function(_, exit_code)
-- 			vim.notify(
-- 				string.format("Manim render %s (exit %d)", exit_code == 0 and "finished" or "failed", exit_code),
-- 				exit_code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
-- 			)
-- 		end,
-- 	})
--
-- 	vim.cmd("startinsert")
--
-- 	-- q or <Esc> in normal mode closes the float (doesn't kill the job if still running)
-- 	local close_opts = { buffer = buf, nowait = true, silent = true }
-- 	vim.keymap.set("n", "q", "<cmd>close<CR>", close_opts)
-- 	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", close_opts)
-- end
--
-- vim.keymap.set("n", "<leader>mpl", function()
-- 	manim_partial_run_float("-pql")
-- end, { desc = "Manim: render up to cursor in float (low quality)" })
-- vim.keymap.set("n", "<leader>mph", function()
-- 	manim_partial_run_float("-pqh")
-- end, { desc = "Manim: render up to cursor in float (high quality)" })
--
--------------------------------------------------------------------------------------------

-- -- Manim: persistent right-hand terminal split, reused like a REPL
-- local M = {}
--
-- M.term_buf = nil
-- M.term_win = nil
-- M.term_job = nil
--
-- local function terminal_is_alive()
-- 	return M.term_buf
-- 		and vim.api.nvim_buf_is_valid(M.term_buf)
-- 		and M.term_job
-- 		and vim.fn.jobwait({ M.term_job }, 0)[1] == -1
-- end
--
-- local function ensure_manim_terminal()
-- 	if terminal_is_alive() then
-- 		-- window may have been closed even if the job/buffer is still alive
-- 		if not (M.term_win and vim.api.nvim_win_is_valid(M.term_win)) then
-- 			vim.cmd("botright vsplit")
-- 			M.term_win = vim.api.nvim_get_current_win()
-- 			vim.api.nvim_win_set_buf(M.term_win, M.term_buf)
-- 			vim.api.nvim_win_set_width(M.term_win, 90)
-- 		end
-- 		return
-- 	end
--
-- 	-- fresh terminal
-- 	vim.cmd("botright vsplit")
-- 	vim.api.nvim_win_set_width(0, 90)
-- 	vim.cmd("terminal")
-- 	M.term_buf = vim.api.nvim_get_current_buf()
-- 	M.term_win = vim.api.nvim_get_current_win()
-- 	M.term_job = vim.b[M.term_buf].terminal_job_id
--
-- 	vim.bo[M.term_buf].bufhidden = "hide" -- survive window close, don't get wiped
-- 	vim.wo[M.term_win].number = false
-- 	vim.wo[M.term_win].relativenumber = false
-- end
--
-- local function send_to_manim_terminal(cmd)
-- 	ensure_manim_terminal()
-- 	vim.fn.chansend(M.term_job, cmd .. "\n")
--
-- 	-- scroll terminal window to bottom so new output is visible
-- 	vim.api.nvim_win_call(M.term_win, function()
-- 		vim.cmd("normal! G")
-- 	end)
-- end
--
-- local function manim_partial_run(quality_flag)
-- 	local bufname = vim.api.nvim_buf_get_name(0)
-- 	if bufname == "" then
-- 		vim.notify("Buffer has no file on disk", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
--
-- 	local class_name = nil
-- 	for lnum = cursor_line, 1, -1 do
-- 		local line = vim.fn.getline(lnum)
-- 		local name = line:match("^%s*class%s+([%w_]+)%s*%(") or line:match("^%s*class%s+([%w_]+)%s*:")
-- 		if name then
-- 			class_name = name
-- 			break
-- 		end
-- 	end
--
-- 	if not class_name then
-- 		vim.notify("No enclosing Manim class found above cursor", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line, false)
-- 	local tmpfile = vim.fn.tempname() .. ".py"
-- 	vim.fn.writefile(lines, tmpfile)
--
-- 	local cmd =
-- 		string.format("manim %s %s %s", quality_flag, vim.fn.shellescape(tmpfile), vim.fn.shellescape(class_name))
--
-- 	send_to_manim_terminal(cmd)
-- end
--
-- vim.keymap.set("n", "<leader>mpl", function()
-- 	manim_partial_run("-pql")
-- end, { desc = "Manim: render up to cursor in REPL split (low quality)" })
-- vim.keymap.set("n", "<leader>mph", function()
-- 	manim_partial_run("-pqh")
-- end, { desc = "Manim: render up to cursor in REPL split (high quality)" })
--
-- -- optional: toggle the terminal split into view/out of view without killing the job
-- vim.keymap.set("n", "<leader>mt", function()
-- 	if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
-- 		vim.api.nvim_win_close(M.term_win, false)
-- 		M.term_win = nil
-- 	else
-- 		ensure_manim_terminal()
-- 	end
-- end, { desc = "Manim: toggle terminal split" })
--
-- return M
