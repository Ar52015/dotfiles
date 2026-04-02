return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local diffview = require("diffview")

		diffview.setup({
			enhanced_diff_hl = true,
			view = {
				default = { layout = "diff2_horizontal" },
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
			file_panel = {
				win_config = {
					position = "left",
					width = 35,
				},
			},
		})

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- View diffs
		map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", opts)
		map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", opts)

		-- History views
		map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", opts)
		map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", opts)

		-- Merge conflicts
		map("n", "<leader>gm", "<cmd>DiffviewOpen<CR>", opts)
	end,
}
