return {
	"echasnovski/mini.nvim",
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup()
		require("mini.surround").setup()
	end,
}
