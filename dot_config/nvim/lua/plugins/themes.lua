-- Alternate colorschemes available for cycling. Neopywal (set in
-- lua/plugins/neopywal.lua) is the default; these load alongside it.
--   <leader>cs  cycle through the themes below
--   <leader>cr  toggle current theme <-> neopywal
-- Names: rose-pine, lackluster-dark, vague, no-clown-fiesta, zenwritten, oxocarbon,
--        catppuccin, tokyonight, kanagawa, gruvbox, everforest, nord, nightfox
return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		opts = {
			variant = "main",
			dark_variant = "main",
			styles = { italic = true, transparency = false },
		},
	},
	{ "slugbyte/lackluster.nvim", lazy = false },
	{
		"vague2k/vague.nvim",
		lazy = false,
		config = function()
			require("vague").setup({})
		end,
	},
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = false },
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = false,
	},
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false },

	-- Popular themes
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
	{ "folke/tokyonight.nvim", lazy = false },
	{ "rebelot/kanagawa.nvim", lazy = false },
	{ "ellisonleao/gruvbox.nvim", lazy = false },
	{
		"neanias/everforest-nvim",
		name = "everforest",
		lazy = false,
		opts = {},
	},
	{ "shaunsingh/nord.nvim", lazy = false },
	{ "EdenEast/nightfox.nvim", lazy = false },
}
