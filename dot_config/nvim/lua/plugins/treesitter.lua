return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"python",
			"c",
			"cpp",
			"javascript",
			"typescript",
			"java",
			"toml",
			"yaml",
			"json",
			"markdown",
			"markdown_inline",
			"dockerfile",
		})

		-- Enable treesitter highlighting for all installed parsers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
