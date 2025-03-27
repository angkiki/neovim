return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
        local ll = require("lsp_lines")
        ll.setup()

        vim.keymap.set("", "<leader>dl", ll.toggle, { desc = "Toggle lsp_lines" })

        vim.diagnostic.config({
            virtual_lines = {
                highlight_whole_line = false
            },
            virtual_text = false,
        })
    end
}
