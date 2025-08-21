return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Ensure plenary is installed
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            -- Your Telescope config here
            defaults = { winblend = 0, border = true },
        })

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "telescope: open raw file finder" })
        vim.keymap.set("n", "<C-p>", builtin.git_files,
            { desc = "telescope: open file finder within current git repository" })
        vim.keymap.set("n", "<leader>pb", ":Telescope buffers<CR>",
            { desc = "telescope: display files in current buffer " })

        -- ripgrep is needed to be installed for this to work
        -- to install in WSL:
        -- sudo apt install ripgrep -y
        -- to install in macOS
        -- brew install ripgrep
        vim.keymap.set("n", "<leader>pss", function()
            local search = vim.fn.input("Grep > ")
            if search and search ~= "" then
                builtin.grep_string({ search = search, cwd = vim.fn.getcwd(), fixed_strings = true })
            end
        end, { desc = "telescope: ripgrep string search, results displayed in telescope" })

        vim.keymap.set("n", "<leader>psl", function()
            -- live search using ripgrep's regex engine
            builtin.live_grep()
        end, { desc = "telescope: open live file search with fuzzy finder" })
    end
}
