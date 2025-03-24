return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- for adding the current file to the harpoon list
        vim.keymap.set("n", "<leader>aa", function() harpoon:list():add() end)

        -- for viewing the harpoon file list
        vim.keymap.set("n", "<leader>bm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- for navigating between 1-4 files in the harpoon list
        vim.keymap.set("n", "<leader>ba", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>bs", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>bd", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>bf", function() harpoon:list():select(4) end)
    end
}
