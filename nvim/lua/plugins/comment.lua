return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    config = function(_, opts)
        require("Comment").setup(opts)

        -- Keymaps for Ctrl+/
        vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comments (normal mode)" })
        vim.keymap.set("x", "<C-_>", "gb", { remap = true, desc = "Toggle comments (visual mode)" })
    end
}
