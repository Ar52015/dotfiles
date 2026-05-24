-- Clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

-- Open terminal in insert mode
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.split()
	vim.cmd.term()
	vim.cmd.startinsert()
end, { desc = "Open terminal (lower horizontal)" })

vim.keymap.set("n", "<leader>T", function()
	vim.cmd.vsplit()
	vim.cmd.term()
	vim.cmd.startinsert()
end, { desc = "Open terminal (vertical right)" })

-- Close tab
vim.keymap.set("n", "<leader>q", ":tabclose<CR>", { silent = true })

-- Theme switching ----------------------------------------------------------
-- Cycle through alternate colorschemes. Neopywal is the default (set in
-- lua/plugins/neopywal.lua) and is toggled separately below.
local cycle_themes = {
	"rose-pine",
	"lackluster-dark",
	"vague",
	"no-clown-fiesta",
	"zenwritten",
	"oxocarbon",
	"catppuccin",
	"tokyonight",
	"kanagawa",
	"gruvbox",
	"everforest",
	"nord",
	"nightfox",
}
local cycle_idx = 0 -- index of the last cycle theme picked (0 = none yet)

-- Where the last-used colorscheme is remembered across restarts.
local theme_file = vim.fn.stdpath("state") .. "/last_colorscheme"

local function save_theme(name)
	pcall(vim.fn.writefile, { name }, theme_file)
end

local function set_colorscheme(name, opts)
	opts = opts or {}
	local ok, err = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify("colorscheme '" .. name .. "' failed: " .. tostring(err), vim.log.levels.ERROR)
		return
	end
	save_theme(name)
	if not opts.silent then
		vim.notify("colorscheme: " .. name)
	end
	vim.cmd("redraw!")
end

-- Cycle forward through the alternate themes
vim.keymap.set("n", "<leader>cs", function()
	cycle_idx = cycle_idx % #cycle_themes + 1
	set_colorscheme(cycle_themes[cycle_idx])
end, { desc = "Cycle alternate themes" })

-- Toggle between the last alternate theme and neopywal
vim.keymap.set("n", "<leader>cr", function()
	if vim.g.colors_name == "neopywal" then
		cycle_idx = cycle_idx == 0 and 1 or cycle_idx
		set_colorscheme(cycle_themes[cycle_idx])
	else
		set_colorscheme("neopywal")
	end
end, { desc = "Toggle theme <-> neopywal" })

-- Neopywal keeps a transparent bg; other themes keep their own bg and sync
-- the terminal's bg via OSC 11 so window padding matches the theme.
local transparent_groups = { "Normal", "NormalFloat", "FloatBorder", "SignColumn", "EndOfBuffer", "LineNr" }

local function clear_bg(group)
	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	hl.bg = nil
	hl.ctermbg = nil
	vim.api.nvim_set_hl(0, group, hl)
end

-- Per-theme fixes for themes that paint the gutter (LineNr/SignColumn) with
-- a different bg than Normal — looks like a sidebar panel otherwise. We
-- include DiagnosticSign* because oil-git-status links its signs to them, so
-- their bg shows in every reserved cell of oil's `signcolumn = "auto:2"`.
local function blend_gutter()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local groups = {
		"LineNr",
		"CursorLineNr",
		"FoldColumn",
		"SignColumn",
		"DiagnosticSignError",
		"DiagnosticSignWarn",
		"DiagnosticSignInfo",
		"DiagnosticSignHint",
		"DiagnosticSignOk",
	}
	for _, g in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
		hl.bg = normal.bg
		hl.ctermbg = normal.ctermbg
		vim.api.nvim_set_hl(0, g, hl)
	end
end

local theme_fixes = {
	kanagawa = blend_gutter,
	gruvbox = blend_gutter,
}

local function apply_theme_overrides()
	local theme = vim.g.colors_name
	if theme == "neopywal" then
		for _, g in ipairs(transparent_groups) do
			clear_bg(g)
		end
		-- Reset terminal bg to its configured default (OSC 111)
		io.write("\027]111\007")
		io.flush()
	else
		-- Push theme's Normal bg to the terminal (OSC 11) so padding matches
		local n = vim.api.nvim_get_hl(0, { name = "Normal" })
		if n.bg then
			io.write(string.format("\027]11;#%06x\007", n.bg))
			io.flush()
		end
		if theme_fixes[theme] then
			theme_fixes[theme]()
		end
	end
	-- Out-of-focus splits inherit Normal
	vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_theme_overrides })

-- Restore terminal's configured bg on nvim exit (so the shell keeps its padding)
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		io.write("\027]111\007")
		io.flush()
	end,
})

-- Always show terminals on the transparent neopywal theme. Uses raw
-- :colorscheme (not set_colorscheme) so we don't overwrite the saved theme.
--  vim.api.nvim_create_autocmd("TermOpen", {
--      callback = function()
--          if vim.g.colors_name ~= "neopywal" then
--              vim.cmd.colorscheme("neopywal")
--          end
--      end,
--  })

-- Persist the chosen theme across restarts: restore on startup if saved.
do
	local ok, lines = pcall(vim.fn.readfile, theme_file)
	local saved = ok and lines and lines[1]
	if saved and saved ~= "" then
		for i, t in ipairs(cycle_themes) do
			if t == saved then
				cycle_idx = i
				break
			end
		end
		set_colorscheme(saved, { silent = true })
	end
end

-- Apply overrides to the current colorscheme too (the autocmd above
-- doesn't fire for the colorscheme set during plugin init).
apply_theme_overrides()
