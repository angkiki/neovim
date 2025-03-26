-- line numbers
vim.opt.nu = true
-- relative line numbers
vim.opt.relativenumber = true

-- indenting to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- ???
vim.opt.expandtab = true

-- no line wrapping
vim.opt.wrap = false

-- incremental searching highlighting
vim.opt.incsearch = true

-- leaves 8 spaces at the bottom of the file
-- while you are scrolling
vim.opt.scrolloff = 8

-- ensures that the left column always
-- has space that doesn't cause LSP hints
-- to cause the side bar to move
vim.o.signcolumn = "yes"

-- this remaps the default leader key to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- insta quit nvim
vim.keymap.set('n', '<leader>QQ', ':qa!<CR>', { noremap = true, silent = true })

-- this remaps :Ex to <leader>pv
-- which allows us to go back to file explorer
-- by doing <leader>pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- <leader>p allows us to paste without losing
-- whatever is in the "yanked" buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without replacing clipboard" })

-- <leader>y allows us to yank into our PC's clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Yank to system clipboard" })

-- for LSPs
-- when there's a linting hint/error etc.
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

-- for window splitting & resizing
vim.keymap.set('n', '<leader>ss', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sv', ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sq', ':q<CR>', { noremap = true, silent = true })

-- Resize splits using Ctrl + arrow keys
vim.keymap.set('n', '<C-Up>', ':resize +3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +3<CR>', { noremap = true, silent = true })
-- Can uncomment and use the version below for MacOS
-- because "Ctrl + Left/Right" moves between desktops
-- vim.keymap.set('n', '<A-Up>', ':resize +3<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<A-Down>', ':resize -3<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<A-Left>', ':vertical resize -3<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<A-Right>', ':vertical resize +3<CR>', { noremap = true, silent = true })

-- Move between splits with <leader>h/j/k/l
vim.keymap.set('n', '<leader>sh', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sk', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sl', '<C-w>l', { noremap = true, silent = true })

-- Alternative Bindings for moving between tabs (easily with 1 hand)
vim.keymap.set("n", "<leader>sa", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sd", "<C-w>l", { noremap = true, silent = true })

-- For navigating between Tabs
vim.keymap.set("n", "<Tab>", "gt", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "gT", { noremap = true, silent = true })

-- for clearing out search highlighting
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true })
