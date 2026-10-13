return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		cursor_color = "#ebbcba",

		stiffness = 0.7,
		trailing_stiffness = 0.5,
		damping = 0.7,

		smear_between_neighbor_lines = true,

		legacy_computing_symbols_support = false,
	},
}
