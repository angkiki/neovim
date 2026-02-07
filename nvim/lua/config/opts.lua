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

-- default open splits to the right
vim.o.splitright = true

-- enable syntax (required for LSP hover highlighting)
vim.cmd('syntax on')
