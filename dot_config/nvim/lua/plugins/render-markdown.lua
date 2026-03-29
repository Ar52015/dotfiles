return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{ "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown preview" },
	},
}
