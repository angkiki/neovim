return {
    'mrloop/telescope-git-branch.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' }, -- Ensure telescope is loaded first
    enabled = false,
    config = function()
        local tele = require("telescope")
        tele.load_extension("git_branch")

        vim.keymap.set({ 'n', 'v' }, '<leader>gf', function()
            require('git_branch').files()
        end)
    end
}
