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

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })

        -- ripgrep is needed to be installed for this to work
        -- to install in WSL:
        -- sudo apt install ripgrep -y
        -- to install in macOS
        -- brew install ripgrep
        vim.keymap.set("n", "<leader>ps", function()
            local search = vim.fn.input("Grep > ")
            if search and search ~= "" then
                builtin.grep_string({ search = search, cwd = vim.fn.getcwd() })
            end
        end)
    end
}
