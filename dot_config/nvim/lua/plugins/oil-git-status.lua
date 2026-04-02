return {
	"refractalize/oil-git-status.nvim",
	dependencies = { "stevearc/oil.nvim" },
	opts = {
		show_ignored = true,
		symbols = {
			index = {
				["!"] = "", -- Ignored
				["?"] = "", -- Untracked
				["A"] = "", -- Added
				["C"] = "", -- Copied
				["D"] = "", -- Deleted
				["M"] = "", -- Modified
				["R"] = "", -- Renamed
				["T"] = "󰉺", -- Type changed
				["U"] = "", -- Unmerged/Conflict
				[" "] = " ", -- Unmodified
			},
			working_tree = {
				["!"] = "", -- Ignored
				["?"] = "", -- Untracked
				["A"] = "", -- Added
				["C"] = "", -- Copied
				["D"] = "", -- Deleted
				["M"] = "", -- Modified
				["R"] = "", -- Renamed
				["T"] = "󰉺", -- Type changed
				["U"] = "", -- Unmerged/Conflict
				[" "] = " ", -- Unmodified
			},
		},
	},
}
