return {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Ensure plenary is installed
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- Custom action to open all selected files, or current file if none selected
        local select_one_or_multi = function(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            local multi = picker:get_multi_selection()
            if not vim.tbl_isempty(multi) then
                actions.close(prompt_bufnr)
                for _, j in pairs(multi) do
                    if j.path ~= nil then
                        vim.cmd(string.format("%s %s", "edit", j.path))
                    end
                end
            else
                actions.select_default(prompt_bufnr)
            end
        end

        telescope.setup({
            -- Your Telescope config here
            defaults = {
                winblend = 0,
                border = true,
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<CR>"] = select_one_or_multi,
                    },
                    n = {
                        ["<CR>"] = select_one_or_multi,
                    },
                },
            },
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

        vim.keymap.set("n", "<leader>psr", function()
            local pattern = vim.fn.input("Live Grep (regex) > ")

            if pattern and pattern ~= "" then
                require("telescope.builtin").live_grep({
                    default_text = pattern,
                })
            end
        end, { desc = "telescope: live_grep regex search" })
    end
}
