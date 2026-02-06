return {
    'backdround/global-note.nvim',
    config = function()
        local gn = require("global-note")
        gn.setup()

        vim.keymap.set("n", "<leader>nn", gn.toggle_note, { desc = "Toggle global note visibility" })
    end
}
