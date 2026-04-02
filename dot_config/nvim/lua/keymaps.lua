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
