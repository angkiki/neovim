return {
    'kyazdani42/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup({
            view = {
                width = 50, -- Width of the file explorer
            },
            git = {
                enable = true, -- Show git status icons
            },
            filters = {
                dotfiles = true, -- Show dotfiles
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
    end
}
