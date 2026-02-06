-- this remaps the default leader key to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- insta quit nvim
vim.keymap.set("n", "<leader>QQ", ":qa!<CR>", { noremap = true, silent = true })

-- this remaps :Ex to <leader>pv
-- which allows us to go back to file explorer
-- by doing <leader>pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- <leader>p allows us to paste without losing
-- whatever is in the "yanked" buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without replacing clipboard" })

-- <leader>y allows us to yank into our PC's clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- for LSPs
-- when there's a linting hint/error etc.
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })

-- creating splits
vim.keymap.set("n", "<leader>ss", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sv", ":split<CR>", { noremap = true, silent = true })

-- closing splits
vim.keymap.set("n", "<leader>sq", ":q<CR>", { noremap = true, silent = true })

-- resize to equal splits
vim.keymap.set("n", "<leader>s=", "<C-w>=", { noremap = true, silent = true })

-- manual resizing
vim.keymap.set("n", "<C-k>", ":resize +3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":resize -3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", ":vertical resize -3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", ":vertical resize +3<CR>", { noremap = true, silent = true })


-- Move between splits with <leader>h/j/k/l
vim.keymap.set("n", "<leader>sh", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sj", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sk", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sl", "<C-w>l", { noremap = true, silent = true })

-- Alternative Bindings for moving between tabs (easily with 1 hand)
vim.keymap.set("n", "<leader>sa", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sd", "<C-w>l", { noremap = true, silent = true })

-- navigation
vim.keymap.set("n", "<Tab>", "gt", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "gT", { noremap = true, silent = true })
-- open in new tab
vim.keymap.set("n", "<leader>tn", ":tabedit %<CR>", { desc = "Move current file to new tab" })
-- closing
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>", { desc = "Close current tab" })

-- for clearing out search highlighting
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true })
