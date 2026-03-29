-- Clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

-- Open terminal in a lower horizontal split
vim.keymap.set("n", "<leader>t", "<cmd>split | term<cr>", { desc = "Open terminnal" })
