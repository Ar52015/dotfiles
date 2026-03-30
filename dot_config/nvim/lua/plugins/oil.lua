return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		view_options = {
			show_hidden = true,
		},
		default_file_explorer = true,
		sort = {
			{ "type", "asc" },
			{ "name", "asc" },
		},
	},
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
}
