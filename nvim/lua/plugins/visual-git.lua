return {
    'tanvirtin/vgit.nvim',
    -- Trying lazygit for now
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = 'VimEnter',
    config = function()
        require("vgit").setup()
    end,
}
