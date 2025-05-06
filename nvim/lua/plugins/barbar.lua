return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    config = function()
        require('barbar').setup {
            animation = true,
            auto_hide = false,
            tabpages = true,
            clickable = true,
            insert_at_end = true,
            sidebar_filetypes = {
                -- for nvim-tree offset
                NvimTree = true,
            },
        }

        -- example keymaps (optional)
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        -- Buffer navigation
        map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)       -- next buffer
        map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts) -- previous buffer

        -- Move buffers
        map('n', '<leader>bm', '<Cmd>BufferMoveNext<CR>', opts)     -- move right
        map('n', '<leader>bM', '<Cmd>BufferMovePrevious<CR>', opts) -- move left

        -- Close buffer
        map('n', '<leader>bd', '<Cmd>BufferClose<CR>', opts)

        -- Pick buffer
        map('n', '<leader>bb', '<Cmd>BufferPick<CR>', opts)

        -- Pin buffer
        map('n', '<leader>bp', '<Cmd>BufferPin<CR>', opts)

        -- Sort buffers
        map('n', '<leader>bsd', '<Cmd>BufferOrderByDirectory<CR>', opts)
        map('n', '<leader>bsl', '<Cmd>BufferOrderByLanguage<CR>', opts)
    end
}
