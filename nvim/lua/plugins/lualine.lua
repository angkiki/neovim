return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local ll = require("lualine")
        ll.setup({
            options = {
                theme = "ayu_dark"
            }
        })
    end
}
