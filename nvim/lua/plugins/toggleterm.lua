return {
    "akinsho/toggleterm.nvim",
    config = function()
        local tt = require("toggleterm")
        tt.setup({
            size = function(term)
                if term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end

                return 20
            end
        })

        local term = require("toggleterm.terminal").Terminal
        local float_term = term:new({ direction = "float" })
        local vertical_term = term:new({ direction = "vertical", size = 500 })

        -- Helper function to exit terminal insert mode
        local function exit_terminal_mode()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
        end

        vim.keymap.set("n", "<leader>tt", function()
            float_term:toggle()
        end, { desc = "toggleterm: toggle display of floating terminal" })

        -- vim.keymap.set("n", "<leader>tv", function()
        --     vertical_term:toggle()
        -- end, { desc = "toggleterm: toggle display of vertical terminal" })

        vim.keymap.set("t", "<leader>tt", function()
            exit_terminal_mode()
            float_term:toggle()
        end, { desc = "toggleterm: toggle display of floating terminal (terminal mode)" })

        -- vim.keymap.set("t", "<leader>tv", function()
        --     exit_terminal_mode()
        --     vertical_term:toggle()
        -- end, { desc = "toggleterm: toggle display of vertical (terminal mode)" })

        -- function _G.set_terminal_keymaps()
        --     local opts = { buffer = 0 }
        --     vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        --     vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        --     vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        --     vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        --     vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        --     vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        --     vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        -- end
        --
        -- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        -- vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
    end,
}
