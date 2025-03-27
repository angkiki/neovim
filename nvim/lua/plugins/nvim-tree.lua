return {
    'kyazdani42/nvim-tree.lua',
    config = function()
        local nt = require("nvim-tree")
        local api = require("nvim-tree.api")
        nt.setup({
            view = {
                width = 50, -- Width of the file explorer
            },
            git = {
                enable = true, -- Show git status icons
            },
            filters = {
                dotfiles = false, -- Show dotfiles
                git_ignored = false,
            },
        })

        -- changes nvim-tree to transparent background
        vim.cmd [[
            highlight NvimTreeNormal guibg=NONE ctermbg=NONE
            highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
        ]]

        -- for oepning and closing the nvim tree
        vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

        -- for moving the cursor in the tree to the current buffer
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

        -- for opening the file in a new split
        vim.keymap.set("n", "<leader>es", api.node.open.vertical, { noremap = true, silent = true })

        -- for opening the file in a new tab
        vim.keymap.set("n", "<leader>et", api.node.open.tab, { noremap = true, silent = true })
    end
}
