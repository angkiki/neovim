return {
    'kyazdani42/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup({
            view = {
                width = 30, -- Width of the file explorer
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

        -- sets the keymap for triggering the nvim-tree
        vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
}
