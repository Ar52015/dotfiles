-- Tab functionality
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

-- Nerd Font installed
vim.g.nerd_font_installed = true

-- Adding line numbers to nvim
vim.opt.number = true
vim.opt.relativenumber = true

-- Text Wrapping
vim.o.breakindent = true

-- File close undo
vim.o.undofile = true

-- Case handling while searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Signcolumn
vim.o.signcolumn = 'yes'

-- Update time and timeout
vim.o.updatetime = 400
vim.o.timeoutlen = 400

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Highlighting subs
vim.o.inccommand = 'split'

-- Show what line cursor is on
vim.o.cursorline = true

-- Space above and below cursor
vim.o.scrolloff = 10

-- Confirmtion dialogue for unsaved file
vim.o.confirm = true

