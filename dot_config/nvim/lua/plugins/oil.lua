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
		keymaps = {
			["<C-l>"] = false, -- Disable page refresh keymap
			["<C-h>"] = false, -- Disable split file preview
			["<leader>e"] = { -- To make telescope on necessary directories
				desc = "Change pwd to buffer and refresh",
				callback = function()
					local oil = require("oil")
					local dir = oil.get_current_dir()
					if not dir then
						vim.notify("Oil: no working directory associated with current buffer", vim.log.levels.WARN)
						return
					end
					vim.cmd("edit!")
					vim.cmd("cd " .. vim.fn.fnameescape(dir))
				end,
			},
		},
		win_options = {
			signcolumn = "auto:2",
		},
	},
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
}
