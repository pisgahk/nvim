return {
	-- ======================================================================================================================
	{
		"isakbm/gitgraph.nvim",
		opts = {
			git_cmd = "git",
			open_in = "vsplit", -- 💡 Options: "current", "tab", "split", "vsplit"
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gx",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},

	-- ======================================================================================================================
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Glog", "Ggrep", "Gedit" },
	},

	-- ======================================================================================================================
	{
		"lewis6991/gitsigns.nvim", -- 🪧 Git signs
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup()
		end,
		keys = {
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Git Hunk",
			},
			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage Git Hunk",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset Git Hunk",
			},
			{
				"]g",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Next Hunk",
			},
			{
				"[g",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Prev Hunk",
			},
		},
	},

	-- ======================================================================================================================
	-- 🧭 Diffview for commits, branches, stash, etc.
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diff View" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "File History" },
		},
	},

	-- ======================================================================================================================
	-- 📝 Cleaner commit message experience
	{
		"rhysd/committia.vim",
		ft = "gitcommit",
	},

	-- ======================================================================================================================
	-- 🎨 Optional Dressing for inputs and selects
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
}
